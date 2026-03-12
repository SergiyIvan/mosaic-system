use anyhow::Result;
use std::time::Instant;
use wasmtime::{Caller, Extern, Linker};
use runner::ModuleState;


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


fn register_host_funcs(linker: &mut Linker<ModuleState>) -> Result<()> {

    // --- host_mst ---
    linker.func_wrap("env", "host_mst",
        |mut caller: Caller<'_, ModuleState>,
         edges_ptr: i32, edges_len: i32,
         out_ptr: i32, max_out_len: i32,
         num_nodes: i32| -> u32 {

        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let bounds_ok = (edges_ptr as usize + (edges_len as usize * 4) <= mem_len) &&
                        (out_ptr as usize + (max_out_len as usize * 4) <= mem_len);

        if !bounds_ok { return 0; }

        let edges_added = unsafe {
            let edges_slice = std::slice::from_raw_parts(
                base_ptr.add(edges_ptr as usize) as *const u32,
                edges_len as usize
            );

            let out_slice = std::slice::from_raw_parts_mut(
                base_ptr.add(out_ptr as usize) as *mut u32,
                max_out_len as usize
            );

            let tramp_duration = tramp_start.elapsed();
            let compute_start = Instant::now();

            let mut uf = UnionFind::new(num_nodes as usize);
            let mut mst_edge_count = 0;

            // Iterate over the edges and build the spanning tree.
            for chunk in edges_slice.chunks_exact(2) {
                let u = chunk[0];
                let v = chunk[1];

                // If the edge connects two different components, add it to the MST.
                if uf.union(u, v) {
                    out_slice[mst_edge_count * 2] = u;
                    out_slice[mst_edge_count * 2 + 1] = v;
                    mst_edge_count += 1;

                    // A spanning tree is complete when it has exactly (N - 1) edges.
                    if mst_edge_count == (num_nodes as usize - 1) {
                        break;
                    }
                }
            }

            let compute_duration = compute_start.elapsed();

            caller.data_mut().trampoline_time += tramp_duration;
            caller.data_mut().compute_time += compute_duration;

            mst_edge_count as u32
        };

        edges_added
    })?;

    Ok(())
}

fn main() -> Result<()> {
    let wasm_path = "../guest/target/wasm32-wasip1/release/guest.wasm";
    runner::run_wasm(wasm_path, register_host_funcs)
}
