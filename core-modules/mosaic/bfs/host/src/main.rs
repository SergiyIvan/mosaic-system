use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;

use std::collections::VecDeque;


fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

    // --- host_bfs ---
    linker.func_wrap("env", "host_bfs",
        |mut caller: Caller<'_, ModuleState>,
        edges_ptr: i32, edges_len: i32,
        out_ptr: i32, max_out_len: i32,
        num_nodes: i32, start_node: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let bounds_ok = (edges_ptr as usize + (edges_len as usize * 4) <= mem_len) &&
                        (out_ptr as usize + (max_out_len as usize * 4) <= mem_len);

        if !bounds_ok { return 0; }

        let visited_count = unsafe {
            let edges_slice = std::slice::from_raw_parts(
                base_ptr.add(edges_ptr as usize) as *const u32,
                edges_len as usize
            );

            let out_slice = std::slice::from_raw_parts_mut(
                base_ptr.add(out_ptr as usize) as *mut u32,
                max_out_len as usize
            );

            let num_nodes_usize = num_nodes as usize;

            // 1. Build adjacency list (undirected).
            let mut adj = vec![Vec::new(); num_nodes_usize];
            for chunk in edges_slice.chunks_exact(2) {
                let u = chunk[0] as usize;
                let v = chunk[1] as usize;
                adj[u].push(v as u32);
                adj[v].push(u as u32);
            }

            // 2. BFS initialization.
            let mut visited = vec![false; num_nodes_usize];
            let mut queue = VecDeque::with_capacity(num_nodes_usize);

            let mut count = 0;

            if (start_node as usize) < num_nodes_usize {
                visited[start_node as usize] = true;
                queue.push_back(start_node as u32);

                // 3. Traversal loop.
                while let Some(node) = queue.pop_front() {
                    // Record visitation order directly into Wasm memory.
                    if count < max_out_len as usize {
                        out_slice[count] = node;
                    }
                    count += 1;

                    for &neighbor in &adj[node as usize] {
                        if !visited[neighbor as usize] {
                            visited[neighbor as usize] = true;
                            queue.push_back(neighbor);
                        }
                    }
                }
            }

            count as u32
        };

        visited_count
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let wasm_path = "../guest/target/wasm32-wasip1/release/guest.wasm";

    let args: Vec<String> = std::env::args().collect();
    let duration_seconds = args.get(1).and_then(|s| s.parse().ok()).unwrap_or(30);
    let warmup_iterations = args.get(2).and_then(|s| s.parse().ok()).unwrap_or(5);

    runner::benchmark_wasm("bfs", wasm_path, duration_seconds, warmup_iterations, register_host_funcs)
}
