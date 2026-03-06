use std::path::PathBuf;

use anyhow::Result;
use wasmtime::component::Linker;
use wasmtime_state::States;

pub mod sync_runner;

/// Trait to be implemented by the application runner to register app-specific imports.
pub trait ImportRegistrar<S> {
    fn register_imports(&self, linker: &mut Linker<S>) -> Result<()>;
}

/// Run a component with a given import registrar.
///
/// App runners call this, passing app-specific registrar implementation.
pub fn execute_wasm_runner<R>(component_path: PathBuf, registrar: R) -> Result<()>
where
    R: ImportRegistrar<States>,
{
    sync_runner::run(component_path, registrar)
}
