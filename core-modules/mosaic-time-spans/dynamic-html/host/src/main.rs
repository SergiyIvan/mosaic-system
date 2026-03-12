use anyhow::Result;
use std::time::Instant;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;

use minijinja::{Environment, context};
use chrono::Local;
use std::io::Read;


// A wrapper to allow MiniJinja to write bytes directly into a raw Wasm byte buffer.
struct WasmBufferWriter<'a> {
    buffer: &'a mut [u8],
    pos: usize,
}

impl<'a> std::io::Write for WasmBufferWriter<'a> {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        let len = buf.len();

        // Guard against Wasm buffer overflow.
        if self.pos + len > self.buffer.len() {
            return Err(std::io::Error::new(
                std::io::ErrorKind::WriteZero,
                "Wasm buffer overflow",
            ));
        }

        // Copy the byte chunk directly into the Wasm memory slice.
        self.buffer[self.pos..self.pos + len].copy_from_slice(buf);
        self.pos += len;

        Ok(len) // Return the number of bytes written.
    }

    fn flush(&mut self) -> std::io::Result<()> {
        // We don't have an intermediate buffer to flush, so this is a no-op.
        Ok(())
    }
}


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

    // --- host_render ---
    linker.func_wrap("env", "host_render",
        |mut caller: Caller<'_, ModuleState>,
         template_ptr: i32, template_len: i32,
         username_ptr: i32, username_len: i32,
         rand_ptr: i32, rand_len: i32,
         out_ptr: i32, max_len: i32| -> u32 {

        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let bounds_ok = (template_ptr as usize + template_len as usize <= mem_len) &&
                        (username_ptr as usize + username_len as usize <= mem_len) &&
                        (rand_ptr as usize + (rand_len as usize * 4) <= mem_len) &&
                        (out_ptr as usize + max_len as usize <= mem_len);

        if !bounds_ok { return 0; }

        let bytes_written = unsafe {
            let template_slice = std::slice::from_raw_parts(base_ptr.add(template_ptr as usize), template_len as usize);
            let template_str = std::str::from_utf8(template_slice).unwrap_or("");

            let username_slice = std::slice::from_raw_parts(base_ptr.add(username_ptr as usize), username_len as usize);
            let username_str = std::str::from_utf8(username_slice).unwrap_or("");

            let rand_ptr_actual = base_ptr.add(rand_ptr as usize) as *const u32;
            let random_numbers = std::slice::from_raw_parts(rand_ptr_actual, rand_len as usize);

            // Create a mutable slice for the Wasm output buffer.
            let out_slice = std::slice::from_raw_parts_mut(base_ptr.add(out_ptr as usize), max_len as usize);
            let mut writer = WasmBufferWriter { buffer: out_slice, pos: 0 };

            let tramp_duration = tramp_start.elapsed();
            let compute_start = Instant::now();

            let mut env = Environment::new();
            if env.add_template("tpl", template_str).is_err() { return 0; }
            let tmpl = env.get_template("tpl").unwrap();

            let cur_time = Local::now().format("%Y-%m-%d %H:%M:%S").to_string();

            let res = tmpl.render_to_write(context! {
                username => username_str,
                cur_time => cur_time,
                random_numbers => random_numbers,
            }, &mut writer);

            let compute_duration = compute_start.elapsed();
            caller.data_mut().trampoline_time += tramp_duration;
            caller.data_mut().compute_time += compute_duration;

            match res {
                Ok(_) => writer.pos as u32, // Return exact bytes written.
                Err(_) => 0,
            }
        };

        bytes_written
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let wasm_path = "../guest/target/wasm32-wasip1/release/guest.wasm";
    runner::run_wasm(wasm_path, register_host_funcs)
}
