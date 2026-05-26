use pagerank_lib::pagerank;


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
            "host_pagerank" => {
                if args.len() != 5 { return false; }

                // Unpack Wasm arguments from the generic u64 array.
                let edges_ptr = args[0] as usize;
                let edges_len = args[1] as usize;
                let pr_ptr = args[2] as usize;
                let pr_len = args[3] as usize;
                let iterations = args[4] as u32;

                // Security bounds check. Both u32 and f32 are 4 bytes.
                let bounds_ok = (edges_ptr + (edges_len * 4) <= mem_len) &&
                                (pr_ptr + (pr_len * 4) <= mem_len);
                if !bounds_ok { return false; }

                // Reconstruct slices pointing directly to Wasm memory.
                let edges_slice = std::slice::from_raw_parts(
                    mem_base.add(edges_ptr) as *const u32,
                    edges_len,
                );
                let pr_slice = std::slice::from_raw_parts_mut(
                    mem_base.add(pr_ptr) as *mut f32, // Reconstruct as f32 array.
                    pr_len,
                );

                // Execute function.
                pagerank(edges_slice, pr_slice, iterations);

                // Write back return value. 1 means success.
                *ret_ptr = 1;
                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
