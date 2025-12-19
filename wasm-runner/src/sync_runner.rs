use std::path::PathBuf;
use libloading::{Library, Symbol};

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

    // TODO: keep instances of libraries in some global state, probably in States: https://copilot.microsoft.com/shares/Y2Ts6KwkZ7KBbwR6m9w71
    let lib = Box::leak(Box::new(unsafe { Library::new("/home/sergiyivan/work/mosaic/system/femark-trampoline/target/release/libfemark_trampoline.so")? }));
    unsafe {
        let register_imports_function: Symbol<
            unsafe extern "C" fn(linker: &mut Linker<States>),
        > = lib.get(b"register_imports")?;
        println!("Function pointer address: {:p}", *register_imports_function);
        register_imports_function(&mut linker);
        println!("Imports registered successfully");
    }

    // let instance = linker.instantiate(&mut store, &component)
    //     .context("Failed to instantiate the component")?;

    println!("Instantiating component...");
    let inst_result = linker.instantiate(&mut store, &component);

    match inst_result {
        Ok(instance) => {
            println!("Instance created successfully");
            println!("********Before call");
            execute_run_function(store, instance)?;
            println!("********After call 2");
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
    println!("********After call");
    Ok(())
}
