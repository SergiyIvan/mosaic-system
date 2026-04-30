use serde::Deserialize;
use proxy_guest::export_mosaic_function;


#[derive(Deserialize)]
struct UploaderInput {
    download_url: Option<String>,
    upload_url: Option<String>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Uploads the Wasm memory buffer directly to a remote server.
    // Returns HTTP response code or 0 in case of failure.
    fn host_upload(
        url_ptr: *const u8, url_len: u32,
        data_ptr: *const u8, data_len: u32,
        filename_ptr: *const u8, filename_len: u32
    ) -> u32;
}

const MAX_FILE_SIZE: usize = 5 * 1024 * 1024; // 5 MB


pub fn proxy_handler(input_json: &str) -> String {
    let input: UploaderInput = serde_json::from_str(input_json).unwrap_or(UploaderInput { download_url: None, upload_url: None });
    let download_url = input.download_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let upload_url = input.upload_url.as_deref().unwrap_or("http://127.0.0.1:9696/upload");

    // Downloading.
    let mut media_buf = vec![0u8; MAX_FILE_SIZE];

    let downloaded_size = unsafe {
        host_download(
            download_url.as_ptr(), download_url.len() as u32,
            media_buf.as_mut_ptr(), MAX_FILE_SIZE as u32
        )
    };

    if downloaded_size == 0 {
        return "Error: Failed to download input.".to_string();
    }

    let filename = download_url.split('/').last().unwrap_or("file.bin");

    // Uploading.
    let response_code = unsafe {
        host_upload(
            upload_url.as_ptr(), upload_url.len() as u32,
            media_buf.as_ptr(), downloaded_size,
            filename.as_ptr(), filename.len() as u32
        )
    };

    if response_code == 201 || response_code == 409 {
        format!("Success: Upload returned {}.", response_code)
    } else {
        format!("Error: Download failed or upload returned unexpected response code: {}.", response_code)
    }
}

export_mosaic_function!(proxy_handler);
