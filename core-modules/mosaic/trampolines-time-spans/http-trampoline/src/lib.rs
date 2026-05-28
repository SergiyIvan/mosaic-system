use std::io::Read;


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


fn upload(url: &str, file_data: &[u8], filename: &str) -> u32 {
    let boundary = "----WasmZeroCopyBoundary123456789";
    let header = format!(
        "--{}\r\nContent-Disposition: form-data; name=\"file\"; filename=\"{}\"\r\nContent-Type: application/octet-stream\r\n\r\n",
        boundary, filename
    );
    let footer = format!("\r\n--{}--\r\n", boundary);

    let mut body = Vec::with_capacity(header.len() + file_data.len() + footer.len());
    body.extend_from_slice(header.as_bytes());
    body.extend_from_slice(file_data);
    body.extend_from_slice(footer.as_bytes());

    let content_type = format!("multipart/form-data; boundary={}", boundary);

    match ureq::post(url).header("Content-Type", &content_type).send(body) {
        Ok(response) => response.status().as_u16() as u32,
        Err(ureq::Error::StatusCode(code)) => code as u32, // 4xx and 5xx codes.
        Err(e) => {
            eprintln!("Upload failed: {}", e);
            0
        }
    }
}


fn download_to_file(url: &str, path: &str) -> u32 {
    let mut response = match ureq::get(url).call() {
        Ok(r) => r,
        Err(e) => {
            eprintln!("HTTP Request Failed: {}", e);
            return 0;
        }
    };

    let mut file = match std::fs::File::create(path) {
        Ok(f) => f,
        Err(e) => {
            eprintln!("Failed to create file: {}", e);
            return 0;
        }
    };

    let mut reader = response.body_mut().as_reader();
    match std::io::copy(&mut reader, &mut file) {
        Ok(bytes_written) => bytes_written as u32,
        Err(e) => {
            eprintln!("Failed to write stream to disk: {}", e);
            0
        }
    }
}


#[unsafe(no_mangle)]
pub unsafe extern "C" fn trampoline_dispatch(
    func_name_ptr: *const u8,
    func_name_len: usize,
    mem_base: *mut u8,
    mem_len: usize,
    args_ptr: *const u64,
    args_len: usize,
    ret_ptr: *mut u64,
) -> bool {
    unsafe {
        let func_name_slice = std::slice::from_raw_parts(func_name_ptr, func_name_len);
        let func_name = std::str::from_utf8(func_name_slice).unwrap_or("");
        let args = std::slice::from_raw_parts(args_ptr, args_len);

        match func_name {
            "host_download" => {
                if args.len() != 4 { return false; }
                let url_ptr = args[0] as usize;
                let url_len = args[1] as usize;
                let out_ptr = args[2] as usize;
                let max_len = args[3] as usize;

                // URL pointer is u8 (1 byte), Output is u8 (1 byte), no x4 multiplier needed.
                let bounds_ok = (url_ptr + url_len <= mem_len) &&
                                (out_ptr + max_len <= mem_len);
                if !bounds_ok { return false; }

                let url_slice = std::slice::from_raw_parts(mem_base.add(url_ptr), url_len);
                let url_str = std::str::from_utf8(url_slice).unwrap_or("");

                let out_slice = std::slice::from_raw_parts_mut(mem_base.add(out_ptr), max_len);

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                let bytes_read = download(url_str, out_slice);
                *ret_ptr = bytes_read as u64;

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_Download | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            "host_upload" => {
                if args.len() != 6 { return false; }
                let url_ptr = args[0] as usize;
                let url_len = args[1] as usize;
                let data_ptr = args[2] as usize;
                let data_len = args[3] as usize;
                let filename_ptr = args[4] as usize;
                let filename_len = args[5] as usize;

                let bounds_ok = (url_ptr + url_len <= mem_len) &&
                                (data_ptr + data_len <= mem_len) &&
                                (filename_ptr + filename_len <= mem_len);
                if !bounds_ok { return false; }

                let url_slice = std::slice::from_raw_parts(mem_base.add(url_ptr), url_len);
                let url_str = std::str::from_utf8(url_slice).unwrap_or("");

                let data_slice = std::slice::from_raw_parts(mem_base.add(data_ptr), data_len);

                let filename_slice = std::slice::from_raw_parts(mem_base.add(filename_ptr), filename_len);
                let filename_str = std::str::from_utf8(filename_slice).unwrap_or("file.bin");

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                let status_code = upload(url_str, data_slice, filename_str);
                *ret_ptr = status_code as u64;

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_Upload | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            "host_download_to_file" => {
                if args.len() != 4 { return false; }
                let url_ptr = args[0] as usize;
                let url_len = args[1] as usize;
                let path_ptr = args[2] as usize;
                let path_len = args[3] as usize;

                let bounds_ok = (url_ptr + url_len <= mem_len) &&
                                (path_ptr + path_len <= mem_len);
                if !bounds_ok { return false; }

                let url_slice = std::slice::from_raw_parts(mem_base.add(url_ptr), url_len);
                let url_str = std::str::from_utf8(url_slice).unwrap_or("");

                let path_slice = std::slice::from_raw_parts(mem_base.add(path_ptr), path_len);
                let path_str = std::str::from_utf8(path_slice).unwrap_or("");

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                let bytes_written = download_to_file(url_str, path_str);
                *ret_ptr = bytes_written as u64;

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_DownloadToFile | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
