use anyhow::Result;
use wasmtime::*;
use wasmtime_wasi::preview1::{self, WasiP1Ctx};
use wasmtime_wasi::p2::WasiCtxBuilder;
use std::time::{Duration, Instant};
use std::io::Read;
use serde::Serialize;

struct ModuleState {
    wasi: WasiP1Ctx,
    trampoline_time: Duration,
    compute_time: Duration,
}

// Zero-copy writer.
struct WasmBufferWriter<'a> {
    buffer: &'a mut [u8],
    pos: usize,
}

impl<'a> std::io::Write for WasmBufferWriter<'a> {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        let len = buf.len();
        if self.pos + len > self.buffer.len() {
            return Err(std::io::Error::new(std::io::ErrorKind::WriteZero, "Wasm buffer overflow"));
        }
        self.buffer[self.pos..self.pos + len].copy_from_slice(buf);
        self.pos += len;
        Ok(len)
    }
    fn flush(&mut self) -> std::io::Result<()> { Ok(()) }
}

// Data structure to match the Python Squiggle JSON output.
#[derive(Serialize)]
struct SquiggleOutput {
    x: Vec<f64>,
    y: Vec<f64>,
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

    // --- host_download ---
    linker.func_wrap("env", "host_download",
        |mut caller: Caller<'_, ModuleState>, url_ptr: i32, url_len: i32, out_ptr: i32, max_len: i32| -> u32 {

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let (data, _) = mem.data_and_store_mut(&mut caller);

        let url_str = match std::str::from_utf8(&data[url_ptr as usize..(url_ptr + url_len) as usize]) {
            Ok(s) => s,
            Err(_) => return 0,
        };

        let mut response = match ureq::get(url_str).call() {
            Ok(r) => r,
            Err(e) => {
                eprintln!("HTTP Request Failed: {}", e);
                return 0;
            }
        };

        let out_slice = &mut data[out_ptr as usize..(out_ptr + max_len) as usize];

        let mut reader = response.body_mut().as_reader();

        // Read in a loop until EOF (0 bytes returned) to ensure we get the whole file.
        let mut total_bytes_read = 0;
        loop {
            // Guard against buffer overflow.
            if total_bytes_read >= max_len as usize {
                eprintln!("Image exceeded max buffer size!");
                return 0;
            }

            match reader.read(&mut out_slice[total_bytes_read..]) {
                Ok(0) => break, // EOF reached, download complete.
                Ok(n) => total_bytes_read += n,
                Err(e) => {
                    eprintln!("Failed reading body stream: {}", e);
                    return 0;
                }
            }
        }

        total_bytes_read as u32
    })?;

    // --- host_squiggle ---
    linker.func_wrap("env", "host_squiggle",
        |mut caller: Caller<'_, ModuleState>,
         in_ptr: i32, in_len: i32,
         out_ptr: i32, max_len: i32| -> u32 {

        let tramp_start = Instant::now();

        let mem = match caller.get_export("memory") { Some(Extern::Memory(m)) => m, _ => return 0 };
        let base_ptr = mem.data_mut(&mut caller).as_mut_ptr();
        let mem_len = mem.data(&caller).len();

        if (in_ptr as usize + in_len as usize > mem_len) ||
           (out_ptr as usize + max_len as usize > mem_len) {
            return 0;
        }

        let bytes_written = unsafe {
            let in_slice = std::slice::from_raw_parts(base_ptr.add(in_ptr as usize), in_len as usize);
            let fasta_str = std::str::from_utf8(in_slice).unwrap_or("");

            let out_slice = std::slice::from_raw_parts_mut(base_ptr.add(out_ptr as usize), max_len as usize);
            let mut writer = WasmBufferWriter { buffer: out_slice, pos: 0 };

            let tramp_duration = tramp_start.elapsed();
            let compute_start = Instant::now();

            // Pre-allocate to avoid slow vector resizing during computation.
            // 2 points per nucleotide + 1 start point.
            let estimated_capacity = fasta_str.len() * 2;
            let mut x_coords = Vec::with_capacity(estimated_capacity);
            let mut y_coords = Vec::with_capacity(estimated_capacity);

            let mut cur_x = 0.0;
            let mut cur_y = 0.0;

            x_coords.push(cur_x);
            y_coords.push(cur_y);

            // Squiggle algorithm loop.
            for line in fasta_str.lines() {
                // Ignore FASTA headers.
                if line.starts_with('>') { continue; }

                for b in line.bytes() {
                    match b {
                        b'A' | b'a' => {
                            x_coords.push(cur_x + 0.5); y_coords.push(cur_y + 0.5);
                            cur_x += 1.0;               // cur_y += 0.0;
                            x_coords.push(cur_x);       y_coords.push(cur_y);
                        }
                        b'C' | b'c' => {
                            x_coords.push(cur_x + 0.5); y_coords.push(cur_y - 0.5);
                            cur_x += 1.0;               // cur_y += 0.0;
                            x_coords.push(cur_x);       y_coords.push(cur_y);
                        }
                        b'G' | b'g' => {
                            x_coords.push(cur_x + 0.5); y_coords.push(cur_y + 0.5);
                            cur_x += 1.0;               cur_y += 1.0;
                            x_coords.push(cur_x);       y_coords.push(cur_y);
                        }
                        b'T' | b't' | b'U' | b'u' => {
                            x_coords.push(cur_x + 0.5); y_coords.push(cur_y - 0.5);
                            cur_x += 1.0;               cur_y -= 1.0;
                            x_coords.push(cur_x);       y_coords.push(cur_y);
                        }
                        _ => {} // Ignore whitespace, 'N', or unrecognized characters.
                    }
                }
            }

            let result = SquiggleOutput { x: x_coords, y: y_coords };

            // Serialize directly to the Wasm Memory for zero-copy payload generation.
            match serde_json::to_writer(&mut writer, &result) {
                Ok(_) => {
                    let compute_duration = compute_start.elapsed();
                    caller.data_mut().trampoline_time += tramp_duration;
                    caller.data_mut().compute_time += compute_duration;
                    writer.pos as u32
                },
                Err(_) => 0,
            }
        };

        bytes_written
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
