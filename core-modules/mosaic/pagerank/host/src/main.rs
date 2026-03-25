use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;


fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

    // --- host_pagerank ---
    linker.func_wrap("env", "host_pagerank",
        |mut caller: Caller<'_, ModuleState>,
         edges_ptr: i32, edges_len: i32,
         pr_ptr: i32, pr_len: i32| -> u32 {

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

            let num_nodes = pr_len as usize;
            let mut out_degree = vec![0.0f32; num_nodes];
            let mut in_edges = vec![Vec::<u32>::new(); num_nodes];

            // 1. Build the Adjacency List (CSR format proxy).
            for chunk in edges_slice.chunks_exact(2) {
                let u = chunk[0] as usize;
                let v = chunk[1] as usize;
                out_degree[u] += 1.0;
                in_edges[v].push(u as u32);
            }

            // 2. Initialize PageRank.
            for p in pr_slice.iter_mut() {
                *p = 1.0 / (num_nodes as f32);
            }

            let damping = 0.85;
            let mut next_pr = vec![0.0f32; num_nodes];

            // 3. PageRank loop (20 iterations) - highly vectorizable loop structure (by the compiler).
            for _ in 0..20 {
                let base_pr = (1.0 - damping) / (num_nodes as f32);
                for i in 0..num_nodes {
                    let mut sum = 0.0;
                    for &in_node in &in_edges[i] {
                        sum += pr_slice[in_node as usize] / out_degree[in_node as usize];
                    }
                    next_pr[i] = base_pr + damping * sum;
                }
                pr_slice.copy_from_slice(&next_pr);
            }
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
