use wasmtime::component::LinkerInstance;
use wasmtime_state::States;

mod bindings {
    wasmtime::component::bindgen!({
        world: "adder-trampoline",
        async: false
    });
}

pub fn register_imports(
    hosted: &mut LinkerInstance<States>,
) {
    if let Err(e) = register_imports_impl(hosted) {
        eprintln!("Error registering imports: {e}");
    }
}

fn register_imports_impl(
    hosted: &mut LinkerInstance<States>,
) -> Result<(), Box<dyn std::error::Error>> {
    println!("Registering adder imports");

    hosted.func_wrap("host-function-print", |_store, (x,): (String,)| {
        println!("{}", x);
        Ok(())
    })?;

    println!("Adder imports registered");
    Ok(())
}
