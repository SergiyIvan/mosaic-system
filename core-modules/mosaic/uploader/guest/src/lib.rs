#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Uploads the Wasm memory buffer directly to a remote server.
    // Returns HTTP response code or 0 in case of failure.
    fn host_upload(
        url_ptr: *const u8, url_len: u32,
        data_ptr: *const u8, data_len: u32
    ) -> u32;
}

const MAX_FILE_SIZE: usize = 5 * 1024 * 1024; // 5 MB

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let download_url = "http://127.0.0.1:8000/video.mp4";
    let upload_url = "http://127.0.0.1:9696/upload";

    // Downloading.
    let mut media_buf = vec![0u8; MAX_FILE_SIZE];

    let downloaded_size = unsafe {
        host_download(
            download_url.as_ptr(), download_url.len() as u32,
            media_buf.as_mut_ptr(), MAX_FILE_SIZE as u32
        )
    };

    if downloaded_size == 0 {
        eprintln!("Failed to download input.");
        return 1;
    }

    // Uploading.
    let response_code = unsafe {
        host_upload(
            upload_url.as_ptr(), upload_url.len() as u32,
            media_buf.as_ptr(), downloaded_size
        )
    };

    if response_code != 201 && response_code != 409 {
        eprintln!("Failed to upload input.");
        return 1;
    }

    0
}
