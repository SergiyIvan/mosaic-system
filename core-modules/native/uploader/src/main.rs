use std::time::{Duration, Instant};
use std::io::Read;


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

fn upload(url: &str, file_data: &[u8]) -> u32 {
    let boundary = "----WasmZeroCopyBoundary123456789";
    let header = format!(
        "--{}\r\nContent-Disposition: form-data; name=\"file\"; filename=\"video.mp4\"\r\nContent-Type: application/octet-stream\r\n\r\n",
        boundary
    );
    let footer = format!("\r\n--{}--\r\n", boundary);

    // Pre-allocate the exact buffer size
    let mut body = Vec::with_capacity(header.len() + file_data.len() + footer.len());
    body.extend_from_slice(header.as_bytes());
    body.extend_from_slice(file_data);
    body.extend_from_slice(footer.as_bytes());

    let content_type = format!("multipart/form-data; boundary={}", boundary);

    let res = match ureq::post(url).header("Content-Type", &content_type).send(body) {
        Ok(response) => response.status().as_u16() as u32,
        Err(ureq::Error::StatusCode(code)) => code as u32, // 4xx and 5xx codes.
        Err(e) => {
            eprintln!("Upload failed: {}", e);
            0
        }
    };

    res
}

fn run() -> u32 {
    let download_url = "http://127.0.0.1:8000/video.mp4";
    let upload_url = "http://127.0.0.1:9696/upload";

    let max_file_size = 5 * 1024 * 1024; // 5 MB

    // Downloading.
    let mut media_buf = vec![0u8; max_file_size];
    let downloaded_size = download(download_url, &mut media_buf);

    if downloaded_size == 0 {
        eprintln!("Failed to download input.");
        return 1;
    }

    // Uploading.
    let response_code = upload(upload_url, &media_buf[..downloaded_size]);

    if response_code != 201 && response_code != 409 {
        eprintln!("Failed to upload input. Response code: {}", response_code);
        return 1;
    }

    0
}

fn main() {
    let benchmark_name = "uploader";
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
