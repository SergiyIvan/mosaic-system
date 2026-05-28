use minijinja::{Environment, context};
use chrono::Local;


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


#[unsafe(no_mangle)]
pub unsafe extern "C" fn trampoline_dispatch(
    func_name_ptr: *const u8,
    func_name_len: usize,
    mem_base: *mut u8,
    mem_len: usize,
    args_ptr: *const u64,
    args_len: usize,
    ret_ptr: *mut u64,
) -> bool {
    unsafe {
        let func_name_slice = std::slice::from_raw_parts(func_name_ptr, func_name_len);
        let func_name = std::str::from_utf8(func_name_slice).unwrap_or("");
        let args = std::slice::from_raw_parts(args_ptr, args_len);

        match func_name {
            "host_render" => {
                if args.len() != 8 { return false; }

                let template_ptr = args[0] as usize;
                let template_len = args[1] as usize;
                let username_ptr = args[2] as usize;
                let username_len = args[3] as usize;
                let rand_ptr = args[4] as usize;
                let rand_len = args[5] as usize;
                let out_ptr = args[6] as usize;
                let max_len = args[7] as usize;

                // Bounds check (rand_len is u32s, so x4).
                let bounds_ok = (template_ptr + template_len <= mem_len) &&
                                (username_ptr + username_len <= mem_len) &&
                                (rand_ptr + (rand_len * 4) <= mem_len) &&
                                (out_ptr + max_len <= mem_len);

                if !bounds_ok { return false; }

                let template_slice = std::slice::from_raw_parts(mem_base.add(template_ptr), template_len);
                let template_str = std::str::from_utf8(template_slice).unwrap_or("");

                let username_slice = std::slice::from_raw_parts(mem_base.add(username_ptr), username_len);
                let username_str = std::str::from_utf8(username_slice).unwrap_or("");

                let rand_slice = std::slice::from_raw_parts(mem_base.add(rand_ptr) as *const u32, rand_len);

                let out_slice = std::slice::from_raw_parts_mut(mem_base.add(out_ptr), max_len);

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                let mut writer = WasmBufferWriter { buffer: out_slice, pos: 0 };

                // Setting up MiniJinja and Render.
                let mut env = Environment::new();
                if env.add_template("tpl", template_str).is_err() {
                    *ret_ptr = 0;
                    return true;
                }
                let tmpl = env.get_template("tpl").unwrap();

                let cur_time = Local::now().format("%Y-%m-%d %H:%M:%S").to_string();

                let res = tmpl.render_captured_to(context! {
                    username => username_str,
                    cur_time => cur_time,
                    random_numbers => rand_slice,
                }, &mut writer);

                match res {
                    Ok(_) => *ret_ptr = writer.pos as u64,
                    Err(_) => *ret_ptr = 0,
                }

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_Render | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
