use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;

use std::io::Read;


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

    // --- host_compress ---
    linker.func_wrap("env", "host_compress",
        |mut caller: Caller<'_, ModuleState>,
         in_ptr: i32, in_len: i32,
         out_ptr: i32, max_len: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let bounds_ok = (in_ptr as usize + in_len as usize <= mem_len) &&
                        (out_ptr as usize + max_len as usize <= mem_len);

        if !bounds_ok { return 0; }

        let bytes_written = unsafe {
            let in_slice = std::slice::from_raw_parts(base_ptr.add(in_ptr as usize), in_len as usize);
            let out_slice = std::slice::from_raw_parts_mut(base_ptr.add(out_ptr as usize), max_len as usize);

            // Compression Level: 3 is standard. We use 9 to make the CPU work a bit harder for the benchmark.
            let compression_level = 9;

            // compress_to_buffer writes directly from Wasm memory into Wasm memory.
            let res = zstd::bulk::compress_to_buffer(in_slice, out_slice, compression_level);

            match res {
                Ok(size) => size as u32,
                Err(_) => 0,
            }
        };

        bytes_written
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let benchmark_name = "compression";

    let args: Vec<String> = std::env::args().collect();
    let duration_seconds = args.get(1).and_then(|s| s.parse().ok()).unwrap_or(30);
    let warmup_iterations = args.get(2).and_then(|s| s.parse().ok()).unwrap_or(5);
    let wasm_path = args
        .get(3)
        .cloned()
        .unwrap_or_else(|| {
            // For cdylib, rustc replaces '-' with '_'. We replace it back here for the default path.
            let safe_filename = benchmark_name.replace("-", "_");
            format!("../guest/target/wasm32-wasip1/release/{}.wasm", safe_filename)
        });

    runner::benchmark_wasm(benchmark_name, &wasm_path, duration_seconds, warmup_iterations, register_host_funcs)
}
