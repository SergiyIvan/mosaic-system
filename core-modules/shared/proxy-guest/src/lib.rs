#[macro_export]
macro_rules! export_function {
    ($handler:expr) => {
        #[unsafe(no_mangle)]
        pub extern "C" fn run_proxy(
            input_ptr: *const u8,
            input_len: usize,
            out_ptr: *mut u8,
            max_out_len: usize,
        ) -> usize {
            // Read input string.
            let input_slice = unsafe { std::slice::from_raw_parts(input_ptr, input_len) };
            let input_str = std::str::from_utf8(input_slice).unwrap_or("");

            // Call the function.
            let output_string: String = $handler(input_str);
            let out_bytes = output_string.as_bytes();

            // Copy to output buffer (truncating if necessary).
            let write_len = std::cmp::min(out_bytes.len(), max_out_len);
            let out_slice = unsafe { std::slice::from_raw_parts_mut(out_ptr, max_out_len) };

            out_slice[..write_len].copy_from_slice(&out_bytes[..write_len]);

            write_len
        }
    };
}
