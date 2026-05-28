use petgraph::algo::min_spanning_tree;
use petgraph::data::Element;
use petgraph::graph::UnGraph;
use petgraph::visit::Bfs;


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


#[unsafe(no_mangle)]
pub unsafe extern "C" fn trampoline_dispatch(
    func_name_ptr: *const u8,
    func_name_len: usize,
    mem_base: *mut u8,
    mem_len: usize,
    args_ptr: *const u64,
    args_len: usize,
    ret_ptr: *mut u64,
) -> bool {
    unsafe {
        let func_name_slice = std::slice::from_raw_parts(func_name_ptr, func_name_len);
        let func_name = std::str::from_utf8(func_name_slice).unwrap_or("");
        let args = std::slice::from_raw_parts(args_ptr, args_len);

        match func_name {
            "host_bfs" => {
                if args.len() != 6 { return false; }

                // Unpack Wasm arguments from the generic u64 array.
                let edges_ptr = args[0] as usize;
                let edges_len = args[1] as usize;
                let out_ptr = args[2] as usize;
                let max_out_len = args[3] as usize;
                let num_nodes = args[4] as usize;
                let start_node = args[5] as usize;

                // Security bounds check.
                let bounds_ok = (edges_ptr + (edges_len * 4) <= mem_len) &&
                                (out_ptr + (max_out_len * 4) <= mem_len);
                if !bounds_ok { return false; }

                // Reconstruct slices pointing directly to Wasm memory.
                let edges_slice = std::slice::from_raw_parts(
                    mem_base.add(edges_ptr) as *const u32,
                    edges_len,
                );
                let out_slice = std::slice::from_raw_parts_mut(
                    mem_base.add(out_ptr) as *mut u32,
                    max_out_len,
                );

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                // Execute function.
                let visited_count = bfs(edges_slice, out_slice, num_nodes, start_node);

                // Write back return value.
                *ret_ptr = visited_count as u64;

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_BFS | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            "host_mst" => {
                if args.len() != 5 { return false; }

                // Unpack Wasm arguments from the generic u64 array.
                let edges_ptr = args[0] as usize;
                let edges_len = args[1] as usize;
                let out_ptr = args[2] as usize;
                let max_out_len = args[3] as usize;
                let num_nodes = args[4] as usize;

                // Security bounds check.
                let bounds_ok = (edges_ptr + (edges_len * 4) <= mem_len) &&
                                (out_ptr + (max_out_len * 4) <= mem_len);
                if !bounds_ok { return false; }

                // Reconstruct slices pointing directly to Wasm memory.
                let edges_slice = std::slice::from_raw_parts(
                    mem_base.add(edges_ptr) as *const u32,
                    edges_len,
                );
                let out_slice = std::slice::from_raw_parts_mut(
                    mem_base.add(out_ptr) as *mut u32,
                    max_out_len,
                );

                // ---> START CORE COMPUTE SPAN
                let start_compute = std::time::Instant::now();

                // Execute function.
                let edges_in_tree = mst(edges_slice, out_slice, num_nodes);

                // Write back return value.
                *ret_ptr = edges_in_tree as u64;

                // ---> END CORE COMPUTE SPAN
                println!("*** Span: TrampCompute_MST | DurationUs: {}", start_compute.elapsed().as_micros());

                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
