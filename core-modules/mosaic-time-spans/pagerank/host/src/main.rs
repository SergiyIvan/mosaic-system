use anyhow::Result;
use std::time::Instant;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;


fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

    // --- host_pagerank ---
    linker.func_wrap("env", "host_pagerank",
        |mut caller: Caller<'_, ModuleState>,
         edges_ptr: i32, edges_len: i32,
         pr_ptr: i32, pr_len: i32| -> u32 {

        let tramp_start = Instant::now();

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

            let tramp_duration = tramp_start.elapsed();
            let compute_start = Instant::now();

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

            let compute_duration = compute_start.elapsed();

            caller.data_mut().trampoline_time += tramp_duration;
            caller.data_mut().compute_time += compute_duration;
        };

        1 // Success.
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let wasm_path = "../guest/target/wasm32-wasip1/release/guest.wasm";
    runner::run_wasm(wasm_path, register_host_funcs)
}
