use openssl::symm::{Cipher, encrypt_aead};
use openssl::rand::rand_bytes;
use std::time::{Instant};

const TARGET_OPS: usize = 1_000_000;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    println!("=== Starting Warmup ===");
    run_benchmark(100_000).map_err(|e| format!("Benchmark Warmup Error: {}", e))?;
    println!("=== Warmup Complete ===\n");

    let iterations = 5;
    for i in 1..=iterations {
        println!("=== Iteration {}/{} ===", i, iterations);
        run_benchmark(TARGET_OPS).map_err(|e| format!("Benchmark Error: {}", e))?;
        println!();
    }

    Ok(())
}

fn run_benchmark(target_ops: usize) -> Result<(), String> {
    // Benchmark configuration.
    let sizes = [16, 64, 256, 1024, 8192, 16384];
    let aad = b"bench_aad";
    let cipher = Cipher::aes_256_gcm();

    println!(
        "{:<10} {:<10} {:<12} {:<12} {:<12}", 
        "BlockSize", "Ops", "Total(ms)", "Host(ms)", "Wasm(ms)"
    );
    println!("{:-<60}", "");

    for &size in &sizes {
        let mut payload = vec![0u8; size];
        rand_bytes(&mut payload).map_err(|e| e.to_string())?;
        let mut key = [0u8; 32];
        rand_bytes(&mut key).map_err(|e| e.to_string())?;
        let mut nonce = vec![0u8; 12];

        let start = Instant::now();

        for _ in 0..target_ops {
            increment_nonce(&mut nonce);

            let mut tag = [0u8; 16];
            let _ = encrypt_aead(
                cipher,
                &key,
                Some(&nonce),
                aad,
                &payload,
                &mut tag
            ).map_err(|e| e.to_string())?;
        }

        let total_elapsed = start.elapsed().as_nanos() as f64 / 1_000_000.0;

        println!(
            "{:<10} {:<10} {:<12.4} {:<12.4} {:<12.4}",
            size, target_ops, total_elapsed, 0, 0
        );
    }

    Ok(())
}

fn increment_nonce(nonce: &mut [u8]) {
    for byte in nonce.iter_mut().rev() {
        *byte = byte.wrapping_add(1);
        if *byte != 0 {
            break;
        }
    }
}
