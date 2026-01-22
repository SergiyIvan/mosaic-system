#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let mut arr = vec![0u8; 16];
    println!("GUEST: Addr: {:p}\n", arr.as_ptr());
    println!("GUEST: Before: {:?}\n", arr);
    unsafe {
        host_function(arr.as_mut_ptr(), arr.len() as u32);
    }
    println!("GUEST: After:  {:?}\n", arr);
    0
}

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    fn host_function(ptr: *mut u8, len: u32);
}
