use wasmtime::component::ResourceTable;
use wasmtime_wasi::p2::{IoView, WasiCtx, WasiCtxBuilder, WasiView};

pub struct States {
    table: ResourceTable,
    ctx: WasiCtx,
}

impl States {
    pub fn new() -> Self {
        let table = ResourceTable::new();
        let ctx = WasiCtxBuilder::new().inherit_stdio().inherit_args().build();
        Self { table, ctx }
    }
}

impl WasiView for States {
    fn ctx(&mut self) -> &mut WasiCtx {
        &mut self.ctx
    }
}

impl IoView for States {
    fn table(&mut self) -> &mut ResourceTable {
        &mut self.table
    }
}
