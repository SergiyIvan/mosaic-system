use rand::Rng;
use pagerank_lib::pagerank;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct PagerankInput {
    size: Option<usize>,
    m: Option<usize>,
    iterations: Option<usize>,
}


pub fn run(size: usize, m: usize, iterations: usize) -> f32 {

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
    let success = pagerank(&edges, &mut pr_scores, iterations as u32);

    if success != 1 {
        eprintln!("PageRank failed: Function returned error!");
        return -1.0;
    }

    // Mathematical sanity check.
    // Node 0 is the oldest node and should accumulate a high PageRank score.
    // If it's <= 0.0 (or unchanged from the 1.0/N initialization base without damping), something broke.
    if pr_scores[0] <= 0.0 {
        eprintln!("PageRank failed: Scores are zero or invalid!");
    }

    pr_scores[0]
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: PagerankInput = serde_json::from_str(input_json).unwrap_or(PagerankInput { size: None, m: None, iterations: None });

    let size = input.size.unwrap_or(10_000);
    let m = input.m.unwrap_or(10);
    let iterations = input.iterations.unwrap_or(20);

    let oldest_pr_score = run(size, m, iterations);

    if oldest_pr_score <= 0.0 {
        "Error: PageRank failed: Scores are zero or invalid!".to_string()
    } else {
        format!("Success: score of the oldest node: {}.", oldest_pr_score)
    }
}


export_function!(proxy_handler);
