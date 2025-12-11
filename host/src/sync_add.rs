use std::path::PathBuf;

use anyhow::Context;
use wasmtime::component::{Component, Linker};
use wasmtime::{Engine, Store};
use wasmtime_wasi;

use crate::state::States;

mod bindings {
    wasmtime::component::bindgen!({
        path: "../adder/wit/world.wit",
        world: "adder",
        async: false
    });
}


pub fn add(path: PathBuf, x: u32, y: u32) -> wasmtime::Result<u32> {
    // Construct engine
    let engine = Engine::default();

    // Construct component
    let component = Component::from_file(&engine, path).context("Component file not found")?;

    // Construct store for storing running states of the component
    let wasi_view = States::new();
    let mut store = Store::new(&engine, wasi_view);

    // Construct linker for linking interfaces.
    let mut linker: Linker<States> = Linker::new(&engine);

    // Add wasi exports to linker to support I/O (as in `wasi:io`) interfaces
    // see: https://github.com/WebAssembly/wasi-io
    wasmtime_wasi::p2::add_to_linker_sync(&mut linker).expect("Could not add wasi to linker");

    let mut hosted = linker.instance("docs:adder/hosted@0.1.0")?;
    hosted.func_wrap("host-function", |_store, (x,): (u32,)| {
        Ok((x * 2,))
    })?;
    hosted.func_wrap("host-function-print", |_store, (x,): (String,)| {
        println!("{}", x);
        Ok(())
    })?;

    // Instantiate the component as an instance of the `adder` world,
    // with the generated bindings
    let instance = bindings::Adder::instantiate(&mut store, &component, &linker)
        .context("Failed to instantiate the example world")?;

    // Call the add function on instance
    instance
        .docs_adder_add()
        .call_add(&mut store, x, y)
        .context("calling add function")
}
