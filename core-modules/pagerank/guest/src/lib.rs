use std::time::Instant;
use rand::Rng;

#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Runs PageRank. edges_len is number of u32s. pr_len is number of nodes (f32s).
    fn host_pagerank(
        edges_ptr: *const u32, edges_len: u32,
        pr_ptr: *mut f32, pr_len: u32
    ) -> u32;

    fn host_reset_time();
    fn host_get_trampoline_time_nanos() -> u64;
    fn host_get_compute_time_nanos() -> u64;
}

#[unsafe(no_mangle)]
pub extern "C" fn run() -> u32 {
    let size = 10_000; // "small" config from SeBS.
    let m = 10;        // Edges per node in Barabasi-Albert.

    eprintln!("=== SeBS PageRank Benchmark ===");
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

    // PageRank.
    let process_start = Instant::now();

    // Output array for PageRank scores.
    let mut pr_scores = vec![0.0f32; size];

    unsafe {
        host_pagerank(
            edges.as_ptr(), edges.len() as u32,
            pr_scores.as_mut_ptr(), size as u32
        );
    }

    let process_time = process_start.elapsed().as_micros() as f64;

    let host_trampoline_us = unsafe { host_get_trampoline_time_nanos() } as f64 / 1000.0;
    let host_compute_us = unsafe { host_get_compute_time_nanos() } as f64 / 1000.0;
    let wasm_overhead_us = process_time - (host_trampoline_us + host_compute_us);

    eprintln!("Success! PageRank calculated.");
    println!("{{");
    println!("  \"benchmark\": \"pagerank\",");
    println!("  \"result\": {:.6},", pr_scores[0]); // Mimic python result[0].
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
