use rand::Rng;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Runs MST (Union-Find). Returns the number of edges added to the spanning tree.
    fn host_mst(
        edges_ptr: *const u32, edges_len: u32,
        mst_out_ptr: *mut u32, max_out_len: u32,
        num_nodes: u32
    ) -> u32;
}

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let size = 100_000; // "large" config from SeBS.
    let m = 10;        // Edges per node in Barabasi-Albert.

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
    for i in m..size {
        let mut targets = Vec::with_capacity(m);
        while targets.len() < m {
            let target = repeated_nodes[rng.gen_range(0..repeated_nodes.len())];
            if !targets.contains(&target) { targets.push(target); }
        }
        for target in targets {
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
            mst_edges_out.as_mut_ptr(), (max_mst_edges * 2) as u32,
            size as u32
        )
    };

    if edges_in_tree != max_mst_edges as u32 {
        eprintln!("MST failed or incomplete!");
        return 1;
    }

    0
}
