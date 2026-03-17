use anyhow::Result;
use std::time::Instant;
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
        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 1 };
        let data = mem.data(&caller);

        let cmd_slice = &data[cmd_ptr as usize..(cmd_ptr + cmd_len) as usize];
        let cmd_str = std::str::from_utf8(cmd_slice).unwrap_or("");

        let tramp_duration = tramp_start.elapsed();
        let compute_start = Instant::now();

        // Executing via sh -c to allow complex arguments and piping natively.
        let status = Command::new("sh")
            .arg("-c")
            .arg(cmd_str)
            .status();

        let compute_duration = compute_start.elapsed();
        caller.data_mut().trampoline_time += tramp_duration;
        caller.data_mut().compute_time += compute_duration;

        if status.map_or(false, |s| s.success()) { 0 } else { 1 }
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let wasm_path = "../guest/target/wasm32-wasip1/release/guest.wasm";
    runner::run_wasm(wasm_path, register_host_funcs)
}
