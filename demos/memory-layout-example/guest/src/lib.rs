#[link(wasm_import_module = "env")]
unsafe extern "C" {
    fn host_function();
}

const PATTERN_VEC: u32 = 0xDEADBEEF; // EFBEADDE
const PATTERN_ARR: u32 = 0xCAFEBABE; // BEBAFECA
const SIZE: usize = 56;

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let mut stack_arr = [0u8; SIZE];
    fill_pattern(&mut stack_arr, PATTERN_ARR);
    let mut heap_vec = vec![0u8; SIZE];
    fill_pattern(&mut heap_vec, PATTERN_VEC);

    println!("GUEST: Stack-allocated array address: {:p}", stack_arr.as_ptr());
    println!("GUEST: Heap-allocated vector address: {:p}", heap_vec.as_ptr());

    unsafe {
        host_function();

        // Prevent optimization from removing these variables before the dump
        // by technically "using" them after the call.
        std::hint::black_box(&stack_arr);
        std::hint::black_box(&heap_vec);
    }
    0
}

fn fill_pattern(buffer: &mut [u8], magic: u32) {
    let magic_bytes = magic.to_be_bytes();
    let zeros = [0u8; 4];

    let mut i = 0;
    while i < buffer.len() {
        if i + 4 <= buffer.len() {
            buffer[i..i+4].copy_from_slice(&zeros);
            i += 4;
        }
        if i + 4 <= buffer.len() {
            buffer[i..i+4].copy_from_slice(&magic_bytes);
            i += 4;
        }
    }
}
