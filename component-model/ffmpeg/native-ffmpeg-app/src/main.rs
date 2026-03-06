use std::fs;
use std::process::{Command};
use std::time::{Duration, Instant};

const FFMPEG_PATH: &str = "/tmp/data/ffmpeg"; 
const INPUT_FILE: &str = "/tmp/data/video.mp4"; 
const BENCHMARK_SECONDS: u64 = 30;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("=== Starting Warmup ===");
    run_benchmark().map_err(|e| format!("Benchmark Warmup Error: {}", e))?;
    println!("=== Warmup Complete ===\n");

    let iterations = 5;
    for i in 1..=iterations {
        println!("=== Iteration {}/{} ===", i, iterations);
        run_benchmark().map_err(|e| format!("Benchmark Error: {}", e))?;
        println!();
    }

    Ok(())
}

fn run_benchmark() -> Result<(), String> {
    let metadata = fs::metadata(INPUT_FILE).map_err(|e| {
        format!("Failed to get file size for '{}': {}", INPUT_FILE, e)
    })?;
    let input_size = metadata.len();

    let cmd = format!(
        "{} -y -i {} -s 640x480 -c:a copy -f mp4 /dev/null > /dev/null 2>&1",
        FFMPEG_PATH, INPUT_FILE
    );

    let start = Instant::now();
    let limit = Duration::from_secs(BENCHMARK_SECONDS);
    let mut ops: usize = 0;

    loop {
        let now = Instant::now();
        if now.duration_since(start) >= limit {
            break;
        }

        let status = Command::new("sh").arg("-c").arg(&cmd).status().map_err(|e| format!("Failed to execute command: {}", e))?;

        if !status.success() {
            return Err(format!("FFmpeg exited with error code: {:?}", status.code()).into());
        }

        ops += 1;
    }

    let total_elapsed = start.elapsed().as_secs_f64();
    let throughput_bytes = (ops as f64) * (input_size as f64);
    let throughput_mb = throughput_bytes / total_elapsed / 1_000_000.0;

    println!("{:<12} {:<10} {:<12} {:<20}", "FileSize", "Ops", "Time(s)", "Throughput(MB/s)");
    println!("{:-<60}", "");
    println!(
        "{:<12} {:<10} {:<12.2} {:<20.2}", 
        input_size, ops, total_elapsed, throughput_mb
    );

    Ok(())
}
