use rand::Rng;
use std::collections::VecDeque;
use std::time::{Duration, Instant};


fn bfs(edges: &[u32], out_order: &mut [u32], num_nodes: u32, start_node: u32) -> u32 {
    let num_nodes_usize = num_nodes as usize;

    // 1. Build adjacency list (undirected).
    let mut adj = vec![Vec::new(); num_nodes_usize];
    for chunk in edges.chunks_exact(2) {
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
            if count < out_order.len() {
                out_order[count] = node;
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

    // Output array to store the order of visited nodes.
    let mut bfs_order = vec![0u32; size];

    // Call the native function directly using slices
    let visited_count = bfs(&edges, &mut bfs_order, size as u32, 0);

    if visited_count != size as u32 {
        eprintln!("BFS failed or incomplete!");
        return 1;
    }

    0
}

fn main() {
    let benchmark_name = "bfs";
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
