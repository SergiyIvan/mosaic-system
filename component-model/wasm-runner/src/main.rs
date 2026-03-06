use std::env;
use std::path::PathBuf;
use anyhow::Result;
use wasm_runner::{execute_wasm_runner, ImportRegistrar};
use wasmtime::component::Linker;
use wasmtime_state::States;

/// Only to be used by simple components not using host functions.
struct StubRegistrar;
impl ImportRegistrar<States> for StubRegistrar {
    fn register_imports(&self, _linker: &mut Linker<States>) -> Result<()> {
        Ok(())
    }
}

fn main() -> anyhow::Result<()> {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: {} <component_path>", args[0]);
        std::process::exit(1);
    }

    let component_path = PathBuf::from(&args[1]);
    execute_wasm_runner(component_path, StubRegistrar)
}
