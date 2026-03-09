use std::time::Instant;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Compresses data from in_ptr to out_ptr using Zstandard.
    // Returns compressed size in bytes, or 0 on error.
    fn host_compress(
        in_ptr: *const u8, in_len: u32,
        out_ptr: *mut u8, max_len: u32
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

const MAX_INPUT_SIZE: usize = 10 * 1024 * 1024;  // 10 MB max input
const MAX_OUTPUT_SIZE: usize = 10 * 1024 * 1024; // 10 MB max output

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let input_url = "http://127.0.0.1:8000/video.mp4";

    println!("=== SeBS Compression Benchmark (Zstandard) ===");
    unsafe { host_reset_time(); }

    // Downloading.
    let download_start = Instant::now();
    let mut uncompressed_buf = vec![0u8; MAX_INPUT_SIZE];

    let uncompressed_size = unsafe {
        host_download(
            input_url.as_ptr(), input_url.len() as u32,
            uncompressed_buf.as_mut_ptr(), MAX_INPUT_SIZE as u32
        )
    };

    let download_time = download_start.elapsed().as_micros() as f64;

    if uncompressed_size == 0 {
        eprintln!("Failed to download input.");
        return 1;
    }

    // Compressing.
    let process_start = Instant::now();
    let mut compressed_buf = vec![0u8; MAX_OUTPUT_SIZE];

    let compressed_size = unsafe {
        host_compress(
            uncompressed_buf.as_ptr(), uncompressed_size,
            compressed_buf.as_mut_ptr(), MAX_OUTPUT_SIZE as u32
        )
    };

    let process_time = process_start.elapsed().as_micros() as f64;

    if compressed_size == 0 {
        eprintln!("Failed to compress input.");
        return 1;
    }

    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    let compression_ratio = uncompressed_size as f64 / compressed_size as f64;

    println!("Success! Dataset compressed.");
    println!("{{");
    println!("  \"measurement\": {{");
    println!("    \"download_time_us\": {:.2},", download_time);  // Includes only the download part - calculated on guest.
    println!("    \"download_size\": {},", uncompressed_size);
    println!("    \"process_time_us\": {:.2},", process_time);  // Includes guest and host code - without download.
    println!("    \"upload_size\": {},", compressed_size);
    println!("    \"compression_ratio\": {:.2},", compression_ratio);
    println!("    \"breakdown\": {{");
    println!("      \"host_compute_us\": {:.2},", host_compute_us);
    println!("      \"host_trampoline_us\": {:.2},", host_trampoline_us);
    println!("      \"wasm_overhead_us\": {:.2}", wasm_overhead_us);
    println!("    }}");
    println!("  }}");
    println!("}}");

    0
}
