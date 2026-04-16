use petgraph::algo::min_spanning_tree;
use petgraph::data::Element;
use petgraph::graph::UnGraph;
use anyhow::Result;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;


fn mst(edges: &[u32], out_edges: &mut [u32], num_nodes: usize) -> u32 {
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

    let mst_result = min_spanning_tree(&graph);
    let mut mst_edge_count = 0;

    for element in mst_result {
        if let Element::Edge { source, target, .. } = element {
            // Write pairs (source, target) into the flat output array.
            if (mst_edge_count * 2) + 1 < out_edges.len() {
                out_edges[mst_edge_count * 2] = source as u32;
                out_edges[mst_edge_count * 2 + 1] = target as u32;
                mst_edge_count += 1;
            }
        }
    }

    mst_edge_count as u32
}

fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

    // --- host_mst ---
    linker.func_wrap("env", "host_mst",
        |mut caller: Caller<'_, ModuleState>,
         edges_ptr: i32, edges_len: i32,
         out_ptr: i32, max_out_len: i32,
         num_nodes: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let bounds_ok = (edges_ptr as usize + (edges_len as usize * 4) <= mem_len) &&
                        (out_ptr as usize + (max_out_len as usize * 4) <= mem_len);

        if !bounds_ok { return 0; }

        let edges_in_tree = unsafe {
            let edges_slice = std::slice::from_raw_parts(
                base_ptr.add(edges_ptr as usize) as *const u32,
                edges_len as usize
            );

            let out_slice = std::slice::from_raw_parts_mut(
                base_ptr.add(out_ptr as usize) as *mut u32,
                max_out_len as usize
            );

            mst(edges_slice, out_slice, num_nodes as usize)
        };

        edges_in_tree
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let benchmark_name = "mst";

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
