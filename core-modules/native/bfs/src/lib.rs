use petgraph::graph::UnGraph;
use petgraph::visit::Bfs;
use rand::Rng;
use serde::Deserialize;
use proxy_guest::export_function;


#[derive(Deserialize)]
struct BfsInput {
    size: Option<usize>,
    m: Option<usize>,
}


fn bfs(edges: &[u32], out_order: &mut [u32], num_nodes: usize, start_node: usize) -> u32 {
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

    let mut bfs = Bfs::new(&graph, nodes[start_node]);
    let mut count = 0;

    while let Some(nx) = bfs.next(&graph) {
        if count < out_order.len() {
            out_order[count] = nx.index() as u32;
        }
        count += 1;
    }

    count as u32
}


pub fn run(size: usize, m: usize) -> u32 {
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

    // BFS traversal.
    let mut bfs_order = vec![0u32; size];
    let count = bfs(&edges, &mut bfs_order, size, 0);

    if count as u32 != size as u32 {
        eprintln!("BFS failed or incomplete!");
    }

    count
}


pub fn proxy_handler(input_json: &str) -> String {
    let input: BfsInput = serde_json::from_str(input_json).unwrap_or(BfsInput { size: None, m: None });

    let size = input.size.unwrap_or(100_000);
    let m = input.m.unwrap_or(10);

    let visited = run(size, m);

    if visited == size as u32 {
        format!("Success: visited {} nodes.", visited)
    } else {
        format!("Error: only visited {}/{} nodes.", visited, size)
    }
}


export_function!(proxy_handler);
