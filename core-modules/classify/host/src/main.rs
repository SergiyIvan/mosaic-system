use anyhow::Result;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;
use std::time::{Duration, Instant};
use std::io::Read;
use std::io::Cursor;

use image::imageops::FilterType;
use tract_onnx::prelude::*;

struct ModuleState {
    wasi: WasiP1Ctx,
    trampoline_time: Duration,
    compute_time: Duration,
}


fn main() -> Result<()> {
    let engine = Engine::default();
    let mut linker: Linker<ModuleState> = Linker::new(&engine);
    preview1::add_to_linker_sync(&mut linker, |state| &mut state.wasi)?;

    let module = Module::from_file(&engine, "../guest/target/wasm32-wasip1/release/guest.wasm")?;

    linker.func_wrap("env", "host_reset_time", |mut caller: Caller<'_, ModuleState>| {
        caller.data_mut().trampoline_time = Duration::ZERO;
        caller.data_mut().compute_time = Duration::ZERO;
    })?;

    linker.func_wrap("env", "host_get_trampoline_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().trampoline_time.as_nanos() as u64
    })?;

    linker.func_wrap("env", "host_get_compute_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().compute_time.as_nanos() as u64
    })?;

    // --- host_download ---
    linker.func_wrap("env", "host_download",
        |mut caller: Caller<'_, ModuleState>, url_ptr: i32, url_len: i32, out_ptr: i32, max_len: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let (data, _) = mem.data_and_store_mut(&mut caller);

        let url_str = match std::str::from_utf8(&data[url_ptr as usize..(url_ptr + url_len) as usize]) {
            Ok(s) => s,
            Err(_) => return 0,
        };

        let mut response = match ureq::get(url_str).call() {
            Ok(r) => r,
            Err(e) => {
                eprintln!("HTTP Request Failed: {}", e);
                return 0;
            }
        };

        let out_slice = &mut data[out_ptr as usize..(out_ptr + max_len) as usize];

        let mut reader = response.body_mut().as_reader();

        // Read in a loop until EOF (0 bytes returned) to ensure we get the whole file.
        let mut total_bytes_read = 0;
        loop {
            // Guard against buffer overflow.
            if total_bytes_read >= max_len as usize {
                eprintln!("Image exceeded max buffer size!");
                return 0;
            }

            match reader.read(&mut out_slice[total_bytes_read..]) {
                Ok(0) => break, // EOF reached, download complete.
                Ok(n) => total_bytes_read += n,
                Err(e) => {
                    eprintln!("Failed reading body stream: {}", e);
                    return 0;
                }
            }
        }

        total_bytes_read as u32
    })?;

    // --- host_infer ---
    linker.func_wrap("env", "host_infer",
        |mut caller: Caller<'_, ModuleState>,
         model_ptr: i32, model_len: i32,
         img_ptr: i32, img_len: i32| -> u32 {

        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let data = mem.data(&caller);
        let mem_len = data.len();

        let bounds_ok = (model_ptr as usize + model_len as usize <= mem_len) &&
                        (img_ptr as usize + img_len as usize <= mem_len);
        if !bounds_ok { return 0; }

        let model_slice = &data[model_ptr as usize..(model_ptr + model_len) as usize];
        let img_slice = &data[img_ptr as usize..(img_ptr + img_len) as usize];

        let tramp_duration = tramp_start.elapsed();
        let compute_start = Instant::now();

        let mut cursor = Cursor::new(model_slice);
        let model = match tract_onnx::onnx()
            .model_for_read(&mut cursor).unwrap()
            .into_optimized().unwrap()
            .into_runnable() {
                Ok(m) => m,
                Err(e) => { eprintln!("Model load failed: {:?}", e); return 0; }
        };

        // Image Preprocessing.
        let img = image::load_from_memory(img_slice).unwrap().to_rgb8();
        let resized = image::imageops::resize(&img, 256, 256, FilterType::Triangle);

        let crop_x = (256 - 224) / 2;
        let crop_y = (256 - 224) / 2;
        let cropped = image::imageops::crop_imm(&resized, crop_x, crop_y, 224, 224).to_image();

        // Tensor Creation (Tract re-exports ndarray).
        let mut tensor = tract_ndarray::Array4::<f32>::zeros((1, 3, 224, 224));
        let mean = [0.485, 0.456, 0.406];
        let std = [0.229, 0.224, 0.225];

        for (x, y, pixel) in cropped.enumerate_pixels() {
            for c in 0..3 {
                tensor[[0, c, y as usize, x as usize]] = (pixel[c] as f32 / 255.0 - mean[c]) / std[c];
            }
        }

        // Inference.
        let tract_tensor = tensor.into_tensor();
        let result = model.run(tvec!(tract_tensor.into())).unwrap();

        // Argmax (Find top prediction).
        let logits = result[0].to_array_view::<f32>().unwrap();

        let mut max_idx = 0;
        let mut max_val = logits[[0, 0]]; // ResNet output shape is [1, 1000].

        for i in 0..1000 {
            let val = logits[[0, i]];
            if val > max_val {
                max_val = val;
                max_idx = i;
            }
        }

        let compute_duration = compute_start.elapsed();

        caller.data_mut().trampoline_time += tramp_duration;
        caller.data_mut().compute_time += compute_duration;

        max_idx as u32
    })?;

    let wasi = WasiCtxBuilder::new().inherit_stdout().inherit_stderr().build_p1();
    let mut store = Store::new(&engine, ModuleState {
        wasi, trampoline_time: Duration::ZERO, compute_time: Duration::ZERO
    });

    let instance = linker.instantiate(&mut store, &module)?;
    let run = instance.get_typed_func::<(), u32>(&mut store, "run")?;
    run.call(&mut store, ())?;

    Ok(())
}
