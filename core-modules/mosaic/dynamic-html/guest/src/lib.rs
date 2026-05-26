use rand::Rng;
use serde::Deserialize;
use proxy_guest::export_mosaic_function;


#[derive(Deserialize)]
struct DynamicHtmlInput {
    url: Option<String>,
    username: Option<String>,
    random_len: Option<usize>,
    template_size: Option<usize>,
    html_size: Option<usize>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Downloads from URL into Wasm memory. Returns actual byte size, or 0 on error.
    fn host_download(url_ptr: *const u8, url_len: u32, out_ptr: *mut u8, max_len: u32) -> u32;

    // Renders the template. Returns actual byte size of the HTML output, or 0 on error.
    fn host_render(
        template_ptr: *const u8, template_len: u32,
        username_ptr: *const u8, username_len: u32,
        rand_ptr: *const u32, rand_len: u32, // rand_len is number of elements, not bytes.
        out_ptr: *mut u8, max_len: u32,
    ) -> u32;
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: DynamicHtmlInput = serde_json::from_str(input_json).unwrap_or(DynamicHtmlInput { url: None, username: None, random_len: None, template_size: None, html_size: None });
    let url = input.url.as_deref().unwrap_or("http://127.0.0.1:8000/template.html");
    let username = input.username.as_deref().unwrap_or("rbruno");
    let random_len = input.random_len.unwrap_or(1_000_000);
    let template_size = input.template_size.unwrap_or(1024);
    let html_size = input.html_size.unwrap_or(33000000);

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
    let template_size_result = unsafe {
        host_download(
            url.as_ptr(), url.len() as u32,
            template_buf.as_mut_ptr(), template_size as u32
        )
    };

    if template_size_result == 0 {
        return "Error: Failed to download template.".to_string();
    }

    // Generating the HTML.
    let html_size_result = unsafe {
        host_render(
            template_buf.as_ptr(), template_size_result,
            username.as_ptr(), username.len() as u32,
            random_numbers.as_ptr(), random_len as u32,
            html_buf.as_mut_ptr(), html_size as u32
        )
    };

    if html_size_result > 0 {
        format!("Success: Generated HTML with {} bytes.", html_size_result)
    } else {
        "Error: Failed to generate HTML.".to_string()
    }
}

export_mosaic_function!(proxy_handler);
