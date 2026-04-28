use std::io::Read;
use squiggle_lib::squiggle_transform;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct DnaInput {
    url: Option<String>,
}


const MAX_FASTA_SIZE: usize = 5 * 1024 * 1024; // 5 MB input.
const MAX_JSON_SIZE: usize = 155 * 1024 * 1024; // 155 MB output.


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

pub fn run(url: &str) -> u32 {
    // Downloading.
    let mut fasta_buf = vec![0u8; MAX_FASTA_SIZE];
    let fasta_size = download(url, &mut fasta_buf);

    if fasta_size == 0 {
        eprintln!("Failed to download FASTA sequence.");
        return 0;
    }

    // DNA Visualization.
    let mut json_buf = vec![0u8; MAX_JSON_SIZE];
    let json_size = squiggle_transform(&fasta_buf[..fasta_size], &mut json_buf);

    if json_size == 0 {
        eprintln!("Squiggle transformation failed or buffer too small.");
    }

    json_size as u32
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: DnaInput = serde_json::from_str(input_json).unwrap_or(DnaInput { url: None });

    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/bacillus_subtilis.fasta");

    let json_size = run(url);

    if json_size == 0 as u32 {
        "Error: Squiggle transformation failed or buffer too small.".to_string()
    } else {
        format!("Success: Squiggle transformation generated JSON with {} bytes.", json_size)
    }
}


export_function!(proxy_handler);
