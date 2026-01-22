use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;

struct ModuleState {
    wasi: WasiP1Ctx,
}

fn main() -> Result<()> {
    let engine = Engine::default();
    let mut linker: Linker<ModuleState> = Linker::<ModuleState>::new(&engine);
    preview1::add_to_linker_sync(&mut linker, |state| &mut state.wasi)?;
    let module = Module::from_file(&engine, "../guest/target/wasm32-wasip1/release/guest.wasm")?;

    linker.func_wrap("env", "host_function", |mut caller: Caller<'_, ModuleState>, ptr: i32, len: i32| {

        let memory = match caller.get_export("memory") {
            Some(Extern::Memory(mem)) => mem,
            _ => return, // Should handle error here.
        };

        // Base + Offset.
        // data_mut() gives us a slice of the entire Wasm memory.
        let (mem_slice, _state) = memory.data_and_store_mut(&mut caller);

        let start = ptr as usize;
        let end = start + len as usize;
        // Safety check to prevent panics.
        if end > mem_slice.len() {
            eprintln!("HOST: Guest tried to access out of bounds memory!");
            return;
        }

        let array_view = &mut mem_slice[start..end];
        println!("HOST:  Modifying memory at offset {}", start);
        for byte in array_view.iter_mut() {
            *byte = 0xFF;
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
