use std::path::PathBuf;

mod state;
mod sync_add;


pub fn execute_wasm_runner() -> anyhow::Result<()> {
    let component_path: PathBuf = PathBuf::from("/home/sergiyivan/work/mosaic/system/adder/target/wasm32-wasip2/release/adder.wasm");

    let x = 55;
    let y = 55;
    let sum = sync_add::add(component_path, x, y)?;
    println!("{}*2 + {} = {sum}", x, y);
    Ok(())
}

fn main() -> anyhow::Result<()> {
    return execute_wasm_runner();
}
