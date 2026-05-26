use std::process::Command;


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
            "host_run_command" => {
                if args.len() != 2 { return false; }
                let cmd_ptr = args[0] as usize;
                let cmd_len = args[1] as usize;

                if cmd_ptr + cmd_len > mem_len { return false; }

                let cmd_slice = std::slice::from_raw_parts(mem_base.add(cmd_ptr), cmd_len);
                let cmd_str = std::str::from_utf8(cmd_slice).unwrap_or("");

                let status = Command::new("sh")
                    .arg("-c")
                    .arg(cmd_str)
                    .status();

                // 0 indicates success in bash logic
                *ret_ptr = if status.map_or(false, |s| s.success()) { 0 } else { 1 };
                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
