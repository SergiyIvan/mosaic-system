use anyhow::Result;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;
use std::time::{Duration, Instant};
use std::io::Read;

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

    // --- host_upload ---
    linker.func_wrap("env", "host_upload",
        |mut caller: Caller<'_, ModuleState>,
         url_ptr: i32, url_len: i32,
         data_ptr: i32, data_len: i32| -> u32 {

        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let (data, _) = mem.data_and_store_mut(&mut caller);
        let mem_len = data.len();

        let bounds_ok = (url_ptr as usize + url_len as usize <= mem_len) &&
                        (data_ptr as usize + data_len as usize <= mem_len);
        if !bounds_ok { return 0; }

        let url_str = match std::str::from_utf8(&data[url_ptr as usize..(url_ptr + url_len) as usize]) {
            Ok(s) => s,
            Err(_) => return 0,
        };

        // Grab the slice directly from Wasm memory.
        let file_data = &data[data_ptr as usize..(data_ptr + data_len) as usize];

        let tramp_duration = tramp_start.elapsed();
        // Compute in this benchmark is more network and I/O rather than CPU computations.
        let compute_start = Instant::now();

        // Build the multipart payload structure expected by the upload server.
        let boundary = "----WasmZeroCopyBoundary123456789";
        let header = format!(
            "--{}\r\nContent-Disposition: form-data; name=\"file\"; filename=\"video.mp4\"\r\nContent-Type: application/octet-stream\r\n\r\n",
            boundary
        );
        let footer = format!("\r\n--{}--\r\n", boundary);

        // Pre-allocate the exact buffer size so we only copy into the host once.
        let mut body = Vec::with_capacity(header.len() + file_data.len() + footer.len());
        body.extend_from_slice(header.as_bytes());
        body.extend_from_slice(file_data);
        body.extend_from_slice(footer.as_bytes());

        let content_type = format!("multipart/form-data; boundary={}", boundary);

        let res = match ureq::post(url_str).header("Content-Type", &content_type).send(body) {
            Ok(response) => response.status().as_u16() as u32,
            Err(ureq::Error::StatusCode(code)) => {
                code as u32 // 4xx and 5xx codes.
            },
            Err(e) => {
                eprintln!("Upload failed: {}", e);
                0
            }
        };

        let compute_duration = compute_start.elapsed();
        caller.data_mut().trampoline_time += tramp_duration;
        caller.data_mut().compute_time += compute_duration;

        res
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
