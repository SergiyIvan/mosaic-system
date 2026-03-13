use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;

use std::io::Read;
use std::process::Command;
use std::fs;

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

    // --- host_write_file ---
    linker.func_wrap("env", "host_write_file",
        |mut caller: Caller<'_, ModuleState>, path_ptr: i32, path_len: i32, data_ptr: i32, data_len: i32| -> u32 {
        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 1 };
        let data = mem.data(&caller);

        let path_slice = &data[path_ptr as usize..(path_ptr + path_len) as usize];
        let path_str = std::str::from_utf8(path_slice).unwrap_or("");

        let file_data = &data[data_ptr as usize..(data_ptr + data_len) as usize];
        let res = fs::write(path_str, file_data);
        if res.is_ok() { 0 } else { 1 }
    })?;

    // --- host_run_command ---
    linker.func_wrap("env", "host_run_command",
        |mut caller: Caller<'_, ModuleState>, cmd_ptr: i32, cmd_len: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 1 };
        let data = mem.data(&caller);

        let cmd_slice = &data[cmd_ptr as usize..(cmd_ptr + cmd_len) as usize];
        let cmd_str = std::str::from_utf8(cmd_slice).unwrap_or("");

        // Executing via sh -c to allow complex arguments and piping natively.
        let status = Command::new("sh")
            .arg("-c")
            .arg(cmd_str)
            .status();

        if status.map_or(false, |s| s.success()) { 0 } else { 1 }
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let wasm_path = "../guest/target/wasm32-wasip1/release/guest.wasm";

    let args: Vec<String> = std::env::args().collect();
    let duration_seconds = args.get(1).and_then(|s| s.parse().ok()).unwrap_or(30);
    let warmup_iterations = args.get(2).and_then(|s| s.parse().ok()).unwrap_or(5);

    runner::benchmark_wasm("video-processing", wasm_path, duration_seconds, warmup_iterations, register_host_funcs)
}
