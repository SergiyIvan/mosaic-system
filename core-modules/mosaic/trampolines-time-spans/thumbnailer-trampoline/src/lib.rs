use std::io::Cursor;
use image::imageops::FilterType;


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
            "host_resize" => {
                if args.len() != 6 { return false; }

                let in_ptr = args[0] as usize;
                let in_len = args[1] as usize;
                let w = args[2] as u32;
                let h = args[3] as u32;
                let out_ptr = args[4] as usize;
                let max_len = args[5] as usize;

                let bounds_ok = (in_ptr + in_len <= mem_len) &&
                                (out_ptr + max_len <= mem_len);
                if !bounds_ok { return false; }

                let in_slice = std::slice::from_raw_parts(mem_base.add(in_ptr), in_len);

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                let img = match image::load_from_memory(in_slice) {
                    Ok(i) => i,
                    Err(_) => {
                        *ret_ptr = 0;
                        return true;
                    }
                };

                // FilterType::Lanczos3 is high quality, should be CPU bound.
                let resized = img.resize(w, h, FilterType::Lanczos3);

                let out_slice = std::slice::from_raw_parts_mut(mem_base.add(out_ptr), max_len);
                let mut cursor = Cursor::new(out_slice);

                if resized.write_to(&mut cursor, image::ImageFormat::Jpeg).is_err() {
                    *ret_ptr = 0;
                } else {
                    *ret_ptr = cursor.position() as u64;
                }

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_Resize | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
