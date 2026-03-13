#[link(wasm_import_module = "env")]
unsafe extern "C" {
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Transforms FASTA data into Squiggle JSON. Returns the size of the generated JSON in bytes, or 0 on error.
    fn host_squiggle(
        in_ptr: *const u8, in_len: u32,
        out_ptr: *mut u8, max_len: u32
    ) -> u32;
}

const MAX_FASTA_SIZE: usize = 20 * 1024 * 1024; // 20 MB input.
const MAX_JSON_SIZE: usize = 200 * 1024 * 1024; // 200 MB output.

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let url = "http://127.0.0.1:8000/bacillus_subtilis.fasta";

    // Downloading.
    let mut fasta_buf = vec![0u8; MAX_FASTA_SIZE];

    let fasta_size = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            fasta_buf.as_mut_ptr(), MAX_FASTA_SIZE as u32
        )
    };

    if fasta_size == 0 {
        eprintln!("Failed to download FASTA sequence.");
        return 1;
    }

    // DNA Visualization.
    let mut json_buf = vec![0u8; MAX_JSON_SIZE];

    let json_size = unsafe {
        host_squiggle(
            fasta_buf.as_ptr(), fasta_size,
            json_buf.as_mut_ptr(), MAX_JSON_SIZE as u32
        )
    };

    if json_size == 0 {
        eprintln!("Squiggle transformation failed or buffer too small.");
        return 1;
    }

    0
}
