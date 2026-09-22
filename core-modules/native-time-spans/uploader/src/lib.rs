use std::io::Read;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct UploaderInput {
    download_url: Option<String>,
    upload_url: Option<String>,
    file_size: Option<usize>,
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

pub fn run(download_url: &str, upload_url: &str, file_size: usize) -> u32 {
    let mut media_buf = Vec::with_capacity(file_size);
    unsafe {
        media_buf.set_len(file_size);
    }

    // Downloading.
    let start_dl = std::time::Instant::now();
    let downloaded_size = download(download_url, &mut media_buf);
    println!("*** Span: LibCode_Download | DurationUs: {}", start_dl.elapsed().as_micros());

    if downloaded_size == 0 {
        eprintln!("Failed to download input.");
        return 0;
    }

    let filename = download_url.split('/').last().unwrap_or("file.bin");

    // Uploading.
    let start_up = std::time::Instant::now();
    let response_code = upload(upload_url, &media_buf[..downloaded_size], filename);
    println!("*** Span: LibCode_Upload | DurationUs: {}", start_up.elapsed().as_micros());

    if response_code != 201 && response_code != 409 {
        eprintln!("Failed to upload input. Response code: {}", response_code);
    }

    response_code
}

pub fn proxy_handler(input_json: &str) -> String {
    // ---> START TOTAL SPAN
    let start_total = std::time::Instant::now();

    let input: UploaderInput = serde_json::from_str(input_json).unwrap_or(UploaderInput { download_url: None, upload_url: None, file_size: None });

    let download_url = input.download_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let upload_url = input.upload_url.as_deref().unwrap_or("http://127.0.0.1:9696/upload");
    let file_size = input.file_size.unwrap_or(2 * 1024 * 1024); // Fallback to 2MB.

    let response_code = run(download_url, upload_url, file_size);

    let result = if response_code == 201 || response_code == 409 {
        format!("Success: Upload returned {}.", response_code)
    } else {
        format!("Error: Download failed or upload returned unexpected response code: {}.", response_code)
    };

    println!("*** Span: TotalRun | DurationUs: {}", start_total.elapsed().as_micros());
    // ---> END TOTAL SPAN

    result
}


export_function!(proxy_handler);
