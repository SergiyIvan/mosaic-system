use std::path::PathBuf;

use anyhow::Context;
use wasmtime::component::{Component, Linker};
use wasmtime::{Engine, Store};
use wasmtime_wasi;

use crate::state::States;

mod bindings {
    wasmtime::component::bindgen!({
        path: "../guest/wit/world.wit",
        world: "guest",
        async: false
    });
}


pub fn run(path: PathBuf) -> wasmtime::Result<u32> {
    let engine = Engine::default();
    let component = Component::from_file(&engine, path).context("Component file not found")?;

    let wasi_view = States::new();
    let mut store = Store::new(&engine, wasi_view);
    let mut linker: Linker<States> = Linker::new(&engine);

    wasmtime_wasi::p2::add_to_linker_sync(&mut linker).expect("Could not add wasi to linker");

    let mut hosted = linker.instance("docs:guest/hosted@0.1.0")?;
    hosted.func_wrap("host-function", |_store, (_arr,): (Vec<u8>,)| {
        // Currently, does nothing but prints a message.
        println!("TEST MESSAGE FROM HOST");

        // Does not have any effect on the original array object since Component Model copies data.
        for byte in arr.iter_mut() {
            *byte = 0xFF;
        }

        Ok(())
    })?;

    let instance = bindings::Guest::instantiate(&mut store, &component, &linker)
        .context("Failed to instantiate the example world")?;

    instance
        .docs_guest_runner()
        .call_run(&mut store)
        .context("calling run function")
}
