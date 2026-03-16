use std::time::{Duration, Instant};
use std::io::{Read, Cursor};
use image::imageops::FilterType;


fn download(url: &str, out_buf: &mut [u8]) -> usize {
    let mut response = match ureq::get(url).call() {
        Ok(r) => r,
        Err(e) => {
            eprintln!("HTTP Request Failed: {}", e);
            return 0;
        }
    };

    let mut reader = response.body_mut().as_reader();
    let mut total_bytes_read = 0;

    loop {
        if total_bytes_read >= out_buf.len() {
            eprintln!("Exceeded max buffer size!");
            return 0;
        }

        match reader.read(&mut out_buf[total_bytes_read..]) {
            Ok(0) => break, // EOF reached, download complete.
            Ok(n) => total_bytes_read += n,
            Err(e) => {
                eprintln!("Failed reading body stream: {}", e);
                return 0;
            }
        }
    }

    total_bytes_read
}

fn resize(in_data: &[u8], w: u32, h: u32, out_buf: &mut [u8]) -> usize {
    let img = match image::load_from_memory(in_data) {
        Ok(i) => i,
        Err(e) => {
            eprintln!("Failed to decode image: {}", e);
            return 0;
        }
    };

    let resized = img.resize(w, h, FilterType::Lanczos3);

    let mut cursor = Cursor::new(out_buf);
    match resized.write_to(&mut cursor, image::ImageFormat::Jpeg) {
        Ok(_) => cursor.position() as usize,
        Err(e) => {
            eprintln!("Failed to encode JPEG: {}", e);
            0
        }
    }
}

fn run() -> u32 {
    let url = "http://127.0.0.1:8000/snap.png";
    let target_width = 200;
    let target_height = 200;

    let max_image_size = 15 * 1024 * 1024; // 15 MB

    // Downloading.
    let mut download_buf = vec![0u8; max_image_size];
    let download_size = download(url, &mut download_buf);

    if download_size == 0 {
        eprintln!("Failed to download image.");
        return 1;
    }

    // Resizing.
    let mut resize_buf = vec![0u8; max_image_size];
    let resized_size = resize(
        &download_buf[..download_size],
        target_width,
        target_height,
        &mut resize_buf
    );

    if resized_size == 0 {
        eprintln!("Failed to resize image.");
        return 1;
    }

    0
}

fn main() {
    let benchmark_name = "thumbnailer";
    let args: Vec<String> = std::env::args().collect();

    // If duration and warmup are provided, run the throughput benchmark.
    if args.len() >= 3 {
        let duration_seconds: u64 = args[1].parse().unwrap_or(30);
        let warmup_iterations: u32 = args[2].parse().unwrap_or(5);

        eprintln!("==> Starting Warmup ({} iterations)...", warmup_iterations);
        for _ in 0..warmup_iterations {
            if run() != 0 {
                eprintln!("Warning: run() returned non-zero status.");
            }
        }

        eprintln!("==> Running Benchmark for {} seconds...", duration_seconds);
        let mut iterations = 0;
        let start_time = Instant::now();
        let target_duration = Duration::from_secs(duration_seconds);

        while start_time.elapsed() < target_duration {
            if run() != 0 {
                eprintln!("Warning: run() returned non-zero status.");
            }
            iterations += 1;
        }

        let elapsed = start_time.elapsed().as_secs_f64();
        let rps = iterations as f64 / elapsed;

        // Print the strictly formatted JSON to stdout
        println!("{{");
        println!("  \"benchmark\": \"{}\",", benchmark_name);
        println!("  \"duration_seconds\": {:.2},", elapsed);
        println!("  \"iterations\": {},", iterations);
        println!("  \"throughput_rps\": {:.2}", rps);
        println!("}}");

    } else {
        eprintln!("==> Running Single Native Invocation...");
        let start_time = Instant::now();
        let res = run();
        let elapsed = start_time.elapsed();

        if res == 0 {
            eprintln!("Success! Execution time: {:?}", elapsed);
        } else {
            eprintln!("Failed! Execution time: {:?}", elapsed);
        }
    }
}
