use std::io::Read;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct UploaderInput {
    download_url: Option<String>,
    upload_url: Option<String>,
}


const MAX_FILE_SIZE: usize = 5 * 1024 * 1024; // 5 MB


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

fn upload(url: &str, file_data: &[u8], filename: &str) -> u32 {
    let boundary = "----WasmZeroCopyBoundary123456789";
    let header = format!(
        "--{}\r\nContent-Disposition: form-data; name=\"file\"; filename=\"{}\"\r\nContent-Type: application/octet-stream\r\n\r\n",
        boundary, filename
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

pub fn run(download_url: &str, upload_url: &str) -> u32 {
    // Downloading.
    let mut media_buf = vec![0u8; MAX_FILE_SIZE];
    let downloaded_size = download(download_url, &mut media_buf);

    if downloaded_size == 0 {
        eprintln!("Failed to download input.");
        return 0;
    }

    let filename = download_url.split('/').last().unwrap_or("file.bin");

    // Uploading.
    let response_code = upload(upload_url, &media_buf[..downloaded_size], filename);

    if response_code != 201 && response_code != 409 {
        eprintln!("Failed to upload input. Response code: {}", response_code);
    }

    response_code
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: UploaderInput = serde_json::from_str(input_json).unwrap_or(UploaderInput { download_url: None, upload_url: None });

    let download_url = input.download_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let upload_url = input.upload_url.as_deref().unwrap_or("http://127.0.0.1:9696/upload");

    let response_code = run(download_url, upload_url);

    if response_code == 201 || response_code == 409 {
        format!("Success: Upload returned {}.", response_code)
    } else {
        format!("Error: Download failed or upload returned unexpected response code: {}.", response_code)
    }
}


export_function!(proxy_handler);
