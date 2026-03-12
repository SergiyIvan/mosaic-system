use std::time::Instant;
use rand::Rng;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Runs BFS starting from node 0. Returns the total number of nodes visited.
    fn host_bfs(
        edges_ptr: *const u32, edges_len: u32,
        out_ptr: *mut u32, max_out_len: u32,
        num_nodes: u32, start_node: u32
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let size = 100_000; // "large" config from SeBS.
    let m = 10;        // Edges per node in Barabasi-Albert.

    eprintln!("=== SeBS BFS Benchmark ===");
    unsafe { host_reset_time(); }

    // Generating inputs.
    let gen_start = Instant::now();

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

    let gen_time = gen_start.elapsed().as_micros() as f64;

    // BFS.
    let process_start = Instant::now();

    // Output array to store the order of visited nodes.
    let mut bfs_order = vec![0u32; size];
    let start_node = 0;

    let visited_count = unsafe {
        host_bfs(
            edges.as_ptr(), edges.len() as u32,
            bfs_order.as_mut_ptr(), size as u32,
            size as u32, start_node
        )
    };

    let process_time = process_start.elapsed().as_micros() as f64;

    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    eprintln!("Success! BFS completed.");
    println!("{{");
    println!("  \"benchmark\": \"bfs\",");
    println!("  \"result\": \"Visited {} nodes (Starting from {})\",", visited_count, start_node);
    println!("  \"measurement\": {{");
    println!("    \"graph_generating_time_us\": {:.2},", gen_time);
    println!("    \"process_time_us\": {:.2},", process_time);
    println!("    \"breakdown\": {{");
    println!("      \"host_compute_us\": {:.2},", host_compute_us);
    println!("      \"host_trampoline_us\": {:.2},", host_trampoline_us);
    println!("      \"wasm_overhead_us\": {:.2}", wasm_overhead_us);
    println!("    }}");
    println!("  }}");
    println!("}}");

    0
}
