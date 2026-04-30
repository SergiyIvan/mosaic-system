#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    fn host_download_to_file(url_ptr: *const u8, url_len: u32, path_ptr: *const u8, path_len: u32) -> u32;
    fn host_file_exists(path_ptr: *const u8, path_len: u32) -> u32;
    fn host_read_file(path_ptr: *const u8, path_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Runs inference using ONNX Runtime. Returns the top-1 class index.
    fn host_infer(
        model_ptr: *const u8, model_len: u32,
        img_ptr: *const u8, img_len: u32
    ) -> u32;
}

const MAX_MODEL_SIZE: usize = 120 * 1024 * 1024; // 120 MB
const MAX_IMAGE_SIZE: usize = 10 * 1024 * 1024;  // 10 MB
const MAX_LABELS_SIZE: usize = 128 * 1024;       // 128 KB

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let model_url = "http://127.0.0.1:8000/resnet50.onnx";
    let image_url = "http://127.0.0.1:8000/eagle.jpg";
    let labels_url = "http://127.0.0.1:8000/resnet_labels.txt";

    let model_path = "/tmp/resnet50.onnx";
    let labels_path = "/tmp/resnet_labels.txt";

    // Downloading.
    let mut model_buf = vec![0u8; MAX_MODEL_SIZE];
    let mut img_buf = vec![0u8; MAX_IMAGE_SIZE];
    let mut labels_buf = vec![0u8; MAX_LABELS_SIZE];

    // Model - download to disk if missing, then read into memory.
    unsafe {
        if host_file_exists(model_path.as_ptr(), model_path.len() as u32) == 0 {
            host_download_to_file(model_url.as_ptr(), model_url.len() as u32, model_path.as_ptr(), model_path.len() as u32);
        }
    }
    let model_size = unsafe { host_read_file(model_path.as_ptr(), model_path.len() as u32, model_buf.as_mut_ptr(), MAX_MODEL_SIZE as u32) };
    if model_size == 0 { return 1; }

    // Labels - download to disk if missing, then read into memory.
    unsafe {
        if host_file_exists(labels_path.as_ptr(), labels_path.len() as u32) == 0 {
            host_download_to_file(labels_url.as_ptr(), labels_url.len() as u32, labels_path.as_ptr(), labels_path.len() as u32);
        }
    }
    let labels_size = unsafe { host_read_file(labels_path.as_ptr(), labels_path.len() as u32, labels_buf.as_mut_ptr(), MAX_LABELS_SIZE as u32) };
    if labels_size == 0 { return 1; }

    // Image - always download directly into memory.
    let img_size = unsafe { host_download(image_url.as_ptr(), image_url.len() as u32, img_buf.as_mut_ptr(), MAX_IMAGE_SIZE as u32) };
    if img_size == 0 { return 1; }

    // Classification.
    let class_idx = unsafe { host_infer(model_buf.as_ptr(), model_size, img_buf.as_ptr(), img_size) };

    let labels_str = std::str::from_utf8(&labels_buf[..labels_size as usize]).unwrap_or("");
    let _class_name = labels_str.lines().nth(class_idx as usize).unwrap_or("Unknown");

    if class_idx == 0 {
        eprintln!("Classify failed!");
        return 1;
    }

    0
}
