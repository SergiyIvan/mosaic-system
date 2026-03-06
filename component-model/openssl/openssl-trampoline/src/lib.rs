use wasmtime::component::LinkerInstance;
use wasmtime_state::States;
use openssl::symm::{Cipher, encrypt_aead as openssl_encrypt, decrypt_aead as openssl_decrypt};
use openssl::rand::rand_bytes as openssl_rand;
use bindings::docs::openssl_trampoline::hosted::{CipherAlgorithm, EncryptResult};

mod bindings {
    wasmtime::component::bindgen!({
        world: "openssl-trampoline",
        async: false
    });
}

pub fn register_imports(hosted: &mut LinkerInstance<States>) {
    if let Err(e) = register_imports_impl(hosted) {
        eprintln!("Error registering OpenSSL imports: {e}");
    }
}

fn register_imports_impl(
    hosted: &mut LinkerInstance<States>,
) -> Result<(), Box<dyn std::error::Error>> {
    println!("Registering OpenSSL imports");

    // --- rand-bytes ---
    hosted.func_wrap(
        "rand-bytes",
        |_store, (len,): (u64,)| {
            let mut buf = vec![0u8; len as usize];
            match openssl_rand(&mut buf) {
                Ok(_) => Ok((buf,)),
                Err(_) => Ok((vec![],)),
            }
        },
    )?;

    // --- encrypt-aead ---
    hosted.func_wrap(
        "encrypt-aead",
        |_store, (alg, key, iv, aad, plaintext): (CipherAlgorithm, Vec<u8>, Option<Vec<u8>>, Vec<u8>, Vec<u8>)| {
            let cipher = map_algorithm(alg);
            
            // OpenSSL requires us to provide a buffer for the tag.
            // For GCM, standard tag length is 16 bytes.
            let mut tag = vec![0u8; 16];

            let res = openssl_encrypt(
                cipher,
                &key,
                iv.as_deref(), // Convert Option<Vec<u8>> to Option<&[u8]>.
                &aad,
                &plaintext,
                &mut tag
            );

            match res {
                Ok(ciphertext) => Ok((Ok(EncryptResult {
                    ciphertext,
                    tag
                }),)),
                Err(e) => Ok((Err(format!("Host OpenSSL Error: {}", e)),))
            }
        },
    )?;

    // --- decrypt-aead ---
    hosted.func_wrap(
        "decrypt-aead",
        |_store, (alg, key, iv, aad, ciphertext, tag): (CipherAlgorithm, Vec<u8>, Option<Vec<u8>>, Vec<u8>, Vec<u8>, Vec<u8>)| {
            let cipher = map_algorithm(alg);

            let res = openssl_decrypt(
                cipher,
                &key,
                iv.as_deref(),
                &aad,
                &ciphertext,
                &tag
            );

            match res {
                Ok(plaintext) => Ok((Ok(plaintext),)),
                Err(e) => Ok((Err(format!("Host OpenSSL Error: {}", e)),))
            }
        },
    )?;

    println!("OpenSSL imports registered");
    Ok(())
}

// Helper to map WIT Enum to Native OpenSSL Cipher struct.
fn map_algorithm(alg: CipherAlgorithm) -> Cipher {
    match alg {
        CipherAlgorithm::Aes256Gcm => Cipher::aes_256_gcm(),
    }
}
