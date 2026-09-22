use std::process::Command;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct VideoProcessingInput {
    video_url: Option<String>,
    watermark_url: Option<String>,
    ffmpeg_url: Option<String>,
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

pub fn run(video_url: &str, watermark_url: &str, ffmpeg_url: &str) -> u32 {
    let video_path = "/tmp/video.mp4";
    let watermark_path = "/tmp/watermark.png";
    let ffmpeg_path = "/tmp/ffmpeg";
    let gif_output_path = "/tmp/processed.gif";
    let watermark_output_path = "/tmp/watermarked.mp4";

    if !std::path::Path::new(ffmpeg_path).exists() {
        let start_dl_ffmpeg = std::time::Instant::now();
        let ok_dl = download_to_file(ffmpeg_url, ffmpeg_path);
        println!("*** Span: LibCode_DownloadFFmpeg | DurationUs: {}", start_dl_ffmpeg.elapsed().as_micros());
        if !ok_dl {
            eprintln!("Failed to download FFmpeg.");
            return 1;
        }

        let start_chmod = std::time::Instant::now();
        let ok_chmod = run_command(&format!("chmod +x {}", ffmpeg_path));
        println!("*** Span: LibCode_Chmod | DurationUs: {}", start_chmod.elapsed().as_micros());
        if !ok_chmod {
            eprintln!("Failed to set executable permissions on FFmpeg.");
            return 1;
        }
    }

    let start_dl_vid = std::time::Instant::now();
    let ok_vid = download_to_file(video_url, video_path);
    println!("*** Span: LibCode_DownloadVideo | DurationUs: {}", start_dl_vid.elapsed().as_micros());
    if !ok_vid {
        eprintln!("Failed to download video.");
        return 1;
    }

    let start_dl_wm = std::time::Instant::now();
    let ok_wm = download_to_file(watermark_url, watermark_path);
    println!("*** Span: LibCode_DownloadWatermark | DurationUs: {}", start_dl_wm.elapsed().as_micros());
    if !ok_wm {
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

    let start_gif = std::time::Instant::now();
    let ok_gif = run_command(&cmd_gif);
    println!("*** Span: LibCode_RunFFmpegGif | DurationUs: {}", start_gif.elapsed().as_micros());
    if !ok_gif {
        eprintln!("FFmpeg GIF generation failed");
        return 1;
    }

    let start_wm_cmd = std::time::Instant::now();
    let ok_wm_cmd = run_command(&cmd_watermark);
    println!("*** Span: LibCode_RunFFmpegWatermark | DurationUs: {}", start_wm_cmd.elapsed().as_micros());
    if !ok_wm_cmd {
        eprintln!("FFmpeg Watermarking failed");
        return 1;
    }

    0
}

pub fn proxy_handler(input_json: &str) -> String {
    // ---> START TOTAL SPAN
    let start_total = std::time::Instant::now();

    let input: VideoProcessingInput = serde_json::from_str(input_json).unwrap_or(VideoProcessingInput { video_url: None, watermark_url: None, ffmpeg_url: None });

    let video_url = input.video_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let watermark_url = input.watermark_url.as_deref().unwrap_or("http://127.0.0.1:8000/watermark.png");
    let ffmpeg_url = input.ffmpeg_url.as_deref().unwrap_or("http://127.0.0.1:8000/ffmpeg");

    let ret_code = run(video_url, watermark_url, ffmpeg_url);

    let result = if ret_code == 0 {
        "Success: Extracted GIF and applied watermark.".to_string()
    } else {
        "Error: Failed to process video.".to_string()
    };

    println!("*** Span: TotalRun | DurationUs: {}", start_total.elapsed().as_micros());
    // ---> END TOTAL SPAN

    result
}


export_function!(proxy_handler);
