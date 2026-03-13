use std::time::{Duration, Instant};
use std::io::{Read, Cursor};
use serde::Serialize;

#[derive(Serialize)]
struct SquiggleOutput {
    x: Vec<f64>,
    y: Vec<f64>,
}


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

fn squiggle(fasta_data: &[u8], out_buf: &mut [u8]) -> usize {
    let fasta_str = std::str::from_utf8(fasta_data).unwrap_or("");

    // Pre-allocate to avoid slow vector resizing during computation.
    // 2 points per nucleotide + 1 start point.
    let estimated_capacity = fasta_str.len() * 2;
    let mut x_coords = Vec::with_capacity(estimated_capacity);
    let mut y_coords = Vec::with_capacity(estimated_capacity);

    let mut cur_x = 0.0;
    let mut cur_y = 0.0;

    x_coords.push(cur_x);
    y_coords.push(cur_y);

    // Squiggle algorithm loop.
    for line in fasta_str.lines() {
        // Ignore FASTA headers.
        if line.starts_with('>') { continue; }

        for b in line.bytes() {
            match b {
                b'A' | b'a' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y + 0.5);
                    cur_x += 1.0;               // cur_y += 0.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                b'C' | b'c' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y - 0.5);
                    cur_x += 1.0;               // cur_y += 0.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                b'G' | b'g' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y + 0.5);
                    cur_x += 1.0;               cur_y += 1.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                b'T' | b't' | b'U' | b'u' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y - 0.5);
                    cur_x += 1.0;               cur_y -= 1.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                _ => {} // Ignore whitespace, 'N', or unrecognized characters.
            }
        }
    }

    let result = SquiggleOutput { x: x_coords, y: y_coords };

    // Use a Cursor to serialize directly into the pre-allocated slice.
    let mut cursor = Cursor::new(out_buf);
    match serde_json::to_writer(&mut cursor, &result) {
        Ok(_) => cursor.position() as usize,
        Err(_) => 0,
    }
}

fn run() -> u32 {
    let url = "http://127.0.0.1:8000/bacillus_subtilis.fasta";

    let max_fasta_size = 20 * 1024 * 1024; // 20 MB input.
    let max_json_size = 200 * 1024 * 1024; // 200 MB output.

    // Downloading.
    let mut fasta_buf = vec![0u8; max_fasta_size];
    let fasta_size = download(url, &mut fasta_buf);

    if fasta_size == 0 {
        eprintln!("Failed to download FASTA sequence.");
        return 1;
    }

    // DNA Visualization.
    let mut json_buf = vec![0u8; max_json_size];
    let json_size = squiggle(&fasta_buf[..fasta_size], &mut json_buf);

    if json_size == 0 {
        eprintln!("Squiggle transformation failed or buffer too small.");
        return 1;
    }

    0
}

fn main() {
    let benchmark_name = "dna";
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
