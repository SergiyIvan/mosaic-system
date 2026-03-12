use std::time::Instant;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Uploads the Wasm memory buffer directly to a remote server.
    // Returns HTTP response code or 0 in case of failure.
    fn host_upload(
        url_ptr: *const u8, url_len: u32,
        data_ptr: *const u8, data_len: u32
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

const MAX_FILE_SIZE: usize = 5 * 1024 * 1024; // 5 MB

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let download_url = "http://127.0.0.1:8000/video.mp4";
    let upload_url = "http://127.0.0.1:9696/upload";

    eprintln!("=== SeBS Uploader Benchmark ===");
    unsafe { host_reset_time(); }

    // Downloading.
    let download_start = Instant::now();
    let mut media_buf = vec![0u8; MAX_FILE_SIZE];

    let downloaded_size = unsafe {
        host_download(
            download_url.as_ptr(), download_url.len() as u32,
            media_buf.as_mut_ptr(), MAX_FILE_SIZE as u32
        )
    };

    let download_time = download_start.elapsed().as_micros() as f64;

    if downloaded_size == 0 {
        eprintln!("Failed to download input.");
        return 1;
    }

    // Uploading.
    let process_start = Instant::now();

    let response_code = unsafe {
        host_upload(
            upload_url.as_ptr(), upload_url.len() as u32,
            media_buf.as_ptr(), downloaded_size
        )
    };

    let process_time = process_start.elapsed().as_micros() as f64;

    eprintln!("{}", response_code);
    if response_code != 201 && response_code != 409 {
        eprintln!("Failed to upload input.");
        return 1;
    }

    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    eprintln!("Success! File uploaded.");
    println!("{{");
    println!("  \"benchmark\": \"uploader\",");
    println!("  \"measurement\": {{");
    println!("    \"download_time_us\": {:.2},", download_time);  // Includes only the download part - calculated on guest.
    println!("    \"download_size\": {},", downloaded_size);
    println!("    \"process_time_us\": {:.2},", process_time);  // Includes guest and host code - without download.
    println!("    \"upload_size\": {},", downloaded_size);
    println!("    \"breakdown\": {{");
    println!("      \"host_compute_us\": {:.2},", host_compute_us);
    println!("      \"host_trampoline_us\": {:.2},", host_trampoline_us);
    println!("      \"wasm_overhead_us\": {:.2}", wasm_overhead_us);
    println!("    }}");
    println!("  }}");
    println!("}}");

    0
}
