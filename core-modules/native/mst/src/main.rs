use rand::Rng;
use std::time::{Duration, Instant};


struct UnionFind {
    parent: Vec<u32>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size as u32).collect(),
        }
    }

    // Find with path compression (flattens the tree for O(1) lookups).
    fn find(&mut self, i: u32) -> u32 {
        if self.parent[i as usize] == i {
            i
        } else {
            let root = self.find(self.parent[i as usize]);
            self.parent[i as usize] = root;
            root
        }
    }

    // Union returns true if the components were merged (edge added to MST).
    fn union(&mut self, i: u32, j: u32) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.parent[root_i as usize] = root_j;
            true
        } else {
            false
        }
    }
}


fn mst(edges: &[u32], out_edges: &mut [u32], num_nodes: u32) -> u32 {
    let mut uf = UnionFind::new(num_nodes as usize);
    let mut mst_edge_count = 0;

    // Iterate over the edges and build the spanning tree.
    for chunk in edges.chunks_exact(2) {
        let u = chunk[0];
        let v = chunk[1];

        // If the edge connects two different components, add it to the MST.
        if uf.union(u, v) {
            out_edges[mst_edge_count * 2] = u;
            out_edges[mst_edge_count * 2 + 1] = v;
            mst_edge_count += 1;

            // A spanning tree is complete when it has exactly (N - 1) edges.
            if mst_edge_count == (num_nodes as usize - 1) {
                break;
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

    // MST output allocation.
    // A spanning tree on N nodes will have exactly N-1 edges. Each edge is 2 u32s.
    let max_mst_edges = size - 1;
    let mut mst_edges_out = vec![0u32; max_mst_edges * 2];

    let edges_in_tree = mst(&edges, &mut mst_edges_out, size as u32);

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
