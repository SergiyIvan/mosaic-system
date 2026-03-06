use openssl::symm::{Cipher, encrypt_aead, decrypt_aead};
use openssl::rand::rand_bytes;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // The plaintext to encrypt.
    let plaintext = b"Hello, Rust and OpenSSL!";

    // AES-256 requires a 32-byte (256-bit) key.
    let mut key = [0u8; 32];
    rand_bytes(&mut key)?;

    // GCM typically uses a 12-byte (96-bit) nonce/IV.
    let mut nonce = [0u8; 12];
    rand_bytes(&mut nonce)?;

    // Optional additional authenticated data (AAD).
    let aad = b"additional data";

    // Tag will store the authentication tag (16 bytes for GCM).
    let mut tag = [0u8; 16];

    // Encrypt.
    let cipher = Cipher::aes_256_gcm();
    let ciphertext = encrypt_aead(
        cipher,
        &key,
        Some(&nonce),
        aad,
        plaintext,
        &mut tag,
    )?;

    println!("Plaintext:  {:?}", String::from_utf8_lossy(plaintext));
    println!("Key:        {}", hex::encode(&key));
    println!("Nonce:      {}", hex::encode(&nonce));
    println!("Ciphertext: {}", hex::encode(&ciphertext));
    println!("Auth Tag:   {}", hex::encode(&tag));

    // Decrypt to verify.
    let decrypted = decrypt_aead(
        cipher,
        &key,
        Some(&nonce),
        aad,
        &ciphertext,
        &tag,
    )?;

    println!("Decrypted:  {:?}", String::from_utf8_lossy(&decrypted));

    Ok(())
}
