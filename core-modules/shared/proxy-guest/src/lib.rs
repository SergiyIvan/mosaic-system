// Native proxy.

// The macro to automatically generate the C-ABI execution entry point.
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


// Mosaic proxy.

// The universal allocation function required by the Mosaic proxy.
// The Host calls this to reserve space in Wasm memory for the JSON input.
#[unsafe(no_mangle)]
pub extern "C" fn alloc(len: u32) -> *mut u8 {
    let mut buf = Vec::with_capacity(len as usize);
    let ptr = buf.as_mut_ptr();
    // Prevent Rust from freeing this memory, as the Host needs to write to it.
    std::mem::forget(buf);
    ptr
}

// The macro to automatically generate the C-ABI execution entry point.
#[macro_export]
macro_rules! export_mosaic_function {
    ($handler:expr) => {
        #[unsafe(no_mangle)]
        pub extern "C" fn run_proxy(input_ptr: u32, input_len: u32) -> u64 {
            // Read the JSON input string directly from Wasm memory (zero-copy).
            let input_slice = unsafe {
                std::slice::from_raw_parts(input_ptr as *const u8, input_len as usize)
            };
            let input_str = std::str::from_utf8(input_slice).unwrap_or("");

            // Call the function's handler.
            let output_string: String = $handler(input_str);

            // Convert the String into a raw byte slice and "leak" it.
            // It's safe to leak because the Mosaic proxy destroys the entire Wasm instance after reading.
            let leaked_bytes = output_string.into_bytes().leak();
            let out_ptr = leaked_bytes.as_ptr() as u64;
            let out_len = leaked_bytes.len() as u64;

            // Pack pointer and length into a single u64 to return to the proxy.
            (out_ptr << 32) | out_len
        }
    };
}
