use squiggle_lib::squiggle_transform;


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
            "host_squiggle_transform" => {
                if args.len() != 4 { return false; }
                let in_ptr = args[0] as usize;
                let in_len = args[1] as usize;
                let out_ptr = args[2] as usize;
                let max_len = args[3] as usize;

                let bounds_ok = (in_ptr + in_len <= mem_len) &&
                                (out_ptr + max_len <= mem_len);
                if !bounds_ok { return false; }

                let in_slice = std::slice::from_raw_parts(mem_base.add(in_ptr), in_len);
                let out_slice = std::slice::from_raw_parts_mut(mem_base.add(out_ptr), max_len);

                let json_size = squiggle_transform(in_slice, out_slice);
                *ret_ptr = json_size as u64;
                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
