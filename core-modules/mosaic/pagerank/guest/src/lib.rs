use rand::Rng;
use serde::Deserialize;
use proxy_guest::export_mosaic_function;


#[derive(Deserialize)]
struct PagerankInput {
    size: Option<usize>,
    m: Option<usize>,
    iterations: Option<u32>,
}


#[link(wasm_import_module = "env")]
unsafe extern "C" {
    // Runs PageRank. edges_len is number of u32s. pr_len is number of nodes (f32s).
    fn host_pagerank(
        edges_ptr: *const u32, edges_len: u32,
        pr_ptr: *mut f32, pr_len: u32,
        iterations: u32
    ) -> u32;
}

pub fn proxy_handler(input_json: &str) -> String {
    let input: PagerankInput = serde_json::from_str(input_json).unwrap_or(PagerankInput { size: None, m: None, iterations: None });
    let size = input.size.unwrap_or(10_000);
    let m = input.m.unwrap_or(10);
    let iterations = input.iterations.unwrap_or(20);

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

    // PageRank.
    // Output array for PageRank scores.
    let mut pr_scores = vec![0.0f32; size];

    let success = unsafe {
        host_pagerank(
            edges.as_ptr(), edges.len() as u32,
            pr_scores.as_mut_ptr(), size as u32,
            iterations
        )
    };

    if success != 1 || pr_scores[0] <= 0.0 {
        "Error: PageRank failed or scores are zero/invalid!".to_string()
    } else {
        format!("Success: score of the oldest node: {}.", pr_scores[0])
    }
}

export_mosaic_function!(proxy_handler);
