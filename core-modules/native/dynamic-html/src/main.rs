use rand::Rng;
use std::time::{Duration, Instant};
use std::io::{Read, Cursor};
use minijinja::{Environment, context};
use chrono::Local;


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

fn run() -> u32 {
    let url = "http://127.0.0.1:8000/template.html";
    let username = "rbruno";
    let random_len = 1_000_000;

    // Generating random numbers.
    let mut random_numbers = vec![0u32; random_len];
    let mut rng = rand::thread_rng();
    for n in random_numbers.iter_mut() {
        *n = rng.gen_range(0..1_000_000);
    }

    // Downloading template.
    let max_template_size = 1 * 1024; // 1 KB
    let mut template_buf = vec![0u8; max_template_size];

    let template_size = download(url, &mut template_buf);

    if template_size == 0 {
        eprintln!("Failed to download template.");
        return 1;
    }

    let max_html_size = 100 * 1024 * 1024; // 100 MB
    let mut html_buf = vec![0u8; max_html_size];

    // Rendering HTML.
    let html_size = render(
        &template_buf[..template_size],
        username,
        &random_numbers,
        &mut html_buf
    );

    if html_size == 0 {
        eprintln!("Failed to render HTML.");
        return 1;
    }

    0
}

fn main() {
    let benchmark_name = "dynamic-html";
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
