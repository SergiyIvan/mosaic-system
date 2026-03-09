use std::time::Instant;
use rand::Rng;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Renders the template. Returns actual byte size of the HTML output, or 0 on error.
    fn host_render(
        template_ptr: *const u8, template_len: u32,
        username_ptr: *const u8, username_len: u32,
        rand_ptr: *const u32, rand_len: u32, // rand_len is number of elements, not bytes.
        out_ptr: *mut u8, max_len: u32,
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

const MAX_TEMPLATE_SIZE: usize = 1 * 1024; // 1 KB
const MAX_HTML_SIZE: usize = 100 * 1024 * 1024; // 1 MB

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let compute_start1 = Instant::now();
    let url = "http://127.0.0.1:8000/template.html";
    let username = "rbruno";
    let random_len = 1_000_000;

    println!("=== SeBS Dynamic HTML Benchmark ===");
    unsafe { host_reset_time(); }

    // Generating random numbers.
    let mut random_numbers = vec![0u32; random_len];
    let mut rng = rand::thread_rng();
    for n in random_numbers.iter_mut() {
        *n = rng.gen_range(0..1_000_000);
    }

    // Downloading template.
    let mut template_buf = vec![0u8; MAX_TEMPLATE_SIZE];

    let compute_duration = compute_start1.elapsed().as_micros() as f64;
    let download_start = Instant::now();

    let template_size = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            template_buf.as_mut_ptr(), MAX_TEMPLATE_SIZE as u32
        )
    };
    let download_time = download_start.elapsed().as_micros() as f64;

    if template_size == 0 {
        eprintln!("Failed to download template.");
        return 1;
    }

    // Generating the HTML.
    let compute_start2 = Instant::now();
    let mut html_buf = vec![0u8; MAX_HTML_SIZE];

    let html_size = unsafe {
        host_render(
            template_buf.as_ptr(), template_size,
            username.as_ptr(), username.len() as u32,
            random_numbers.as_ptr(), random_len as u32,
            html_buf.as_mut_ptr(), MAX_HTML_SIZE as u32
        )
    };
    let compute_duration2 = compute_start2.elapsed().as_micros() as f64;

    if html_size == 0 {
        eprintln!("Failed to render HTML.");
        return 1;
    }

    let process_time = compute_duration + compute_duration2;
    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    println!("Success! Template rendered.");
    println!("{{");
    println!("  \"measurement\": {{");
    println!("    \"download_time_us\": {:.2},", download_time);  // Includes only the download part - calculated on guest.
    println!("    \"download_size\": {},", template_size);
    println!("    \"process_time_us\": {:.2},", process_time);  // Includes guest and host code - without download.
    println!("    \"upload_size\": {},", html_size);
    println!("    \"breakdown\": {{");
    println!("      \"host_compute_us\": {:.2},", host_compute_us);
    println!("      \"host_trampoline_us\": {:.2},", host_trampoline_us);
    println!("      \"wasm_overhead_us\": {:.2}", wasm_overhead_us);
    println!("    }}");
    println!("  }}");
    println!("}}");

    0
}
