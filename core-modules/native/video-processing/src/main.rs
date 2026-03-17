use std::time::{Duration, Instant};
use std::process::Command;


fn download_to_file(url: &str, path: &str) -> bool {
    let mut response = match ureq::get(url).call() {
        Ok(r) => r,
        Err(e) => {
            eprintln!("HTTP Request Failed: {}", e);
            return false;
        }
    };

    let mut file = match std::fs::File::create(path) {
        Ok(f) => f,
        Err(e) => {
            eprintln!("Failed to create file: {}", e);
            return false;
        }
    };

    let mut reader = response.body_mut().as_reader();
    match std::io::copy(&mut reader, &mut file) {
        Ok(_) => true,
        Err(e) => {
            eprintln!("Failed to write stream to disk: {}", e);
            false
        }
    }
}

fn run_command(cmd_str: &str) -> bool {
    let status = Command::new("sh")
        .arg("-c")
        .arg(cmd_str)
        .status();

    status.map_or(false, |s| s.success())
}

fn run() -> u32 {
    let video_url = "http://127.0.0.1:8000/video.mp4";
    let watermark_url = "http://127.0.0.1:8000/watermark.png";

    let video_path = "/tmp/video.mp4";
    let watermark_path = "/tmp/watermark.png";
    let ffmpeg_path = "/tmp/ffmpeg";
    let gif_output_path = "/tmp/processed.gif";
    let watermark_output_path = "/tmp/watermarked.mp4";

    if !download_to_file(video_url, video_path) {
        eprintln!("Failed to download video.");
        return 1;
    }

    if !download_to_file(watermark_url, watermark_path) {
        eprintln!("Failed to download watermark.");
        return 1;
    }

    // Running FFmpeg.
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

    if !run_command(&cmd_gif) {
        eprintln!("FFmpeg GIF generation failed");
        return 1;
    }
    if !run_command(&cmd_watermark) {
        eprintln!("FFmpeg Watermarking failed");
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
