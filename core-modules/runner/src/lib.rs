use anyhow::Result;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;
use std::time::{Duration, Instant};

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

pub fn benchmark_wasm<F>(
    benchmark_name: &str,
    wasm_path: &str,
    duration_seconds: u64,
    warmup_iterations: u32,
    register_custom_funcs: F,
) -> Result<()>
where
    F: FnOnce(&mut Linker<ModuleState>) -> Result<()>,
{
    let engine = Engine::default();
    let mut linker: Linker<ModuleState> = Linker::new(&engine);
    preview1::add_to_linker_sync(&mut linker, |state| &mut state.wasi)?;

    let module = Module::from_file(&engine, wasm_path)?;

    register_custom_funcs(&mut linker)?;

    let wasi = WasiCtxBuilder::new().inherit_stdout().inherit_stderr().build_p1();

    let mut store = Store::new(&engine, ModuleState {
        wasi, trampoline_time: Duration::ZERO, compute_time: Duration::ZERO
    });

    let instance = linker.instantiate(&mut store, &module)?;
    let run = instance.get_typed_func::<(), u32>(&mut store, "run")?;

    eprintln!("==> Starting Warmup ({} iterations)...", warmup_iterations);
    for _ in 0..warmup_iterations {
        run.call(&mut store, ())?;
    }

    eprintln!("==> Running Benchmark ({}) for {} seconds...", benchmark_name, duration_seconds);
    let mut iterations = 0;
    let start_time = Instant::now();
    let target_duration = Duration::from_secs(duration_seconds);

    while start_time.elapsed() < target_duration {
        let res = run.call(&mut store, ())?;
        if res != 0 {
            eprintln!("Warning: Guest returned non-zero status code: {}", res);
        }
        iterations += 1;
    }

    let elapsed = start_time.elapsed().as_secs_f64();
    let rps = iterations as f64 / elapsed;

    println!("{{");
    println!("  \"benchmark\": \"{}\",", benchmark_name);
    println!("  \"duration_seconds\": {:.2},", elapsed);
    println!("  \"iterations\": {},", iterations);
    println!("  \"throughput_rps\": {:.2}", rps);
    println!("}}");

    Ok(())
}
