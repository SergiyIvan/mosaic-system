use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;

use std::process::Command;

fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

    // --- host_download_to_file ---
    linker.func_wrap("env", "host_download_to_file",
        |mut caller: Caller<'_, ModuleState>,
         url_ptr: i32, url_len: i32,
         path_ptr: i32, path_len: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let data = mem.data(&caller);

        let url_str = match std::str::from_utf8(&data[url_ptr as usize..(url_ptr + url_len) as usize]) {
            Ok(s) => s,
            Err(_) => return 0,
        };

        let path_str = match std::str::from_utf8(&data[path_ptr as usize..(path_ptr + path_len) as usize]) {
            Ok(s) => s,
            Err(_) => return 0,
        };

        // Make the HTTP request.
        let mut response = match ureq::get(url_str).call() {
            Ok(r) => r,
            Err(e) => {
                eprintln!("HTTP Request Failed: {}", e);
                return 0;
            }
        };

        // Create the file on the host OS.
        let mut file = match std::fs::File::create(path_str) {
            Ok(f) => f,
            Err(e) => {
                eprintln!("Failed to create file: {}", e);
                return 0;
            }
        };

        let mut reader = response.body_mut().as_reader();

        // Stream directly from network to disk.
        match std::io::copy(&mut reader, &mut file) {
            Ok(bytes_written) => bytes_written as u32,
            Err(e) => {
                eprintln!("Failed to write stream to disk: {}", e);
                0
            }
        }
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
