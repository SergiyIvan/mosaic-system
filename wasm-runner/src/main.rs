use std::env;
use std::path::PathBuf;

mod sync_runner;

pub fn execute_wasm_runner(component_path: PathBuf) -> anyhow::Result<()> {
    sync_runner::run(component_path)?;
    println!("********After call 3");
    Ok(())
}

fn main() -> anyhow::Result<()> {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: {} <component_path>", args[0]);
        std::process::exit(1);
    }

    let component_path = PathBuf::from(&args[1]);
    execute_wasm_runner(component_path)?;
    println!("********After call 4");
    Ok(())
}
