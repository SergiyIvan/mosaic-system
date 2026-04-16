use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;
use pagerank_lib::pagerank;


fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

    // --- host_pagerank ---
    linker.func_wrap("env", "host_pagerank",
        |mut caller: Caller<'_, ModuleState>,
         edges_ptr: i32, edges_len: i32,
         pr_ptr: i32, pr_len: i32,
         iterations: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let bounds_ok = (edges_ptr as usize + (edges_len as usize * 4) <= mem_len) &&
                        (pr_ptr as usize + (pr_len as usize * 4) <= mem_len);

        if !bounds_ok { return 0; }

        unsafe {
            let edges_slice = std::slice::from_raw_parts(
                base_ptr.add(edges_ptr as usize) as *const u32,
                edges_len as usize
            );
            let pr_slice = std::slice::from_raw_parts_mut(
                base_ptr.add(pr_ptr as usize) as *mut f32,
                pr_len as usize
            );

            pagerank(edges_slice, pr_slice, iterations as u32);
        };

        1 // Success.
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let benchmark_name = "pagerank";

    let args: Vec<String> = std::env::args().collect();
    let duration_seconds = args.get(1).and_then(|s| s.parse().ok()).unwrap_or(30);
    let warmup_iterations = args.get(2).and_then(|s| s.parse().ok()).unwrap_or(5);
    let wasm_path = args
        .get(3)
        .cloned()
        .unwrap_or_else(|| {
            // For cdylib, rustc replaces '-' with '_'. We replace it back here for the default path.
            let safe_filename = benchmark_name.replace("-", "_");
            format!("../guest/target/wasm32-wasip1/release/{}.wasm", safe_filename)
        });

    runner::benchmark_wasm(benchmark_name, &wasm_path, duration_seconds, warmup_iterations, register_host_funcs)
}
