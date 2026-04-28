use std::io::{Read, Cursor};
use image::imageops::FilterType;
use tract_onnx::prelude::*;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct ClassifyInput {
    model_url: Option<String>,
    image_url: Option<String>,
    labels_url: Option<String>,
}


const MAX_IMAGE_SIZE: usize = 10 * 1024 * 1024;  // 10 MB


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

fn download_to_file(url: &str, path: &str) -> bool {
    let mut response = match ureq::get(url).call() {
        Ok(r) => r,
        Err(e) => {
            eprintln!("HTTP Request Failed: {}", e);
            return false;
        }
    };

    let mut file = match std::fs::File::create(path) {
        Ok(f) => f,
        Err(e) => {
            eprintln!("Failed to create file: {}", e);
            return false;
        }
    };

    let mut reader = response.body_mut().as_reader();
    match std::io::copy(&mut reader, &mut file) {
        Ok(_) => true,
        Err(e) => {
            eprintln!("Failed to write stream to disk: {}", e);
            false
        }
    }
}

fn infer(model_slice: &[u8], img_slice: &[u8]) -> u32 {
    let mut cursor = Cursor::new(model_slice);

    // Parse, optimize, and instantiate the model.
    let model = match tract_onnx::onnx()
        .model_for_read(&mut cursor).unwrap()
        .into_optimized().unwrap()
        .into_runnable() {
            Ok(m) => m,
            Err(e) => {
                eprintln!("Model load failed: {:?}", e);
                return 0;
            }
    };

    // Image preprocessing.
    let img = match image::load_from_memory(img_slice) {
        Ok(i) => i.to_rgb8(),
        Err(_) => return 0,
    };

    let resized = image::imageops::resize(&img, 256, 256, FilterType::Triangle);

    let crop_x = (256 - 224) / 2;
    let crop_y = (256 - 224) / 2;
    let cropped = image::imageops::crop_imm(&resized, crop_x, crop_y, 224, 224).to_image();

    // Tensor creation.
    let mut tensor = tract_ndarray::Array4::<f32>::zeros((1, 3, 224, 224));
    let mean = [0.485, 0.456, 0.406];
    let std = [0.229, 0.224, 0.225];

    for (x, y, pixel) in cropped.enumerate_pixels() {
        for c in 0..3 {
            tensor[[0, c, y as usize, x as usize]] = (pixel[c] as f32 / 255.0 - mean[c]) / std[c];
        }
    }

    // Inference.
    let tract_tensor = tensor.into_tensor();
    let result = model.run(tvec!(tract_tensor.into())).unwrap();

    // Argmax (find top prediction).
    let logits = result[0].to_array_view::<f32>().unwrap();

    let mut max_idx = 0;
    let mut max_val = logits[[0, 0]]; // ResNet output shape is [1, 1000].

    for i in 0..1000 {
        let val = logits[[0, i]];
        if val > max_val {
            max_val = val;
            max_idx = i;
        }
    }

    max_idx as u32
}

pub fn run(model_url: &str, image_url: &str, labels_url: &str) -> String {
    let model_path = "/tmp/resnet50.onnx";
    let labels_path = "/tmp/resnet_labels.txt";

    let mut img_buf = vec![0u8; MAX_IMAGE_SIZE];

    // Model - check cache, download, and load to memory buffer.
    if !std::path::Path::new(model_path).exists() {
        download_to_file(model_url, model_path);
    }
    let model_data = std::fs::read(model_path).unwrap_or_default();
    if model_data.is_empty() { return String::new(); }

    // Labels - check cache, download, and load to memory buffer.
    if !std::path::Path::new(labels_path).exists() {
        download_to_file(labels_url, labels_path);
    }
    let labels_data = std::fs::read(labels_path).unwrap_or_default();
    if labels_data.is_empty() { return String::new(); }

    // Image - always download directly into memory.
    let img_size = download(image_url, &mut img_buf);
    if img_size == 0 { return String::new(); }

    // Classification.
    let class_idx = infer(&model_data, &img_buf[..img_size]);

    if class_idx == 0 {
        eprintln!("Classify failed or returned 0 index!");
        return String::new();
    }

    let labels_str = std::str::from_utf8(&labels_data).unwrap_or("");
    labels_str.lines().nth(class_idx as usize).unwrap_or("Unknown").to_string()
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: ClassifyInput = serde_json::from_str(input_json).unwrap_or(ClassifyInput { model_url: None, image_url: None, labels_url: None });

    let model_url = input.model_url.as_deref().unwrap_or("http://127.0.0.1:8000/resnet50.onnx");
    let image_url = input.image_url.as_deref().unwrap_or("http://127.0.0.1:8000/eagle.jpg");
    let labels_url = input.labels_url.as_deref().unwrap_or("http://127.0.0.1:8000/resnet_labels.txt");

    let class_name = run(model_url, image_url, labels_url);

    if class_name.is_empty() {
        "Error: Classify failed or returned 0 index!".to_string()
    } else {
        format!("Success: Image classified as '{}'.", class_name)
    }
}


export_function!(proxy_handler);
