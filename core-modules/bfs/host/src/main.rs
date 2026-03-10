use anyhow::Result;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;
use std::time::{Duration, Instant};
use std::collections::VecDeque;

struct ModuleState {
    wasi: WasiP1Ctx,
    trampoline_time: Duration,
    compute_time: Duration,
}


fn main() -> Result<()> {
    let engine = Engine::default();
    let mut linker: Linker<ModuleState> = Linker::new(&engine);
    preview1::add_to_linker_sync(&mut linker, |state| &mut state.wasi)?;

    let module = Module::from_file(&engine, "../guest/target/wasm32-wasip1/release/guest.wasm")?;

    linker.func_wrap("env", "host_reset_time", |mut caller: Caller<'_, ModuleState>| {
        caller.data_mut().trampoline_time = Duration::ZERO;
        caller.data_mut().compute_time = Duration::ZERO;
    })?;

    linker.func_wrap("env", "host_get_trampoline_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().trampoline_time.as_nanos() as u64
    })?;

    linker.func_wrap("env", "host_get_compute_time_nanos", |caller: Caller<'_, ModuleState>| -> u64 {
        caller.data().compute_time.as_nanos() as u64
    })?;

    // --- host_bfs ---
    linker.func_wrap("env", "host_bfs",
        |mut caller: Caller<'_, ModuleState>,
         edges_ptr: i32, edges_len: i32,
         out_ptr: i32, max_out_len: i32,
         num_nodes: i32, start_node: i32| -> u32 {

        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        let bounds_ok = (edges_ptr as usize + (edges_len as usize * 4) <= mem_len) &&
                        (out_ptr as usize + (max_out_len as usize * 4) <= mem_len);

        if !bounds_ok { return 0; }

        let visited_count = unsafe {
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

            let num_nodes_usize = num_nodes as usize;

            // 1. Build adjacency list (undirected).
            let mut adj = vec![Vec::new(); num_nodes_usize];
            for chunk in edges_slice.chunks_exact(2) {
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
                    // Record visitation order directly into Wasm memory.
                    if count < max_out_len as usize {
                        out_slice[count] = node;
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

            let compute_duration = compute_start.elapsed();

            caller.data_mut().trampoline_time += tramp_duration;
            caller.data_mut().compute_time += compute_duration;

            count as u32
        };

        visited_count
    })?;

    let wasi = WasiCtxBuilder::new().inherit_stdout().inherit_stderr().build_p1();
    let mut store = Store::new(&engine, ModuleState {
        wasi, trampoline_time: Duration::ZERO, compute_time: Duration::ZERO
    });

    let instance = linker.instantiate(&mut store, &module)?;
    let run = instance.get_typed_func::<(), u32>(&mut store, "run")?;
    run.call(&mut store, ())?;

    Ok(())
}
