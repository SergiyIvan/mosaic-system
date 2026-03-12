use anyhow::Result;
use std::time::Instant;
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
        // Note - we don't count time spans here because in the guest it is already counted as download time.
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
