use std::path::PathBuf;

use anyhow::Context;
use wasmtime::component::{Component, Linker, Instance};
use wasmtime::{Engine, Store};
use wasmtime_wasi;
use wasmtime_state::States;
use crate::ImportRegistrar;


pub fn run<R>(component_path: PathBuf, registrar: R) -> anyhow::Result<()>
where
    R: ImportRegistrar<States>,
{
    let engine = Engine::default();
    let component = Component::from_file(&engine, component_path).context("Component file not found")?;

    let wasi_view = States::new();
    let mut store = Store::new(&engine, wasi_view);

    let mut linker: Linker<States> = Linker::new(&engine);
    wasmtime_wasi::p2::add_to_linker_sync(&mut linker).expect("Could not add wasi to linker");

    registrar.register_imports(&mut linker)?;

    println!("Instantiating component...");
    let inst_result = linker.instantiate(&mut store, &component);

    match inst_result {
        Ok(instance) => {
            println!("Instance created successfully");
            execute_run_function(store, instance)?;
        }
        Err(e) => {
            println!("Instantiation failed: {e:?}");
            return Err(e).context("Failed to instantiate the component");
        }
    };

    Ok(())
}

fn execute_run_function(
    mut store: Store<States>,
    instance: Instance,
) -> anyhow::Result<()> {
    let iface_idx = instance
        .get_export_index(&mut store, None, "wasi:cli/run@0.2.7")
        .context("Cannot get 'wasi:cli/run@0.2.7' exported interface.")?;

    let func_idx = instance
        .get_export_index(&mut store, Some(&iface_idx), "run")
        .context("Missing 'run' function in 'wasi:cli/run@0.2.7' interface.")?;

    let func = instance
        .get_func(&mut store, func_idx)
        .context("Export is not a function.")?;

    let mut result = [wasmtime::component::Val::U64(0)];
    func.call(&mut store, &[], &mut result)?;
    Ok(())
}
