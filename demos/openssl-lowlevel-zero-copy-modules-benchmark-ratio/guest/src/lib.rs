use std::time::{Instant};

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    fn host_rand_bytes(ptr: *mut u8, len: u32);

    fn host_encrypt(
        key_ptr: *const u8,
        iv_ptr: *const u8,
        aad_ptr: *const u8,
        aad_len: u32,
        pt_ptr: *const u8,
        pt_len: u32,
        tag_ptr: *mut u8,
        ct_ptr: *mut u8,
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_openssl_time_nanos() -> u64;
}

const TARGET_OPS: usize = 1_000_000;

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    println!("=== Starting Warmup (Core Wasm) ===");
    run_benchmark(100_000);
    println!("=== Warmup Complete ===\n");

    let iterations = 5;
    for i in 1..=iterations {
        println!("=== Iteration {}/{} ===", i, iterations);
        run_benchmark(TARGET_OPS);
        println!();
    }
    0
}

fn run_benchmark(target_ops: usize) {
    let sizes = [16, 64, 256, 1024, 8192, 16384];

    println!(
        "{:<10} {:<10} {:<12} {:<12} {:<12} {:<12}",
        "BlockSize", "Ops", "Total(ms)", "Host-T(ms)", "Host-O(ms)", "Wasm(ms)"
    );
    println!("{:-<85}", "");

    for &size in &sizes {
        let mut key = vec![0u8; 32];
        let mut nonce = vec![0u8; 12];
        let aad = b"bench_aad";
        let mut plaintext = vec![0u8; size];
        let mut tag = vec![0u8; 16];
        let mut ciphertext = vec![0u8; size]; 

        unsafe {
            host_rand_bytes(key.as_mut_ptr(), 32);
            host_rand_bytes(nonce.as_mut_ptr(), 12);
            host_rand_bytes(plaintext.as_mut_ptr(), size as u32);
            host_reset_time();
        }

        let start = Instant::now();

        for _ in 0..target_ops {
            increment_nonce(&mut nonce);
            let res = unsafe {
                host_encrypt(
                    key.as_ptr(),
                    nonce.as_ptr(),
                    aad.as_ptr(),
                    aad.len() as u32,
                    plaintext.as_ptr(),
                    plaintext.len() as u32,
                    tag.as_mut_ptr(),
                    ciphertext.as_mut_ptr(),
                )
            };

            if res != 0 {
                eprintln!("Host encryption failed!");
                break;
            }
        }

        let total_elapsed = start.elapsed().as_nanos() as f64 / 1_000_000.0;

        let host_trampoline_nanos = unsafe { host_get_trampoline_time_nanos() };
        let host_openssl_nanos = unsafe { host_get_openssl_time_nanos() };
        let host_total_nanos = host_trampoline_nanos + host_openssl_nanos;

        let host_trampoline_elapsed = host_trampoline_nanos as f64 / 1_000_000.0;
        let host_openssl_elapsed = host_openssl_nanos as f64 / 1_000_000.0;
        let host_total_elapsed = host_total_nanos as f64 / 1_000_000.0;

        let wasm_elapsed = total_elapsed - host_total_elapsed;

        println!(
            "{:<10} {:<10} {:<12.4} {:<12.4} {:<12.4} {:<12.4}",
            size, target_ops, total_elapsed, host_trampoline_elapsed, host_openssl_elapsed, wasm_elapsed
        );
    }
}

fn increment_nonce(nonce: &mut [u8]) {
    for byte in nonce.iter_mut().rev() {
        *byte = byte.wrapping_add(1);
        if *byte != 0 {
            break;
        }
    }
}
