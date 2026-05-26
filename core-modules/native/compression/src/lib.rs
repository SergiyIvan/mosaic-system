use std::io::Read;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct CompressionInput {
    input_url: Option<String>,
    input_size: Option<usize>,
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

fn compress(in_data: &[u8], out_buf: &mut [u8]) -> usize {
    // Compression Level: 3 is standard. We use 9 to make the CPU work a bit harder for the benchmark.
    let compression_level = 9;

    match zstd::bulk::compress_to_buffer(in_data, out_buf, compression_level) {
        Ok(size) => size,
        Err(_) => 0,
    }
}

pub fn run(input_url: &str, input_size: usize) -> u32 {
    let mut uncompressed_buf = Vec::with_capacity(input_size);
    let mut compressed_buf = Vec::with_capacity(input_size);
    unsafe {
        uncompressed_buf.set_len(input_size);
        compressed_buf.set_len(input_size);
    }

    // Downloading.
    let uncompressed_size = download(input_url, &mut uncompressed_buf);

    if uncompressed_size == 0 {
        eprintln!("Failed to download input.");
        return 0;
    }

    // Compressing.
    let compressed_size = compress(&uncompressed_buf[..uncompressed_size], &mut compressed_buf);

    if compressed_size == 0 {
        eprintln!("Failed to compress input.");
    }

    compressed_size as u32
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: CompressionInput = serde_json::from_str(input_json).unwrap_or(CompressionInput { input_url: None, input_size: None });

    let input_url = input.input_url.as_deref().unwrap_or("http://127.0.0.1:8000/video.mp4");
    let input_size = input.input_size.unwrap_or(2 * 1024 * 1024);

    let compressed_size = run(input_url, input_size);

    if compressed_size == 0 {
        "Error: Compression failed.".to_string()
    } else {
        format!("Success: Compressed input file to {} bytes.", compressed_size)
    }
}


export_function!(proxy_handler);
