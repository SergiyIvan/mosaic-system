use anyhow::Result;
use std::time::Instant;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;

use std::io::{Cursor, Read};
use image::imageops::FilterType;

fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

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

    // --- host_resize ---
    linker.func_wrap("env", "host_resize",
        |mut caller: Caller<'_, ModuleState>,
         in_ptr: i32, in_len: i32, w: i32, h: i32,
         out_ptr: i32, max_len: i32| -> u32 {

        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let (data, _) = mem.data_and_store_mut(&mut caller);

        let in_slice = &data[in_ptr as usize..(in_ptr + in_len) as usize];

        let tramp_duration1 = tramp_start.elapsed();
        let compute_start = Instant::now();

        // Decode image.
        let img = match image::load_from_memory(in_slice) {
            Ok(i) => i,
            Err(_) => return 0,
        };

        // Resize.
        // FilterType::Lanczos3 is high quality, should be CPU bound.
        let resized = img.resize(w as u32, h as u32, FilterType::Lanczos3);

        // Encode to JPEG.
        let mut jpeg_bytes: Vec<u8> = Vec::new();
        let mut cursor = Cursor::new(&mut jpeg_bytes);
        if resized.write_to(&mut cursor, image::ImageFormat::Jpeg).is_err() {
            return 0;
        }

        let compute_duration = compute_start.elapsed();
        let tramp_start2 = Instant::now();

        // Copy output back to Wasm Memory.
        if jpeg_bytes.len() > max_len as usize {
            return 0; // Output buffer too small.
        }

        let out_slice = &mut data[out_ptr as usize..(out_ptr as usize + jpeg_bytes.len())];
        out_slice.copy_from_slice(&jpeg_bytes);

        let tramp_duration2 = tramp_start2.elapsed();
        caller.data_mut().trampoline_time += tramp_duration1 + tramp_duration2;
        caller.data_mut().compute_time += compute_duration;

        jpeg_bytes.len() as u32
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let wasm_path = "../guest/target/wasm32-wasip1/release/guest.wasm";
    runner::run_wasm(wasm_path, register_host_funcs)
}
