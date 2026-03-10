use std::time::Instant;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Resizes image. Returns actual byte size of the output image, or 0 on error.
    fn host_resize(
        in_ptr: *const u8, in_len: u32,
        w: u32, h: u32,
        out_ptr: *mut u8, max_len: u32,
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

const MAX_IMAGE_SIZE: usize = 15 * 1024 * 1024; // 15 MB.

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let url = "http://127.0.0.1:8000/snap.png";
    let target_width = 200;
    let target_height = 200;

    eprintln!("=== SeBS Thumbnailer Benchmark ===");

    unsafe { host_reset_time(); }

    let mut download_buf = vec![0u8; MAX_IMAGE_SIZE];
    let mut resize_buf = vec![0u8; MAX_IMAGE_SIZE];

    // Download Phase.
    let download_start = Instant::now();
    let download_size = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            download_buf.as_mut_ptr(), MAX_IMAGE_SIZE as u32
        )
    };
    let download_time = download_start.elapsed().as_micros() as f64;

    if download_size == 0 {
        eprintln!("Failed to download image.");
        return 1;
    }

    // Compute (Resize) Phase.
    let process_start = Instant::now();
    let resized_size = unsafe {
        host_resize(
            download_buf.as_ptr(), download_size,
            target_width, target_height,
            resize_buf.as_mut_ptr(), MAX_IMAGE_SIZE as u32
        )
    };
    let process_time = process_start.elapsed().as_micros() as f64;

    if resized_size == 0 {
        eprintln!("Failed to resize image.");
        return 1;
    }

    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    eprintln!("Success! Image processed.");
    println!("{{");
    println!("  \"benchmark\": \"thumbnailer\",");
    println!("  \"measurement\": {{");
    println!("    \"download_time_us\": {:.2},", download_time);  // Includes only the download part - calculated on guest.
    println!("    \"download_size\": {},", download_size);
    println!("    \"process_time_us\": {:.2},", process_time);  // Includes guest and host code - without download.
    println!("    \"upload_size\": {},", resized_size);
    println!("    \"breakdown\": {{");
    println!("      \"host_compute_us\": {:.2},", host_compute_us);
    println!("      \"host_trampoline_us\": {:.2},", host_trampoline_us);
    println!("      \"wasm_overhead_us\": {:.2}", wasm_overhead_us);
    println!("    }}");
    println!("  }}");
    println!("}}");

    0
}
