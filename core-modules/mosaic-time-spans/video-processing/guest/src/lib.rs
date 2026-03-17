use std::time::Instant;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL directly to a file path on the host. Returns bytes written or 0 on error.
    fn host_download_to_file(url_ptr: *const u8, url_len: u32, path_ptr: *const u8, path_len: u32) -> u32;

    // Executes a shell command on the host OS.
    fn host_run_command(cmd_ptr: *const u8, cmd_len: u32) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let video_url = "http://127.0.0.1:8000/video.mp4";
    let watermark_url = "http://127.0.0.1:8000/watermark.png";

    let video_path = "/tmp/video.mp4";
    let watermark_path = "/tmp/watermark.png";
    let ffmpeg_path = "/tmp/ffmpeg";
    let gif_output_path = "/tmp/processed.gif";
    let watermark_output_path = "/tmp/watermarked.mp4";

    eprintln!("=== SeBS Video Processing Benchmark ===");
    unsafe { host_reset_time(); }

    // Downloading.
    let download_start = Instant::now();

    let video_size = unsafe {
        host_download_to_file(
            video_url.as_ptr(), video_url.len() as u32,
            video_path.as_ptr(), video_path.len() as u32
        )
    };
    if video_size == 0 { eprintln!("Failed to download video."); return 1; }

    let watermark_size = unsafe {
        host_download_to_file(
            watermark_url.as_ptr(), watermark_url.len() as u32,
            watermark_path.as_ptr(), watermark_path.len() as u32
        )
    };
    if watermark_size == 0 { eprintln!("Failed to download watermark."); return 1; }

    let download_time = download_start.elapsed().as_micros() as f64;

    // Running FFmpeg.
    let process_start = Instant::now();

    // Command 1: Extract GIF (Duration: 5 seconds).
    let cmd_gif = format!(
        "{} -y -i {} -t 5 -vf 'fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse' -loop 0 {} > /dev/null 2>&1",
        ffmpeg_path, video_path, gif_output_path
    );

    // Command 2: Watermark (Duration: 5 seconds).
    let cmd_watermark = format!(
        "{} -y -i {} -i {} -t 5 -filter_complex 'overlay=main_w/2-overlay_w/2:main_h/2-overlay_h/2' {} > /dev/null 2>&1",
        ffmpeg_path, video_path, watermark_path, watermark_output_path
    );

    unsafe {
        if host_run_command(cmd_gif.as_ptr(), cmd_gif.len() as u32) != 0 {
            eprintln!("FFmpeg GIF generation failed"); return 1;
        }
        if host_run_command(cmd_watermark.as_ptr(), cmd_watermark.len() as u32) != 0 {
            eprintln!("FFmpeg Watermarking failed"); return 1;
        }
    }

    let process_time = process_start.elapsed().as_micros() as f64;

    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    eprintln!("Success! Video processed.");
    println!("{{");
    println!("  \"benchmark\": \"video-processing\",");
    println!("  \"measurement\": {{");
    println!("    \"download_time_us\": {:.2},", download_time);  // Includes only the download part - calculated on guest.
    println!("    \"download_size\": {},", video_size + watermark_size);
    println!("    \"process_time_us\": {:.2},", process_time);  // Includes guest and host code - without download.
    println!("    \"breakdown\": {{");
    println!("      \"host_compute_us\": {:.2},", host_compute_us);
    println!("      \"host_trampoline_us\": {:.2},", host_trampoline_us);
    println!("      \"wasm_overhead_us\": {:.2}", wasm_overhead_us);
    println!("    }}");
    println!("  }}");
    println!("}}");

    0
}
