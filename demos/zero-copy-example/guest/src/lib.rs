mod bindings {
    wit_bindgen::generate!({
        path: "wit/world.wit",
    });

    use super::AppComponent;
    export!(AppComponent);
}

use bindings::docs::guest::hosted::host_function;

struct AppComponent;

impl bindings::exports::docs::guest::runner::Guest for AppComponent {
    fn run() -> u32 {
        let arr = vec![0u8; 16];
        println!("Array before:   {}", hex::encode(&arr));
        host_function(&arr);
        println!("Array after:    {}", hex::encode(&arr));
        0
    }
}
