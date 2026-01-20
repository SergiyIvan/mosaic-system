use std::path::PathBuf;

mod state;
mod sync_run;


pub fn execute_wasm_runner() -> anyhow::Result<()> {
    let component_path: PathBuf = PathBuf::from("../guest/target/wasm32-wasip2/release/guest.wasm");

    let _ = sync_run::run(component_path)?;
    Ok(())
}

fn main() -> anyhow::Result<()> {
    return execute_wasm_runner();
}
