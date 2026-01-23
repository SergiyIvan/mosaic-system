use anyhow::Result;
use openssl::symm::{encrypt_aead, Cipher};
use openssl::rand::rand_bytes;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;

struct ModuleState {
    wasi: WasiP1Ctx,
}

fn main() -> Result<()> {
    let engine = Engine::default();
    let mut linker: Linker<ModuleState> = Linker::new(&engine);
    preview1::add_to_linker_sync(&mut linker, |state| &mut state.wasi)?;

    let module = Module::from_file(&engine, "../guest/target/wasm32-wasip1/release/guest.wasm")?;

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

        let mem = match caller.get_export("memory") {
            Some(Extern::Memory(mem)) => mem,
            _ => return 1,
        };
        let (mem_slice, _store) = mem.data_and_store_mut(&mut caller);

        let get_slice = |offset: i32, len: i32| -> Option<&[u8]> {
            let start = offset as usize;
            let end = start + len as usize;
            if end > mem_slice.len() { None } else { Some(&mem_slice[start..end]) }
        };

        let key = match get_slice(key_ptr, 32) { Some(s) => s, None => return 1 };
        let iv = match get_slice(iv_ptr, 12) { Some(s) => s, None => return 1 };
        let aad = match get_slice(aad_ptr, aad_len) { Some(s) => s, None => return 1 };
        let plaintext = match get_slice(pt_ptr, pt_len) { Some(s) => s, None => return 1 };

        let mut temp_tag = [0u8; 16];
        let cipher = Cipher::aes_256_gcm();

        let res = encrypt_aead(
            cipher,
            key,
            Some(iv),
            aad,
            plaintext,
            &mut temp_tag 
        );

        match res {
            Ok(ciphertext_vec) => {
                // Now we are done reading, we can get mutable access to write back.
                // let ct_len = ciphertext_vec.len();
                // let ct_start = ct_ptr as usize;
                // let ct_end = ct_start + ct_len;

                // if ct_end <= mem_slice.len() {
                //     mem_slice[ct_start..ct_end].copy_from_slice(&ciphertext_vec);
                // } else {
                //     return 1;
                // }

                // let tag_start = tag_ptr as usize;
                // let tag_end = tag_start + 16;
                // if tag_end <= mem_slice.len() {
                //     mem_slice[tag_start..tag_end].copy_from_slice(&temp_tag);
                // } else {
                //     return 1;
                // }

                0 // Success.
            },
            Err(_) => 1 // Error.
        }
    })?;

    let wasi = WasiCtxBuilder::new()
        .inherit_stdout()
        .inherit_stderr()
        .build_p1();

    let mut store = Store::new(&engine, ModuleState { wasi });
    let instance = linker.instantiate(&mut store, &module)?;

    let run = instance.get_typed_func::<(), u32>(&mut store, "run")?;

    run.call(&mut store, ())?;

    Ok(())
}
