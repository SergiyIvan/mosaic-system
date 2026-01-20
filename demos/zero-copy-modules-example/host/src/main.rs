use wasmtime::*;

fn main() -> Result<()> {
    let engine = Engine::default();
    let module = Module::from_file(&engine, "../guest/target/wasm32-unknown-unknown/release/guest.wasm")?;

    let mut store = Store::new(&engine, ());
    let mut linker = Linker::new(&engine);

    linker.func_wrap("env", "host_print", |mut caller: Caller<'_, ()>, ptr: i32, len: i32| {
        let memory = match caller.get_export("memory") {
            Some(Extern::Memory(mem)) => mem,
            _ => return, // Should handle error here.
        };

        let (mem_slice, _ctx) = memory.data_and_store_mut(&mut caller);

        let start = ptr as usize;
        let end = start + len as usize;
        if end > mem_slice.len() {
             eprintln!("Guest tried to print out of bounds!");
             return;
        }

        let text_bytes = &mem_slice[start..end];
        let text_str = std::str::from_utf8(text_bytes).unwrap_or("<non-utf8 string>");
        print!("{}", text_str);
    })?;

    linker.func_wrap("env", "host_function", |mut caller: Caller<'_, ()>, ptr: i32, len: i32| {

        let memory = match caller.get_export("memory") {
            Some(Extern::Memory(mem)) => mem,
            _ => return, // Should handle error here.
        };

        // Base + Offset.
        // data_mut() gives us a slice of the entire Wasm memory.
        let (mem_slice, _ctx) = memory.data_and_store_mut(&mut caller);

        let start = ptr as usize;
        let end = start + len as usize;
        let array_view = &mut mem_slice[start..end];

        println!("HOST:  Modifying memory at offset {}", start);

        for byte in array_view.iter_mut() {
            *byte = 0xFF;
        }
    })?;

    let instance = linker.instantiate(&mut store, &module)?;
    let run = instance.get_typed_func::<(), u32>(&mut store, "run")?;

    run.call(&mut store, ())?;

    Ok(())
}
