use serde::Deserialize;
use proxy_guest::export_mosaic_function;

#[derive(Deserialize)]
struct DnaInput {
    url: Option<String>,
    fasta_size: Option<usize>,
    json_size: Option<usize>,
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

pub fn proxy_handler(input_json: &str) -> String {
    let input: DnaInput = serde_json::from_str(input_json).unwrap_or(DnaInput { url: None, fasta_size: None, json_size: None });
    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/bacillus_subtilis.fasta");
    let fasta_size = input.fasta_size.unwrap_or(4500000);
    let json_size = input.json_size.unwrap_or(158000000);

    let mut fasta_buf = Vec::with_capacity(fasta_size);
    let mut json_buf = Vec::with_capacity(json_size);
    unsafe {
        fasta_buf.set_len(fasta_size);
        json_buf.set_len(json_size);
    }

    // Downloading.
    let fasta_size_result = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            fasta_buf.as_mut_ptr(), fasta_size as u32
        )
    };

    if fasta_size_result == 0 {
        return "Error: Failed to download FASTA sequence.".to_string();
    }

    // DNA Visualization.
    let json_size_res = unsafe {
        host_squiggle_transform(
            fasta_buf.as_ptr(), fasta_size_result,
            json_buf.as_mut_ptr(), json_size as u32
        )
    };

    if json_size_res == 0 {
        "Error: Squiggle transformation failed or buffer too small.".to_string()
    } else {
        format!("Success: Squiggle transformation generated JSON with {} bytes.", json_size_res)
    }
}

export_mosaic_function!(proxy_handler);
