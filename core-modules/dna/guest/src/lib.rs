use std::time::Instant;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Transforms FASTA data into Squiggle JSON. Returns the size of the generated JSON in bytes, or 0 on error.
    fn host_squiggle(
        in_ptr: *const u8, in_len: u32,
        out_ptr: *mut u8, max_len: u32
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

const MAX_FASTA_SIZE: usize = 20 * 1024 * 1024; // 20 MB input.
const MAX_JSON_SIZE: usize = 200 * 1024 * 1024; // 200 MB output.

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let url = "http://127.0.0.1:8000/bacillus_subtilis.fasta";

    println!("=== SeBS DNA Visualization Benchmark ===");
    unsafe { host_reset_time(); }

    // Downloading.
    let download_start = Instant::now();
    let mut fasta_buf = vec![0u8; MAX_FASTA_SIZE];

    let fasta_size = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            fasta_buf.as_mut_ptr(), MAX_FASTA_SIZE as u32
        )
    };

    let download_time = download_start.elapsed().as_micros() as f64;

    if fasta_size == 0 {
        eprintln!("Failed to download FASTA sequence.");
        return 1;
    }

    // DNA Visualization.
    let process_start = Instant::now();
    let mut json_buf = vec![0u8; MAX_JSON_SIZE];

    let json_size = unsafe {
        host_squiggle(
            fasta_buf.as_ptr(), fasta_size,
            json_buf.as_mut_ptr(), MAX_JSON_SIZE as u32
        )
    };

    let process_time = process_start.elapsed().as_micros() as f64;

    if json_size == 0 {
        eprintln!("Squiggle transformation failed or buffer too small.");
        return 1;
    }

    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    println!("Success! DNA sequence transformed to 2D coordinates.");
    println!("{{");
    println!("  \"measurement\": {{");
    println!("    \"download_time_us\": {:.2},", download_time);
    println!("    \"download_size\": {},", fasta_size);
    println!("    \"process_time_us\": {:.2},", process_time);
    println!("    \"upload_size\": {},", json_size); // Mimicking the size of the payload we'd upload.
    println!("    \"breakdown\": {{");
    println!("      \"host_compute_us\": {:.2},", host_compute_us);
    println!("      \"host_trampoline_us\": {:.2},", host_trampoline_us);
    println!("      \"wasm_overhead_us\": {:.2}", wasm_overhead_us);
    println!("    }}");
    println!("  }}");
    println!("}}");

    0
}
