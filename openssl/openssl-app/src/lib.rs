mod bindings {
    use super::ApplicationComponent;
    wit_bindgen::generate!();
    export!(ApplicationComponent);
}

use bindings::docs::openssl_app::hosted::{
    encrypt_aead, rand_bytes, CipherAlgorithm,
};
use std::time::{Duration, Instant};

struct ApplicationComponent;

impl bindings::exports::wasi::cli::run::Guest for ApplicationComponent {
    fn run() -> Result<(), ()> {
        let _ = run_benchmark().map_err(|e| eprintln!("Benchmark Error: {}", e));
        run_benchmark().map_err(|e| eprintln!("Benchmark Error: {}", e))
    }
}

fn run_benchmark() -> Result<(), String> {
    // Benchmark configuration.
    let sizes = [16, 64, 256, 1024, 8192, 16384];
    let seconds = 3;
    let aad = b"bench_aad";

    println!("Blocksize\tTotal ops\tThroughput (kB/s)\tSeconds");

    for &size in &sizes {
        let payload = rand_bytes(size as u64);
        let key = rand_bytes(32); // AES-256 key is 32 bytes.

        // To be incremented manually in the loop to avoid the overhead of calling host 'rand_bytes'.
        let mut nonce = vec![0u8; 12];

        // Preparing timer.
        let start = Instant::now();
        let limit = Duration::from_secs(seconds);
        let mut ops: usize = 0;

        // Benchmark Loop.
        loop {
            let now = Instant::now();
            let elapsed = now.duration_since(start);
            if elapsed >= limit {
                break;
            }

            // Increment nonce manually.
            increment_nonce(&mut nonce);

            // Encrypt.
            let _ = encrypt_aead(
                CipherAlgorithm::Aes256Gcm,
                &key,
                Some(&nonce),
                aad,
                &payload
            ).map_err(|e| e.to_string())?;

            ops += 1;
        }

        let total_elapsed = start.elapsed().as_secs_f64();
        let throughput_bytes = (ops as f64) * (size as f64);
        let throughput_kbs = throughput_bytes / total_elapsed / 1000.0;

        println!(
            "{}\t\t{}\t\t{:.2}\t\t{:.2}",
            size, ops, throughput_kbs, total_elapsed
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
