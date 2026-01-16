mod bindings {
    use super::ApplicationComponent;
    wit_bindgen::generate!();
    export!(ApplicationComponent);
}

use bindings::docs::ffmpeg_app::hosted::{system, get_file_size};
use std::time::{Duration, Instant};

const FFMPEG_PATH: &str = "/tmp/data/ffmpeg"; 
const INPUT_FILE: &str = "/tmp/data/video.mp4"; 
const BENCHMARK_SECONDS: u64 = 300;

struct ApplicationComponent;

impl bindings::exports::wasi::cli::run::Guest for ApplicationComponent {
    fn run() -> Result<(), ()> {
        println!("=== Starting Warmup ===");
        run_benchmark().map_err(|e| eprintln!("Benchmark Warmup Error: {}", e))?;
        println!("=== Warmup Complete ===\n");

        let iterations = 5;
        for i in 1..=iterations {
            println!("=== Iteration {}/{} ===", i, iterations);
            run_benchmark().map_err(|e| eprintln!("Benchmark Error: {}", e))?;
            println!();
        }

        Ok(())
    }
}

fn run_benchmark() -> Result<(), String> {
    let input_size = get_file_size(INPUT_FILE)
        .map_err(|e| format!("Failed to get file size for '{}': {}", INPUT_FILE, e))?;

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

        let exit_code = system(&cmd).map_err(|e| format!("Call to CLI failed: {}", e))?;

        if exit_code != 0 {
            return Err(format!("FFmpeg exited with error code: {}", exit_code));
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
