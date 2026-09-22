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
    template_size: Option<usize>,
    html_size: Option<usize>,
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

pub fn run(url: &str, username: &str, random_len: usize, template_size: usize, html_size: usize) -> u32 {
    // Generating random numbers.
    let mut random_numbers = vec![0u32; random_len];
    let mut rng = rand::thread_rng();
    for n in random_numbers.iter_mut() {
        *n = rng.gen_range(0..1_000_000);
    }

    let mut template_buf = Vec::with_capacity(template_size);
    let mut html_buf = Vec::with_capacity(html_size);
    unsafe {
        template_buf.set_len(template_size);
        html_buf.set_len(html_size);
    }

    // Downloading template.
    let start_dl = std::time::Instant::now();
    let template_size_result = download(url, &mut template_buf);
    println!("*** Span: LibCode_Download | DurationUs: {}", start_dl.elapsed().as_micros());

    if template_size_result == 0 {
        eprintln!("Failed to download template.");
        return 0;
    }

    // Rendering HTML.
    let start_render = std::time::Instant::now();
    let html_size_result = render(
        &template_buf[..template_size_result],
        username,
        &random_numbers,
        &mut html_buf
    );
    println!("*** Span: LibCode_Render | DurationUs: {}", start_render.elapsed().as_micros());

    if html_size_result == 0 {
        eprintln!("Failed to render HTML.");
        return 0;
    }

    html_size_result as u32
}

pub fn proxy_handler(input_json: &str) -> String {
    // ---> START TOTAL SPAN
    let start_total = std::time::Instant::now();

    let input: DynamicHtmlInput = serde_json::from_str(input_json).unwrap_or(DynamicHtmlInput { url: None, username: None, random_len: None, template_size: None, html_size: None });

    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/template.html");
    let username = input.username.as_deref().unwrap_or("rbruno");
    let random_len = input.random_len.unwrap_or(1_000_000);
    let template_size = input.template_size.unwrap_or(1024);
    let html_size = input.html_size.unwrap_or(33000000);

    let html_size_result = run(url, username, random_len, template_size, html_size);

    let result = if html_size_result > 0 {
        format!("Success: Generated HTML with {} bytes.", html_size_result)
    } else {
        "Error: Failed to generate HTML.".to_string()
    };

    println!("*** Span: TotalRun | DurationUs: {}", start_total.elapsed().as_micros());
    // ---> END TOTAL SPAN

    result
}


export_function!(proxy_handler);
