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
            "host_file_exists" => {
                if args.len() != 2 { return false; }
                let path_ptr = args[0] as usize;
                let path_len = args[1] as usize;

                if path_ptr + path_len > mem_len { return false; }

                let path_slice = std::slice::from_raw_parts(mem_base.add(path_ptr), path_len);
                let path_str = std::str::from_utf8(path_slice).unwrap_or("");

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                *ret_ptr = if std::path::Path::new(path_str).exists() { 1 } else { 0 };

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_FileExists | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            "host_read_file" => {
                if args.len() != 4 { return false; }
                let path_ptr = args[0] as usize;
                let path_len = args[1] as usize;
                let out_ptr = args[2] as usize;
                let max_len = args[3] as usize;

                if path_ptr + path_len > mem_len || out_ptr + max_len > mem_len { return false; }

                let path_slice = std::slice::from_raw_parts(mem_base.add(path_ptr), path_len);
                let path_str = std::str::from_utf8(path_slice).unwrap_or("");

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                let mut file = match std::fs::File::open(path_str) {
                    Ok(f) => f,
                    Err(_) => {
                        *ret_ptr = 0;
                        return true;
                    }
                };

                let out_slice = std::slice::from_raw_parts_mut(mem_base.add(out_ptr), max_len);

                let mut total_bytes_read = 0;
                loop {
                    if total_bytes_read >= max_len {
                        break;
                    }

                    match std::io::Read::read(&mut file, &mut out_slice[total_bytes_read..]) {
                        Ok(0) => break, // EOF reached.
                        Ok(n) => total_bytes_read += n,
                        Err(ref e) if e.kind() == std::io::ErrorKind::Interrupted => continue,
                        Err(_) => {
                            *ret_ptr = 0;
                            return true;
                        }
                    }
                }

                *ret_ptr = total_bytes_read as u64;

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_ReadFile | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
