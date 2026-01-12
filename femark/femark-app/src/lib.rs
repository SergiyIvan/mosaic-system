mod bindings {
    use super::ApplicationComponent;
    wit_bindgen::generate!();
    export!(ApplicationComponent);
}

use bindings::docs::femark_app::hosted::*;

struct ApplicationComponent;

impl bindings::exports::wasi::cli::run::Guest for ApplicationComponent {
    fn run() -> Result<(), ()> {
        match process_markdown_to_html_with_frontmatter("# Header\n\n\nNormal text\n ## Smaller header", false) {
            Ok(result) => println!("Result: {}", result.content),
            Err(e) => eprintln!("Error: {}", e),
        }
        Ok(())
    }
}
