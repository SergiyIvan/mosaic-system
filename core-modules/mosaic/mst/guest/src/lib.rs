use rand::Rng;
use serde::Deserialize;
use proxy_guest::export_mosaic_function;


#[derive(Deserialize)]
struct MstInput {
    size: Option<usize>,
    m: Option<usize>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Runs MST (Union-Find). Returns the number of edges added to the spanning tree.
    fn host_mst(
        edges_ptr: *const u32, edges_len: u32,
        mst_out_ptr: *mut u32, max_out_len: u32,
        num_nodes: u32
    ) -> u32;
}

pub fn proxy_handler(input_json: &str) -> String {
    let input: MstInput = serde_json::from_str(input_json).unwrap_or(MstInput { size: None, m: None });
    let size = input.size.unwrap_or(100_000);
    let m = input.m.unwrap_or(10);

    // Generating inputs.
    // Creating the Barabási-Albert graph.
    let mut edges = Vec::with_capacity(size * m * 2);
    let mut repeated_nodes = Vec::with_capacity(size * m * 2);

    // Initial clique of m nodes.
    for i in 0..m {
        for j in i + 1..m {
            edges.push(i as u32); edges.push(j as u32);
            repeated_nodes.push(i as u32); repeated_nodes.push(j as u32);
        }
    }

    // Preferential attachment.
    let mut rng = rand::thread_rng();
    let mut targets = Vec::with_capacity(m);

    for i in m..size {
        targets.clear();
        while targets.len() < m {
            let target = repeated_nodes[rng.gen_range(0..repeated_nodes.len())];
            if !targets.contains(&target) { targets.push(target); }
        }
        for &target in &targets {
            edges.push(i as u32); edges.push(target);
            repeated_nodes.push(i as u32); repeated_nodes.push(target);
        }
    }

    // MST.
    // A spanning tree on N nodes will have exactly N-1 edges. Each edge is 2 u32s.
    let max_mst_edges = size - 1;
    let mut mst_edges_out = vec![0u32; max_mst_edges * 2];

    let edges_in_tree = unsafe {
        host_mst(
            edges.as_ptr(), edges.len() as u32,
            mst_edges_out.as_mut_ptr(), mst_edges_out.len() as u32,
            size as u32
        )
    };

    if edges_in_tree == max_mst_edges as u32 {
        format!("Success: MST constructed with {} edges.", edges_in_tree)
    } else {
        format!("Error: MST constructed with {}/{} edges.", edges_in_tree, max_mst_edges)
    }
}

export_mosaic_function!(proxy_handler);
