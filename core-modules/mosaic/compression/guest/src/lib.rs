use serde::Deserialize;
use proxy_guest::export_mosaic_function;


#[derive(Deserialize)]
struct CompressionInput {
    input_url: Option<String>,
    input_size: Option<usize>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Compresses data from in_ptr to out_ptr using Zstandard.
    // Returns compressed size in bytes, or 0 on error.
    fn host_compress(
        in_ptr: *const u8, in_len: u32,
        out_ptr: *mut u8, max_len: u32
    ) -> u32;
}

pub fn proxy_handler(input_json: &str) -> String {
    let input: CompressionInput = serde_json::from_str(input_json).unwrap_or(CompressionInput { input_url: None, input_size: None });
    let input_url = input.input_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let input_size = input.input_size.unwrap_or(2 * 1024 * 1024); // Fallback to 2MB.

    // Downloading.
    let mut uncompressed_buf = Vec::with_capacity(input_size);
    let mut compressed_buf = Vec::with_capacity(input_size);
    unsafe {
        uncompressed_buf.set_len(input_size);
        compressed_buf.set_len(input_size);
    }

    let uncompressed_size = unsafe {
        host_download(
            input_url.as_ptr(), input_url.len() as u32,
            uncompressed_buf.as_mut_ptr(), input_size as u32
        )
    };

    if uncompressed_size == 0 {
        return "Error: Failed to download input.".to_string();
    }

    let compressed_size = unsafe {
        host_compress(
            uncompressed_buf.as_ptr(), uncompressed_size,
            compressed_buf.as_mut_ptr(), input_size as u32
        )
    };

    if compressed_size == 0 {
        "Error: Compression failed.".to_string()
    } else {
        format!("Success: Compressed input file to {} bytes.", compressed_size)
    }
}

export_mosaic_function!(proxy_handler);
