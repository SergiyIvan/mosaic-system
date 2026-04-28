use rand::Rng;
use std::io::{Read, Cursor};
use minijinja::{Environment, context};
use chrono::Local;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct DynamicHtmlInput {
    url: Option<String>,
    username: Option<String>,
    random_len: Option<usize>,
}


const MAX_TEMPLATE_SIZE: usize = 1 * 1024; // 1 KB
const MAX_HTML_SIZE: usize = 100 * 1024 * 1024; // 100 MB


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

fn render(template_data: &[u8], username: &str, random_numbers: &[u32], out_buf: &mut [u8]) -> usize {
    let template_str = std::str::from_utf8(template_data).unwrap_or("");

    let mut env = Environment::new();
    if env.add_template("tpl", template_str).is_err() {
        eprintln!("Failed to parse template!");
        return 0;
    }
    let tmpl = env.get_template("tpl").unwrap();

    let cur_time = Local::now().format("%Y-%m-%d %H:%M:%S").to_string();

    let mut cursor = Cursor::new(out_buf);

    let res = tmpl.render_captured_to(context! {
        username => username,
        cur_time => cur_time,
        random_numbers => random_numbers,
    }, &mut cursor);

    match res {
        Ok(_) => cursor.position() as usize,
        Err(_) => 0
    }
}

pub fn run(url: &str, username: &str, random_len: usize) -> u32 {
    // Generating random numbers.
    let mut random_numbers = vec![0u32; random_len];
    let mut rng = rand::thread_rng();
    for n in random_numbers.iter_mut() {
        *n = rng.gen_range(0..1_000_000);
    }

    // Downloading template.
    let mut template_buf = vec![0u8; MAX_TEMPLATE_SIZE];

    let template_size = download(url, &mut template_buf);

    if template_size == 0 {
        eprintln!("Failed to download template.");
        return 0;
    }

    let mut html_buf = vec![0u8; MAX_HTML_SIZE];

    // Rendering HTML.
    let html_size = render(
        &template_buf[..template_size],
        username,
        &random_numbers,
        &mut html_buf
    );

    if html_size == 0 {
        eprintln!("Failed to render HTML.");
        return 0;
    }

    html_size as u32
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: DynamicHtmlInput = serde_json::from_str(input_json).unwrap_or(DynamicHtmlInput { url: None, username: None, random_len: None });

    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/template.html");
    let username = input.username.as_deref().unwrap_or("rbruno");
    let random_len = input.random_len.unwrap_or(1_000_000);

    let html_size = run(url, username, random_len);

    if html_size > 0 {
        format!("Success: Generated HTML with {} bytes.", html_size)
    } else {
        "Error: Failed to generate HTML.".to_string()
    }
}


export_function!(proxy_handler);
