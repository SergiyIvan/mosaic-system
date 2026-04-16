use rand::Rng;
use std::time::{Duration, Instant};
use pagerank_lib::pagerank;


fn run() -> u32 {
    let size = 10_000; // "small" config from SeBS.
    let m = 10;        // Edges per node in Barabasi-Albert.
    let iterations = 20;

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

    // Output array for PageRank scores.
    let mut pr_scores = vec![0.0f32; size];

    // Call the native function directly
    let success = pagerank(&edges, &mut pr_scores, iterations);

    if success != 1 {
        eprintln!("PageRank failed: Function returned error!");
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

fn main() {
    let benchmark_name = "pagerank";
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
