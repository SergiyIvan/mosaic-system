use serde::Deserialize;
use proxy_guest::export_mosaic_function;


#[derive(Deserialize)]
struct ThumbnailerInput {
    url: Option<String>,
    target_width: Option<u32>,
    target_height: Option<u32>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Resizes image. Returns actual byte size of the output image, or 0 on error.
    fn host_resize(
        in_ptr: *const u8, in_len: u32,
        w: u32, h: u32,
        out_ptr: *mut u8, max_len: u32,
    ) -> u32;
}

const MAX_IMAGE_SIZE: usize = 15 * 1024 * 1024; // 15 MB.

pub fn proxy_handler(input_json: &str) -> String {
    let input: ThumbnailerInput = serde_json::from_str(input_json).unwrap_or(ThumbnailerInput { url: None, target_width: None, target_height: None });
    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/snap.png");
    let target_width = input.target_width.unwrap_or(200);
    let target_height = input.target_height.unwrap_or(200);

    let mut download_buf = vec![0u8; MAX_IMAGE_SIZE];
    let mut resize_buf = vec![0u8; MAX_IMAGE_SIZE];

    // Download Phase.
    let download_size = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            download_buf.as_mut_ptr(), MAX_IMAGE_SIZE as u32
        )
    };

    if download_size == 0 {
        return "Error: Failed to download image.".to_string();
    }

    // Compute (Resize) Phase.
    let resized_size = unsafe {
        host_resize(
            download_buf.as_ptr(), download_size,
            target_width, target_height,
            resize_buf.as_mut_ptr(), MAX_IMAGE_SIZE as u32
        )
    };

    if resized_size == 0 {
        "Error: Failed to resize image.".to_string()
    } else {
        format!("Success: Generated thumbnail of {} bytes.", resized_size)
    }
}

export_mosaic_function!(proxy_handler);
