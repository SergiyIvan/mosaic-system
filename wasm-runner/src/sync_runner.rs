use std::path::PathBuf;

use anyhow::Context;
use wasmtime::component::{Component, Linker, Instance};
use wasmtime::{Engine, Store};
use wasmtime_wasi;

use wasmtime_state::States;


pub fn run(component_path: PathBuf) -> anyhow::Result<()> {
    let engine = Engine::default();
    let component = Component::from_file(&engine, component_path).context("Component file not found")?;

    let wasi_view = States::new();
    let mut store = Store::new(&engine, wasi_view);

    let mut linker: Linker<States> = Linker::new(&engine);
    wasmtime_wasi::p2::add_to_linker_sync(&mut linker).expect("Could not add wasi to linker");

    let instance = linker.instantiate(&mut store, &component)
        .context("Failed to instantiate the component")?;

    // let run_function: TypedFunc<(), ()> = instance
    //     .get_typed_func(&mut store, "wasi:cli/run@0.2.7::run")
    //     .context("`run` function not found")?;
    // let result = run_function.call(&mut store, ())?;
    // println!("Component finished with result: {:?}", result);
    execute_run_function(store, instance)?;
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
