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

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let url = "http://127.0.0.1:8000/snap.png";
    let target_width = 200;
    let target_height = 200;

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
        eprintln!("Failed to download image.");
        return 1;
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
        eprintln!("Failed to resize image.");
        return 1;
    }

    0
}
