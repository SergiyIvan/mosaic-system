use std::fs::File;
use std::io::Write;
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

    linker.func_wrap("env", "host_function", |mut caller: Caller<'_, ModuleState>| {
        let memory = match caller.get_export("memory") {
            Some(Extern::Memory(mem)) => mem,
            _ => return,
        };
        let (mem_slice, _state) = memory.data_and_store_mut(&mut caller);

        let hex_dump = hex::encode(&mut *mem_slice);
        let path = "memory_dump.hex";
        let mut file = File::create(path).expect("Failed to create the file.");
        file.write_all(hex_dump.as_bytes()).expect("Failed to write to the file.");

        println!("HOST:  Memory dumped to '{}' (Size: {} bytes)", path, mem_slice.len());
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
