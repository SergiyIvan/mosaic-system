mod bindings {
    use super::ApplicationComponent;
    wit_bindgen::generate!();
    export!(ApplicationComponent);
}

use bindings::docs::openssl_app::hosted::*;

struct ApplicationComponent;

impl bindings::exports::wasi::cli::run::Guest for ApplicationComponent {
    fn run() -> Result<(), ()> {
        run_impl().map_err(|e| eprintln!("App Error: {}", e))
    }
}

fn run_impl() -> Result<(), String> {
    // Generate plain text message to be encrypted.
    let plaintext = b"Hello, Rust and OpenSSL (via Host)!";

    // Generate Key (32 bytes for AES-256).
    let key = rand_bytes(32);

    // Generate Nonce/IV (12 bytes for GCM).
    let nonce = rand_bytes(12);
    
    // Additional Data.
    let aad = b"additional data";

    // Encrypt.
    let result = encrypt_aead(
        CipherAlgorithm::Aes256Gcm,
        &key,
        Some(&nonce),
        aad,
        plaintext,
    ).map_err(|e| format!("Encryption failed: {}", e))?;

    println!("Plaintext:  {:?}", String::from_utf8_lossy(plaintext));
    println!("Key:        {}", hex::encode(&key));
    println!("Nonce:      {}", hex::encode(&nonce));
    println!("Ciphertext: {}", hex::encode(&result.ciphertext));
    println!("Auth Tag:   {}", hex::encode(&result.tag));

    // Decrypt to verify.
    let decrypted = decrypt_aead(
        CipherAlgorithm::Aes256Gcm,
        &key,
        Some(&nonce),
        aad,
        &result.ciphertext,
        &result.tag
    ).map_err(|e| format!("Decryption failed: {}", e))?;

    println!("Decrypted:  {:?}", String::from_utf8_lossy(&decrypted));

    Ok(())
}
