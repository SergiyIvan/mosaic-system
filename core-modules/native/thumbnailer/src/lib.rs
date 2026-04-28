use std::io::{Read, Cursor};
use image::imageops::FilterType;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct ThumbnailerInput {
    url: Option<String>,
    target_width: Option<u32>,
    target_height: Option<u32>,
}


const MAX_IMAGE_SIZE: usize = 15 * 1024 * 1024; // 15 MB


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

fn resize(in_data: &[u8], w: u32, h: u32, out_buf: &mut [u8]) -> u32 {
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
        Ok(_) => cursor.position() as u32,
        Err(e) => {
            eprintln!("Failed to encode JPEG: {}", e);
            0
        }
    }
}

pub fn run(url: &str, target_width: u32, target_height: u32) -> u32 {
    // Downloading.
    let mut download_buf = vec![0u8; MAX_IMAGE_SIZE];
    let download_size = download(url, &mut download_buf);

    if download_size == 0 {
        eprintln!("Failed to download image.");
        return 0;
    }

    // Resizing.
    let mut resize_buf = vec![0u8; MAX_IMAGE_SIZE];
    let resized_size = resize(
        &download_buf[..download_size],
        target_width,
        target_height,
        &mut resize_buf
    );

    if resized_size == 0 {
        eprintln!("Failed to resize image.");
        return 0;
    }

    resized_size
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: ThumbnailerInput = serde_json::from_str(input_json).unwrap_or(ThumbnailerInput { url: None, target_width: None, target_height: None });

    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/snap.png");
    let target_width = input.target_width.unwrap_or(200);
    let target_height = input.target_height.unwrap_or(200);

    let resized_size = run(url, target_width, target_height);

    if resized_size != 0 {
        format!("Success: Generated thumbnail of {} bytes.", resized_size)
    } else {
        "Error: Failed to resize image.".to_string()
    }
}


export_function!(proxy_handler);
