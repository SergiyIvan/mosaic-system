use rand::Rng;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Runs PageRank. edges_len is number of u32s. pr_len is number of nodes (f32s).
    fn host_pagerank(
        edges_ptr: *const u32, edges_len: u32,
        pr_ptr: *mut f32, pr_len: u32
    ) -> u32;
}

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let size = 10_000; // "small" config from SeBS.
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

    // PageRank.
    // Output array for PageRank scores.
    let mut pr_scores = vec![0.0f32; size];

    let success = unsafe {
        host_pagerank(
            edges.as_ptr(), edges.len() as u32,
            pr_scores.as_mut_ptr(), size as u32
        )
    };

    if success != 1 {
        eprintln!("PageRank failed: Host returned error!");
        return 1;
    }

    // Mathematical sanity check.
    // Node 0 is the oldest node and should accumulate a high PageRank score.
    // If it's <= 0.0 (or unchanged from the 1.0/N initialization base without damping), something broke.
    if pr_scores[0] <= 0.0 {
        eprintln!("PageRank failed: Scores are zero or invalid!");
        return 1;
    }

    0
}
