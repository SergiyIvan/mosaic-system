use anyhow::Result;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;
use std::time::Duration;

pub struct ModuleState {
    pub wasi: WasiP1Ctx,
    pub trampoline_time: Duration,
    pub compute_time: Duration,
}


pub fn run_wasm<F>(wasm_path: &str, register_custom_funcs: F) -> Result<()> where F: FnOnce(&mut Linker<ModuleState>) -> Result<()> {
    let engine = Engine::default();
    let mut linker: Linker<ModuleState> = Linker::new(&engine);
    preview1::add_to_linker_sync(&mut linker, |state| &mut state.wasi)?;

    let module = Module::from_file(&engine, wasm_path)?;

    linker.func_wrap("env", "host_reset_time", |mut caller: Caller<'_, ModuleState>| {
        caller.data_mut().trampoline_time = Duration::ZERO;
        caller.data_mut().compute_time = Duration::ZERO;
    })?;

    linker.func_wrap("env", "host_get_trampoline_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().trampoline_time.as_nanos() as u64
    })?;

    linker.func_wrap("env", "host_get_compute_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().compute_time.as_nanos() as u64
    })?;

    register_custom_funcs(&mut linker)?;

    let wasi = WasiCtxBuilder::new().inherit_stdout().inherit_stderr().build_p1();
    let mut store = Store::new(&engine, ModuleState {
        wasi, trampoline_time: Duration::ZERO, compute_time: Duration::ZERO
    });

    let instance = linker.instantiate(&mut store, &module)?;
    let run = instance.get_typed_func::<(), u32>(&mut store, "run")?;
    run.call(&mut store, ())?;

    Ok(())
}
