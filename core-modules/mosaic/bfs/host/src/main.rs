use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;

use petgraph::graph::UnGraph;
use petgraph::visit::Bfs;


fn bfs(edges: &[u32], out_order: &mut [u32], num_nodes: usize, start_node: usize) -> u32 {
    let mut graph = UnGraph::<(), ()>::with_capacity(num_nodes, edges.len() / 2);
    let mut nodes = Vec::with_capacity(num_nodes);

    for _ in 0..num_nodes {
        nodes.push(graph.add_node(()));
    }

    for chunk in edges.chunks_exact(2) {
        let u = chunk[0] as usize;
        let v = chunk[1] as usize;
        graph.add_edge(nodes[u], nodes[v], ());
    }

    let mut bfs = Bfs::new(&graph, nodes[start_node]);
    let mut count = 0;

    while let Some(nx) = bfs.next(&graph) {
        if count < out_order.len() {
            out_order[count] = nx.index() as u32;
        }
        count += 1;
    }

    count as u32
}

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

            bfs(edges_slice, out_slice, num_nodes as usize, start_node as usize)
        };

        visited_count
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let benchmark_name = "bfs";

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
