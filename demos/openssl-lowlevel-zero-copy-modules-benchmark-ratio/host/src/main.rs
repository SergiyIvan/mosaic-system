use anyhow::Result;
use openssl::symm::{Cipher, Crypter, Mode};
use openssl::rand::rand_bytes;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;
use std::time::{Duration, Instant};


struct ModuleState {
    wasi: WasiP1Ctx,
    trampoline_host_time: Duration,
    openssl_host_time: Duration
}

fn main() -> Result<()> {
    let engine = Engine::default();
    let mut linker: Linker<ModuleState> = Linker::new(&engine);
    preview1::add_to_linker_sync(&mut linker, |state| &mut state.wasi)?;

    let module = Module::from_file(&engine, "../guest/target/wasm32-wasip1/release/guest.wasm")?;

    // --- host_reset_time ---
    linker.func_wrap("env", "host_reset_time", |mut caller: Caller<'_, ModuleState>| {
        caller.data_mut().trampoline_host_time = Duration::ZERO;
        caller.data_mut().openssl_host_time = Duration::ZERO;
    })?;

    // --- host_get_trampoline_time_nanos ---
    linker.func_wrap("env", "host_get_trampoline_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().trampoline_host_time.as_nanos() as u64
    })?;

    // --- host_get_openssl_time_nanos ---
    linker.func_wrap("env", "host_get_openssl_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().openssl_host_time.as_nanos() as u64
    })?;

    // --- host_rand_bytes ---
    linker.func_wrap("env", "host_rand_bytes", |mut caller: Caller<'_, ModuleState>, ptr: i32, len: i32| {
        let mem = match caller.get_export("memory") {
            Some(Extern::Memory(mem)) => mem,
            _ => return,
        };
        let (data, _store) = mem.data_and_store_mut(&mut caller);

        let start = ptr as usize;
        let end = start + len as usize;
        if end > data.len() { return; }

        let slice = &mut data[start..end];
        let _ = rand_bytes(slice);
    })?;

    // --- host_encrypt ---
    linker.func_wrap("env", "host_encrypt",
            |mut caller: Caller<'_, ModuleState>,
            key_ptr: i32, iv_ptr: i32,
            aad_ptr: i32, aad_len: i32,
            pt_ptr: i32, pt_len: i32,
            tag_ptr: i32, ct_ptr: i32| -> u32 {
        let trampoline_time = Instant::now();
        let trampoline_elapsed: Duration;
        let openssl_time: Instant;

        let mem = match caller.get_export("memory") {
            Some(Extern::Memory(mem)) => mem,
            _ => return 1,
        };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let check_bounds = |offset: i32, len: i32| -> bool {
            let start = offset as usize;
            let end = start + (len as usize);
            end <= mem_len
        };

        if !check_bounds(key_ptr, 32) || !check_bounds(iv_ptr, 12) ||
           !check_bounds(aad_ptr, aad_len) || !check_bounds(pt_ptr, pt_len) ||
           !check_bounds(tag_ptr, 16) || !check_bounds(ct_ptr, pt_len) {
            return 1;
        }

        let res = unsafe {
            let key = std::slice::from_raw_parts(base_ptr.add(key_ptr as usize), 32);
            let iv = std::slice::from_raw_parts(base_ptr.add(iv_ptr as usize), 12);
            let aad = std::slice::from_raw_parts(base_ptr.add(aad_ptr as usize), aad_len as usize);
            let plaintext = std::slice::from_raw_parts(base_ptr.add(pt_ptr as usize), pt_len as usize);

            let ciphertext = std::slice::from_raw_parts_mut(base_ptr.add(ct_ptr as usize), pt_len as usize);
            let tag = std::slice::from_raw_parts_mut(base_ptr.add(tag_ptr as usize), 16);

            trampoline_elapsed = trampoline_time.elapsed();
            openssl_time = Instant::now();

            (|| -> Result<(), openssl::error::ErrorStack> {
                let cipher = Cipher::aes_256_gcm();
                let mut crypter = Crypter::new(cipher, Mode::Encrypt, key, Some(iv))?;
                crypter.aad_update(aad)?;

                let count = crypter.update(plaintext, ciphertext)?;
                let _rest = crypter.finalize(&mut ciphertext[count..])?;
                crypter.get_tag(tag)?;

                Ok(())
            })()
        };
        let openssl_elapsed = openssl_time.elapsed();
        caller.data_mut().trampoline_host_time += trampoline_elapsed;
        caller.data_mut().openssl_host_time += openssl_elapsed;

        match res {
            Ok(_) => 0,
            Err(_) => 1,
        }
    })?;

    let wasi = WasiCtxBuilder::new()
        .inherit_stdout()
        .inherit_stderr()
        .build_p1();

    let mut store = Store::new(&engine, ModuleState { wasi, trampoline_host_time: Duration::ZERO, openssl_host_time: Duration::ZERO });
    let instance = linker.instantiate(&mut store, &module)?;

    let run = instance.get_typed_func::<(), u32>(&mut store, "run")?;

    run.call(&mut store, ())?;

    Ok(())
}
