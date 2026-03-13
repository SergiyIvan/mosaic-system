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

const MAX_INPUT_SIZE: usize = 10 * 1024 * 1024;  // 10 MB max input
const MAX_OUTPUT_SIZE: usize = 10 * 1024 * 1024; // 10 MB max output

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let input_url = "http://127.0.0.1:8000/video.mp4";

    // Downloading.
    let mut uncompressed_buf = vec![0u8; MAX_INPUT_SIZE];

    let uncompressed_size = unsafe {
        host_download(
            input_url.as_ptr(), input_url.len() as u32,
            uncompressed_buf.as_mut_ptr(), MAX_INPUT_SIZE as u32
        )
    };

    if uncompressed_size == 0 {
        eprintln!("Failed to download input.");
        return 1;
    }

    // Compressing.
    let mut compressed_buf = vec![0u8; MAX_OUTPUT_SIZE];

    let compressed_size = unsafe {
        host_compress(
            uncompressed_buf.as_ptr(), uncompressed_size,
            compressed_buf.as_mut_ptr(), MAX_OUTPUT_SIZE as u32
        )
    };

    if compressed_size == 0 {
        eprintln!("Failed to compress input.");
        return 1;
    }

    0
}
