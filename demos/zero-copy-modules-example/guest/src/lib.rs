#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let mut arr = vec![0u8; 16];
    console_log(&format!("GUEST: Addr: {:p}\n", arr.as_ptr()));
    console_log(&format!("GUEST: Before: {:?}\n", arr));
    unsafe {
        host_function(arr.as_mut_ptr(), arr.len() as u32);
    }
    console_log(&format!("GUEST: After:  {:?}\n", arr));
    0
}

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    fn host_print(ptr: *const u8, len: u32);

    fn host_function(ptr: *mut u8, len: u32);
}

fn console_log(msg: &str) {
    unsafe {
        host_print(msg.as_ptr(), msg.len() as u32);
    }
}
