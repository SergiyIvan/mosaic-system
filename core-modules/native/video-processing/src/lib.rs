use std::process::Command;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct VideoProcessingInput {
    video_url: Option<String>,
    watermark_url: Option<String>,
    ffmpeg_path: Option<String>,
}


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

pub fn run(video_url: &str, watermark_url: &str, ffmpeg_path: &str) -> u32 {
    let video_path = "/tmp/video.mp4";
    let watermark_path = "/tmp/watermark.png";
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


pub fn proxy_handler(input_json: &str) -> String {
    let input: VideoProcessingInput = serde_json::from_str(input_json).unwrap_or(VideoProcessingInput { video_url: None, watermark_url: None, ffmpeg_path: None });

    let video_url = input.video_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let watermark_url = input.watermark_url.as_deref().unwrap_or("http://127.0.0.1:8000/watermark.png");
    let ffmpeg_path = input.ffmpeg_path.as_deref().unwrap_or("/tmp/ffmpeg");

    let ret_code = run(video_url, watermark_url, ffmpeg_path);

    if ret_code == 0 {
        "Success: Extracted GIF and applied watermark.".to_string()
    } else {
        "Error: Failed to process video.".to_string()
    }
}


export_function!(proxy_handler);
