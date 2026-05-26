use std::io::Read;
use squiggle_lib::squiggle_transform;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct DnaInput {
    url: Option<String>,
    fasta_size: Option<usize>,
    json_size: Option<usize>,
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

pub fn run(url: &str, fasta_size: usize, json_size: usize) -> u32 {
    let mut fasta_buf = Vec::with_capacity(fasta_size);
    let mut json_buf = Vec::with_capacity(json_size);
    unsafe {
        fasta_buf.set_len(fasta_size);
        json_buf.set_len(json_size);
    }

    // Downloading.
    let fasta_size_result = download(url, &mut fasta_buf);

    if fasta_size_result == 0 {
        eprintln!("Failed to download FASTA sequence.");
        return 0;
    }

    // DNA Visualization.
    let json_size_result = squiggle_transform(&fasta_buf[..fasta_size_result], &mut json_buf);

    if json_size_result == 0 {
        eprintln!("Squiggle transformation failed or buffer too small.");
    }

    json_size_result as u32
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: DnaInput = serde_json::from_str(input_json).unwrap_or(DnaInput { url: None, fasta_size: None, json_size: None });

    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/bacillus_subtilis.fasta");
    let fasta_size = input.fasta_size.unwrap_or(4500000);
    let json_size = input.json_size.unwrap_or(158000000);

    let json_size_result = run(url, fasta_size, json_size);

    if json_size_result == 0 as u32 {
        "Error: Squiggle transformation failed or buffer too small.".to_string()
    } else {
        format!("Success: Squiggle transformation generated JSON with {} bytes.", json_size_result)
    }
}


export_function!(proxy_handler);
