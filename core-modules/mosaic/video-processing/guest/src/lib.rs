use serde::Deserialize;
use proxy_guest::export_mosaic_function;


#[derive(Deserialize)]
struct VideoProcessingInput {
    video_url: Option<String>,
    watermark_url: Option<String>,
    ffmpeg_path: Option<String>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL directly to a file path on the host. Returns bytes written or 0 on error.
    fn host_download_to_file(url_ptr: *const u8, url_len: u32, path_ptr: *const u8, path_len: u32) -> u32;

    // Executes a shell command on the host OS.
    fn host_run_command(cmd_ptr: *const u8, cmd_len: u32) -> u32;
}

pub fn proxy_handler(input_json: &str) -> String {
    let input: VideoProcessingInput = serde_json::from_str(input_json).unwrap_or(VideoProcessingInput { video_url: None, watermark_url: None, ffmpeg_path: None });
    let video_url = input.video_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let watermark_url = input.watermark_url.as_deref().unwrap_or("http://127.0.0.1:8000/watermark.png");
    let ffmpeg_path = input.ffmpeg_path.as_deref().unwrap_or("/tmp/ffmpeg");

    let video_path = "/tmp/video.mp4";
    let watermark_path = "/tmp/watermark.png";
    let gif_output_path = "/tmp/processed.gif";
    let watermark_output_path = "/tmp/watermarked.mp4";

    // Downloading.
    let video_size = unsafe {
        host_download_to_file(
            video_url.as_ptr(), video_url.len() as u32,
            video_path.as_ptr(), video_path.len() as u32
        )
    };
    if video_size == 0 { return "Error: Failed to download video.".to_string(); }

    let watermark_size = unsafe {
        host_download_to_file(
            watermark_url.as_ptr(), watermark_url.len() as u32,
            watermark_path.as_ptr(), watermark_path.len() as u32
        )
    };
    if watermark_size == 0 { return "Error: Failed to download watermark.".to_string(); }

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

    unsafe {
        if host_run_command(cmd_gif.as_ptr(), cmd_gif.len() as u32) != 0 {
            return "Error: FFmpeg GIF generation failed".to_string();
        }
        if host_run_command(cmd_watermark.as_ptr(), cmd_watermark.len() as u32) != 0 {
            return "Error: FFmpeg Watermarking failed".to_string();
        }
    }

    return "Success: Extracted GIF and applied watermark.".to_string();
}

export_mosaic_function!(proxy_handler);
