use std::time::{Duration, Instant};
use std::io::{Read, Cursor};
use image::imageops::FilterType;
use tract_onnx::prelude::*;


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

fn run() -> u32 {
    let model_url = "http://127.0.0.1:8000/resnet50.onnx";
    let image_url = "http://127.0.0.1:8000/eagle.jpg";
    let labels_url = "http://127.0.0.1:8000/resnet_labels.txt";

    let model_path = "/tmp/resnet50.onnx";
    let labels_path = "/tmp/resnet_labels.txt";

    let max_image_size = 10 * 1024 * 1024;  // 10 MB
    let mut img_buf = vec![0u8; max_image_size];

    // Model - check cache, download, and load to memory buffer.
    if !std::path::Path::new(model_path).exists() {
        download_to_file(model_url, model_path);
    }
    let model_data = std::fs::read(model_path).unwrap_or_default();
    if model_data.is_empty() { return 1; }

    // Labels - check cache, download, and load to memory buffer.
    if !std::path::Path::new(labels_path).exists() {
        download_to_file(labels_url, labels_path);
    }
    let labels_data = std::fs::read(labels_path).unwrap_or_default();
    if labels_data.is_empty() { return 1; }

    // Image - always download directly into memory.
    let img_size = download(image_url, &mut img_buf);
    if img_size == 0 { return 1; }

    // Classification.
    let class_idx = infer(&model_data, &img_buf[..img_size]);

    let labels_str = std::str::from_utf8(&labels_data).unwrap_or("");
    let _class_name = labels_str.lines().nth(class_idx as usize).unwrap_or("Unknown");

    if class_idx == 0 {
        eprintln!("Classify failed or returned 0 index!");
        return 1;
    }

    0
}

fn main() {
    let benchmark_name = "classify";
    let args: Vec<String> = std::env::args().collect();

    // If duration and warmup are provided, run the throughput benchmark.
    if args.len() >= 3 {
        let duration_seconds: u64 = args[1].parse().unwrap_or(30);
        let warmup_iterations: u32 = args[2].parse().unwrap_or(5);

        eprintln!("==> Starting Warmup ({} iterations)...", warmup_iterations);
        for _ in 0..warmup_iterations {
            if run() != 0 {
                eprintln!("Warning: run() returned non-zero status.");
            }
        }

        eprintln!("==> Running Benchmark for {} seconds...", duration_seconds);
        let mut iterations = 0;
        let start_time = Instant::now();
        let target_duration = Duration::from_secs(duration_seconds);

        while start_time.elapsed() < target_duration {
            if run() != 0 {
                eprintln!("Warning: run() returned non-zero status.");
            }
            iterations += 1;
        }

        let elapsed = start_time.elapsed().as_secs_f64();
        let rps = iterations as f64 / elapsed;

        // Print the strictly formatted JSON to stdout
        println!("{{");
        println!("  \"benchmark\": \"{}\",", benchmark_name);
        println!("  \"duration_seconds\": {:.2},", elapsed);
        println!("  \"iterations\": {},", iterations);
        println!("  \"throughput_rps\": {:.2}", rps);
        println!("}}");

    } else {
        eprintln!("==> Running Single Native Invocation...");
        let start_time = Instant::now();
        let res = run();
        let elapsed = start_time.elapsed();

        if res == 0 {
            eprintln!("Success! Execution time: {:?}", elapsed);
        } else {
            eprintln!("Failed! Execution time: {:?}", elapsed);
        }
    }
}
