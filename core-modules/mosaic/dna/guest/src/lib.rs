use serde::Deserialize;
use proxy_guest::export_mosaic_function;

#[derive(Deserialize)]
struct DnaInput {
    url: Option<String>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Transforms FASTA data into Squiggle JSON. Returns the size of the generated JSON in bytes, or 0 on error.
    fn host_squiggle_transform(
        in_ptr: *const u8, in_len: u32,
        out_ptr: *mut u8, max_len: u32
    ) -> u32;
}

const MAX_FASTA_SIZE: usize = 5 * 1024 * 1024; // 5 MB input.
const MAX_JSON_SIZE: usize = 155 * 1024 * 1024; // 155 MB output.

pub fn proxy_handler(input_json: &str) -> String {
    let input: DnaInput = serde_json::from_str(input_json).unwrap_or(DnaInput { url: None });
    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/bacillus_subtilis.fasta");

    // Downloading.
    let mut fasta_buf = vec![0u8; MAX_FASTA_SIZE];

    let fasta_size = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            fasta_buf.as_mut_ptr(), MAX_FASTA_SIZE as u32
        )
    };

    if fasta_size == 0 {
        return "Error: Failed to download FASTA sequence.".to_string();
    }

    // DNA Visualization.
    let mut json_buf = vec![0u8; MAX_JSON_SIZE];

    let json_size = unsafe {
        host_squiggle_transform(
            fasta_buf.as_ptr(), fasta_size,
            json_buf.as_mut_ptr(), MAX_JSON_SIZE as u32
        )
    };

    if json_size == 0 {
        "Error: Squiggle transformation failed or buffer too small.".to_string()
    } else {
        format!("Success: Squiggle transformation generated JSON with {} bytes.", json_size)
    }
}

export_mosaic_function!(proxy_handler);
