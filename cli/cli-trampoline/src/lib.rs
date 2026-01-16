use wasmtime::component::LinkerInstance;
use wasmtime_state::States;
use std::process::Command;
use std::fs;

mod bindings {
    wasmtime::component::bindgen!({
        world: "cli-trampoline",
        async: false
    });
}

pub fn register_imports(hosted: &mut LinkerInstance<States>) {
    if let Err(e) = register_imports_impl(hosted) {
        eprintln!("Error registering CLI imports: {e}");
    }
}

fn register_imports_impl(
    hosted: &mut LinkerInstance<States>,
) -> Result<(), Box<dyn std::error::Error>> {
    println!("Registering CLI imports");

    // --- system(cmd) ---
    hosted.func_wrap(
        "system",
        |_store, (cmd,): (String,)| {
            let status_res = Command::new("sh")
                .arg("-c")
                .arg(&cmd)
                .status();

            match status_res {
                Ok(status) => {
                    // Return the exit code.
                    let code = status.code().unwrap_or(0) as u32;
                    Ok((Ok(code),))
                },
                Err(e) => Ok((Err(format!("Host process error: {}", e)),)),
            }
        },
    )?;

    // --- get-file-size(path) ---
    hosted.func_wrap(
        "get-file-size",
        |_store, (path,): (String,)| {
            // Uses host native filesystem, bypassing WASI sandbox.
            match fs::metadata(&path) {
                Ok(metadata) => Ok((Ok(metadata.len()),)),
                Err(e) => Ok((Err(format!("Host fs error: {}", e)),)),
            }
        },
    )?;

    println!("CLI imports registered");
    Ok(())
}
