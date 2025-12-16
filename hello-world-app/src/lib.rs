mod bindings {
    use super::ApplicationComponent;
    wit_bindgen::generate!();
    export!(ApplicationComponent);
}

struct ApplicationComponent;

impl bindings::exports::wasi::cli::run::Guest for ApplicationComponent {
    fn run() -> Result<(), ()> {
        println!("Hello world from Wasm!");
        Ok(())
    }
}
