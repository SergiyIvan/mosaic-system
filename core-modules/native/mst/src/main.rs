use petgraph::algo::min_spanning_tree;
use petgraph::data::Element;
use petgraph::graph::UnGraph;
use rand::Rng;
use std::time::{Duration, Instant};


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

fn run() -> u32 {
    let size = 100_000; // "large" config from SeBS.
    let m = 10;         // Edges per node in Barabasi-Albert.

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

    // MST execution.
    // A spanning tree on N nodes will have exactly N-1 edges.
    let max_mst_edges = size - 1;
    let mut mst_edges_out = vec![0u32; max_mst_edges * 2];

    let edges_in_tree = mst(&edges, &mut mst_edges_out, size);

    if edges_in_tree != max_mst_edges as u32 {
        eprintln!("MST failed or incomplete! Expected {}, got {}", max_mst_edges, edges_in_tree);
        return 1;
    }

    0
}

fn main() {
    let benchmark_name = "mst";
    let args: Vec<String> = std::env::args().collect();

    // If duration and warmup are provided, run the throughput benchmark.
    if args.len() >= 3 {
        let duration_seconds: u64 = args[1].parse().unwrap_or(30);
        let warmup_iterations: u32 = args[2].parse().unwrap_or(5);

        eprintln!("==> Starting Warmup ({} iterations)...", warmup_iterations);
        for _ in 0..warmup_iterations {
            if run() != 0 {
                eprintln!("Warning: run() returned non-zero status.");
            }
        }

        eprintln!("==> Running Benchmark for {} seconds...", duration_seconds);
        let mut iterations = 0;
        let start_time = Instant::now();
        let target_duration = Duration::from_secs(duration_seconds);

        while start_time.elapsed() < target_duration {
            if run() != 0 {
                eprintln!("Warning: run() returned non-zero status.");
            }
            iterations += 1;
        }

        let elapsed = start_time.elapsed().as_secs_f64();
        let rps = iterations as f64 / elapsed;

        // Print the strictly formatted JSON to stdout
        println!("{{");
        println!("  \"benchmark\": \"{}\",", benchmark_name);
        println!("  \"duration_seconds\": {:.2},", elapsed);
        println!("  \"iterations\": {},", iterations);
        println!("  \"throughput_rps\": {:.2}", rps);
        println!("}}");

    } else {
        eprintln!("==> Running Single Native Invocation...");
        let start_time = Instant::now();
        let res = run();
        let elapsed = start_time.elapsed();

        if res == 0 {
            eprintln!("Success! Execution time: {:?}", elapsed);
        } else {
            eprintln!("Failed! Execution time: {:?}", elapsed);
        }
    }
}
