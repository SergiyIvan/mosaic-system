mod bindings {
    use super::ApplicationComponent;
    wit_bindgen::generate!();
    export!(ApplicationComponent);
}

use bindings::docs::adder_app::hosted::host_function_print;

struct ApplicationComponent;

impl bindings::exports::wasi::cli::run::Guest for ApplicationComponent {
    fn run() -> Result<(), ()> {
        host_function_print("Test string from Wasm.");
        Ok(())
    }
}
