use video_processing::run;
use std::time::{Duration, Instant};


fn run_cli() -> u32 {
    let video_url = "http://127.0.0.1:8000/video.mp4";
    let watermark_url = "http://127.0.0.1:8000/watermark.png";
    let ffmpeg_url = "http://127.0.0.1:8000/ffmpeg";

    let ret_code = run(video_url, watermark_url, ffmpeg_url);

    if ret_code != 0 {
        eprintln!("Error: Failed to process video.");
        return 1;
    }

    0
}


fn main() {
    let benchmark_name = "video-processing";
    let args: Vec<String> = std::env::args().collect();

    // If duration and warmup are provided, run the throughput benchmark.
    if args.len() >= 3 {
        let duration_seconds: u64 = args[1].parse().unwrap_or(30);
        let warmup_iterations: u32 = args[2].parse().unwrap_or(5);

        eprintln!("==> Starting Warmup ({} iterations)...", warmup_iterations);
        for _ in 0..warmup_iterations {
            if run_cli() != 0 {
                eprintln!("Warning: run_cli() returned non-zero status.");
            }
        }

        eprintln!("==> Running Benchmark for {} seconds...", duration_seconds);
        let mut iterations = 0;
        let start_time = Instant::now();
        let target_duration = Duration::from_secs(duration_seconds);

        while start_time.elapsed() < target_duration {
            if run_cli() != 0 {
                eprintln!("Warning: run_cli() returned non-zero status.");
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
        let res = run_cli();
        let elapsed = start_time.elapsed();

        if res == 0 {
            eprintln!("Success! Execution time: {:?}", elapsed);
        } else {
            eprintln!("Failed! Execution time: {:?}", elapsed);
        }
    }
}
