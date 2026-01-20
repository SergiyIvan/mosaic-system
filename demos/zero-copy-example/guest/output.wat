(component
  (type (;0;)
    (instance
      (type (;0;) (list u8))
      (type (;1;) (func (param "arr" 0)))
      (export (;0;) "host-function" (func (type 1)))
    )
  )
  (import "docs:guest/hosted@0.1.0" (instance (;0;) (type 0)))
  (type (;1;)
    (instance
      (export (;0;) "error" (type (sub resource)))
      (type (;1;) (borrow 0))
      (type (;2;) (func (param "self" 1) (result string)))
      (export (;0;) "[method]error.to-debug-string" (func (type 2)))
    )
  )
  (import "wasi:io/error@0.2.6" (instance (;1;) (type 1)))
  (alias export 1 "error" (type (;2;)))
  (type (;3;)
    (instance
      (export (;0;) "output-stream" (type (sub resource)))
      (alias outer 1 2 (type (;1;)))
      (export (;2;) "error" (type (eq 1)))
      (type (;3;) (own 2))
      (type (;4;) (variant (case "last-operation-failed" 3) (case "closed")))
      (export (;5;) "stream-error" (type (eq 4)))
      (type (;6;) (borrow 0))
      (type (;7;) (list u8))
      (type (;8;) (result (error 5)))
      (type (;9;) (func (param "self" 6) (param "contents" 7) (result 8)))
      (export (;0;) "[method]output-stream.blocking-write-and-flush" (func (type 9)))
    )
  )
  (import "wasi:io/streams@0.2.6" (instance (;2;) (type 3)))
  (type (;4;)
    (instance
      (type (;0;) (tuple string string))
      (type (;1;) (list 0))
      (type (;2;) (func (result 1)))
      (export (;0;) "get-environment" (func (type 2)))
    )
  )
  (import "wasi:cli/environment@0.2.6" (instance (;3;) (type 4)))
  (type (;5;)
    (instance
      (type (;0;) (result))
      (type (;1;) (func (param "status" 0)))
      (export (;0;) "exit" (func (type 1)))
    )
  )
  (import "wasi:cli/exit@0.2.6" (instance (;4;) (type 5)))
  (alias export 2 "output-stream" (type (;6;)))
  (type (;7;)
    (instance
      (alias outer 1 6 (type (;0;)))
      (export (;1;) "output-stream" (type (eq 0)))
      (type (;2;) (own 1))
      (type (;3;) (func (result 2)))
      (export (;0;) "get-stdout" (func (type 3)))
    )
  )
  (import "wasi:cli/stdout@0.2.6" (instance (;5;) (type 7)))
  (alias export 2 "output-stream" (type (;8;)))
  (type (;9;)
    (instance
      (alias outer 1 8 (type (;0;)))
      (export (;1;) "output-stream" (type (eq 0)))
      (type (;2;) (own 1))
      (type (;3;) (func (result 2)))
      (export (;0;) "get-stderr" (func (type 3)))
    )
  )
  (import "wasi:cli/stderr@0.2.6" (instance (;6;) (type 9)))
  (core module (;0;)
    (type (;0;) (func (param i32)))
    (type (;1;) (func (param i32 i32)))
    (type (;2;) (func (param i32 i32) (result i32)))
    (type (;3;) (func (param i32 i32 i32)))
    (type (;4;) (func (param i32 i32 i32) (result i32)))
    (type (;5;) (func (param i32 i32 i32 i32)))
    (type (;6;) (func (result i32)))
    (type (;7;) (func))
    (type (;8;) (func (param i32 i32 i32 i32) (result i32)))
    (type (;9;) (func (param i32) (result i32)))
    (type (;10;) (func (param i32 i32 i32 i32 i32)))
    (type (;11;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
    (type (;12;) (func (param i32 i32 i32 i32 i32) (result i32)))
    (type (;13;) (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))
    (type (;14;) (func (param i32 i32 i32 i32 i32 i32 i32)))
    (import "docs:guest/hosted@0.1.0" "host-function" (func $_ZN5guest8bindings4docs5guest6hosted13host_function11wit_import117h03a6fa1e4c00efa1E (;0;) (type 1)))
    (import "wasi:io/error@0.2.4" "[resource-drop]error" (func $_ZN90_$LT$wasi..imports..wasi..io..error..Error$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17hc8137117dbb2cdf8E (;1;) (type 0)))
    (import "wasi:io/streams@0.2.4" "[resource-drop]output-stream" (func $_ZN99_$LT$wasi..imports..wasi..io..streams..OutputStream$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17h7934a0c99c3ab69aE (;2;) (type 0)))
    (import "wasi:io/error@0.2.4" "[method]error.to-debug-string" (func $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string11wit_import117h9fe3cd77bbe1ce6bE (;3;) (type 1)))
    (import "wasi:io/streams@0.2.4" "[method]output-stream.blocking-write-and-flush" (func $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush11wit_import217h3a0283ab92a3f070E (;4;) (type 5)))
    (import "wasi:cli/stderr@0.2.4" "get-stderr" (func $_ZN4wasi7imports4wasi3cli6stderr10get_stderr11wit_import017h85391993be43e9ecE (;5;) (type 6)))
    (import "wasi:cli/stdout@0.2.4" "get-stdout" (func $_ZN4wasi7imports4wasi3cli6stdout10get_stdout11wit_import017h6cdcabf9277da265E (;6;) (type 6)))
    (import "wasi_snapshot_preview1" "environ_get" (func $__imported_wasi_snapshot_preview1_environ_get (;7;) (type 2)))
    (import "wasi_snapshot_preview1" "environ_sizes_get" (func $__imported_wasi_snapshot_preview1_environ_sizes_get (;8;) (type 2)))
    (import "wasi_snapshot_preview1" "proc_exit" (func $__imported_wasi_snapshot_preview1_proc_exit (;9;) (type 0)))
    (table (;0;) 80 80 funcref)
    (memory (;0;) 17)
    (global $__stack_pointer (;0;) (mut i32) i32.const 1048576)
    (global $GOT.data.internal.__memory_base (;1;) i32 i32.const 0)
    (global $GOT.data.internal.__table_base (;2;) i32 i32.const 1)
    (global $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE (;3;) i32 i32.const 3)
    (global $GOT.data.internal._ZN3std5alloc4HOOK17he5d603f2dec7f193E (;4;) i32 i32.const 1058700)
    (global $GOT.func.internal._ZN3std5alloc24default_alloc_error_hook17h0bfe682eedaf7f14E (;5;) i32 i32.const 4)
    (global $GOT.data.internal._ZN3std4sync4mpmc5waker17current_thread_id5DUMMY28_$u7b$$u7b$closure$u7d$$u7d$3VAL17ha7daa1f1ce7c8643E (;6;) i32 i32.const 1051059)
    (global $GOT.data.internal._ZN3std6thread7current2id2ID17hf355b94f07b7e26bE (;7;) i32 i32.const 1058720)
    (global $GOT.func.internal._ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h254e3ec8c3e51a1fE (;8;) i32 i32.const 5)
    (global $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17hc286a2587fb896f9E (;9;) i32 i32.const 7)
    (global $GOT.data.internal.errno (;10;) i32 i32.const 1059264)
    (global $GOT.func.internal._ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h165a494cd0246603E (;11;) i32 i32.const 9)
    (global $GOT.func.internal._ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hb45d88c0adbb2ec4E (;12;) i32 i32.const 3)
    (global $GOT.data.internal._ZN3std9panicking4HOOK17h77b165253788937cE (;13;) i32 i32.const 1058756)
    (global $GOT.data.internal._ZN3std9panicking11panic_count18GLOBAL_PANIC_COUNT17h6e1fdb7f2bdc90f2E (;14;) i32 i32.const 1058752)
    (global $GOT.data.internal._ZN3std6thread7current7CURRENT17hbfa7d7ebebd0919dE (;15;) i32 i32.const 1058728)
    (global $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h075952d02013a81eE (;16;) i32 i32.const 12)
    (global $GOT.func.internal._ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17had6411be8545c4e2E (;17;) i32 i32.const 73)
    (global $GOT.func.internal._ZN65_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Display$GT$3fmt17h8e75564e2bf34426E (;18;) i32 i32.const 74)
    (global $GOT.func.internal._ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h41e4e0481f0d43d7E (;19;) i32 i32.const 76)
    (export "memory" (memory 0))
    (export "docs:guest/runner@0.1.0#run" (func $docs:guest/runner@0.1.0#run))
    (export "cabi_realloc" (func $cabi_realloc))
    (elem (;0;) (i32.const 1) func $_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h8b8f055207f6ea3eE $_ZN5guest8bindings40__link_custom_section_describing_imports17h1c7bf3d07c76186dE $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE $_ZN3std5alloc24default_alloc_error_hook17h0bfe682eedaf7f14E $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h254e3ec8c3e51a1fE $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf8fdca988682a902E $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17hc286a2587fb896f9E $"#func41 _ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h8b8f055207f6ea3eE" $_ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h165a494cd0246603E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h785dd27ec708a479E $_ZN52_$LT$$RF$mut$u20$T$u20$as$u20$core..fmt..Display$GT$3fmt17h7da13e6d971e0f2cE $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h075952d02013a81eE $cabi_realloc $_ZN4core3ptr119drop_in_place$LT$std..io..default_write_fmt..Adapter$LT$std..io..cursor..Cursor$LT$$RF$mut$u20$$u5b$u8$u5d$$GT$$GT$$GT$17hd074874d6972ccb4E $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h6cb8e96e4ec727ecE $_ZN4core3fmt5Write10write_char17h1d334f24580e619eE $_ZN4core3fmt5Write9write_fmt17h0ea7a0e97e97c86dE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hbb04cb6b362374dbE $_ZN4core3fmt5Write10write_char17he0a925f15d03e732E $_ZN4core3fmt5Write9write_fmt17h4b44b2f1f6740e2cE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17ha388109139f2a9c5E $_ZN4core3fmt5Write10write_char17h797290c63af11536E $_ZN4core3fmt5Write9write_fmt17hf77d4e0ae6399248E $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hc3537371107a7c50E $_ZN4core3fmt5Write10write_char17h803f709043db8c93E $_ZN4core3fmt5Write9write_fmt17hdb5aea470d4ca65aE $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17hdf8e65e67aa48b04E $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17he97abafe01721ee9E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5write17h6db40419abd2303bE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$14write_vectored17h710fcb13e5f21c1eE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$17is_write_vectored17had9d3e2305c5930bE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5flush17h7cef622e8da8605cE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$9write_all17he77f898d39ebae62E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$18write_all_vectored17hb9cf078a3786329fE $_ZN3std2io5Write9write_fmt17hab634e1b5ef51410E $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E $_ZN66_$LT$std..sys..stdio..wasip2..Stderr$u20$as$u20$std..io..Write$GT$5write17h9a91659d675ae5aaE $_ZN3std2io5Write14write_vectored17hd9f7e319fdaf1decE $_ZN3std2io5Write17is_write_vectored17h8933f3dea39b82baE $_ZN66_$LT$std..sys..stdio..wasip2..Stderr$u20$as$u20$std..io..Write$GT$5flush17hc3bbe25176b00fb5E $_ZN3std2io5Write9write_all17h6cce4afb022c1e6bE $_ZN3std2io5Write18write_all_vectored17h2fa6eb0ca671d7d9E $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17haf7718004385d68dE $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h37bc7f65accfd1cfE $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h6821774e0abcbbf0E $_ZN4core3fmt5Write9write_fmt17hbb042da8f8664a0dE $_ZN86_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17hfaf43aa2b55c6473E $_ZN93_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h32bf4f2a94ae4e2fE $_ZN93_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h39b4b5b7682ddc91E $_ZN93_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17h013e14653dda53dbE $_ZN4core3ptr71drop_in_place$LT$std..panicking..panic_handler..FormatStringPayload$GT$17hadf49e1afc862199E $_ZN89_$LT$std..panicking..panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h122740778386db5bE $_ZN96_$LT$std..panicking..panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17hd7e2201362e07481E $_ZN96_$LT$std..panicking..panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h9955d5602166b291E $_ZN4core5panic12PanicPayload6as_str17h5c36130b677cff8bE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb0fe84bda0291ac1E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hc9b8f81248cf3579E $_ZN4core3ptr238drop_in_place$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$GT$17h131a71a08b780a40E $_ZN256_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Display$GT$3fmt17h16c225a516a71df2E $_ZN254_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Debug$GT$3fmt17hb289d71b75f755f0E $_ZN4core5error5Error5cause17hb8017ed64a669664E $_ZN4core5error5Error7type_id17hcfdc7eff7fa59173E $_ZN4core5error5Error11description17h22e11b214aeeeb04E $_ZN4core5error5Error7provide17hbec58b8c086da44eE $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h4bff67059979ac39E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h1c40dc1697f02d7fE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h79d0a380526b2d0fE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h3d7bab46fcd346b6E $_ZN4wasi5proxy40__link_custom_section_describing_imports17hde78c366373157cdE $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h60b46cfc83e304a4E $_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5c7189ec8b57c2a3E $_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17had6411be8545c4e2E $_ZN65_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Display$GT$3fmt17h8e75564e2bf34426E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h51f88e25e6e3e172E $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h41e4e0481f0d43d7E $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hb62a926b209c9a39E $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17hf383df329ca2be04E $_ZN4core3fmt5Write9write_fmt17h6707361cac7c8b2eE)
    (func $__wasm_call_ctors (;10;) (type 7))
    (func $_ZN32_$LT$T$u20$as$u20$hex..ToHex$GT$10encode_hex17hba05b495a3676ef6E (;11;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      i32.const 0
      i32.store offset=12
      local.get 3
      i64.const 4294967296
      i64.store offset=4 align=4
      local.get 1
      local.get 2
      i32.add
      local.set 4
      block ;; label = @1
        local.get 2
        i32.const 1
        i32.shl
        local.tee 2
        i32.eqz
        br_if 0 (;@1;)
        local.get 3
        i32.const 4
        i32.add
        i32.const 0
        local.get 2
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17h3513a5628fd4c7a8E
      end
      local.get 3
      local.get 4
      i32.store offset=24
      local.get 3
      local.get 1
      i32.store offset=20
      local.get 3
      global.get $GOT.data.internal.__memory_base
      i32.const 1048576
      i32.add
      i32.store offset=28
      local.get 3
      i32.const 1114112
      i32.store offset=16
      block ;; label = @1
        local.get 3
        i32.const 16
        i32.add
        call $_ZN79_$LT$hex..BytesToHexChars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17ha40dd11ec0ec33beE
        local.tee 2
        i32.const 1114112
        i32.eq
        br_if 0 (;@1;)
        local.get 3
        i32.load offset=12
        local.set 1
        loop ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 2
              i32.const 128
              i32.lt_u
              local.tee 5
              i32.eqz
              br_if 0 (;@4;)
              i32.const 1
              local.set 4
              br 1 (;@3;)
            end
            block ;; label = @4
              local.get 2
              i32.const 2048
              i32.ge_u
              br_if 0 (;@4;)
              i32.const 2
              local.set 4
              br 1 (;@3;)
            end
            i32.const 3
            i32.const 4
            local.get 2
            i32.const 65536
            i32.lt_u
            select
            local.set 4
          end
          local.get 1
          local.set 6
          block ;; label = @3
            local.get 4
            local.get 3
            i32.load offset=4
            local.get 1
            i32.sub
            i32.le_u
            br_if 0 (;@3;)
            local.get 3
            i32.const 4
            i32.add
            local.get 1
            local.get 4
            call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17h3513a5628fd4c7a8E
            local.get 3
            i32.load offset=12
            local.set 6
          end
          local.get 3
          i32.load offset=8
          local.get 6
          i32.add
          local.set 6
          block ;; label = @3
            block ;; label = @4
              local.get 5
              br_if 0 (;@4;)
              local.get 2
              i32.const 63
              i32.and
              i32.const -128
              i32.or
              local.set 5
              local.get 2
              i32.const 6
              i32.shr_u
              local.set 7
              block ;; label = @5
                local.get 2
                i32.const 2048
                i32.ge_u
                br_if 0 (;@5;)
                local.get 6
                local.get 5
                i32.store8 offset=1
                local.get 6
                local.get 7
                i32.const 192
                i32.or
                i32.store8
                br 2 (;@3;)
              end
              local.get 2
              i32.const 12
              i32.shr_u
              local.set 8
              local.get 7
              i32.const 63
              i32.and
              i32.const -128
              i32.or
              local.set 7
              block ;; label = @5
                local.get 2
                i32.const 65535
                i32.gt_u
                br_if 0 (;@5;)
                local.get 6
                local.get 5
                i32.store8 offset=2
                local.get 6
                local.get 7
                i32.store8 offset=1
                local.get 6
                local.get 8
                i32.const 224
                i32.or
                i32.store8
                br 2 (;@3;)
              end
              local.get 6
              local.get 5
              i32.store8 offset=3
              local.get 6
              local.get 7
              i32.store8 offset=2
              local.get 6
              local.get 8
              i32.const 63
              i32.and
              i32.const -128
              i32.or
              i32.store8 offset=1
              local.get 6
              local.get 2
              i32.const 18
              i32.shr_u
              i32.const -16
              i32.or
              i32.store8
              br 1 (;@3;)
            end
            local.get 6
            local.get 2
            i32.store8
          end
          local.get 3
          local.get 4
          local.get 1
          i32.add
          local.tee 1
          i32.store offset=12
          local.get 3
          i32.const 16
          i32.add
          call $_ZN79_$LT$hex..BytesToHexChars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17ha40dd11ec0ec33beE
          local.tee 2
          i32.const 1114112
          i32.ne
          br_if 0 (;@2;)
        end
      end
      local.get 0
      local.get 3
      i64.load offset=4 align=4
      i64.store align=4
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.add
      i32.const 8
      i32.add
      i32.load
      i32.store
      local.get 3
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17h3513a5628fd4c7a8E (;12;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 2
            local.get 1
            i32.add
            local.tee 1
            local.get 2
            i32.ge_u
            br_if 0 (;@3;)
            i32.const 0
            local.set 4
            br 1 (;@2;)
          end
          i32.const 0
          local.set 4
          local.get 1
          local.get 0
          i32.load
          local.tee 5
          i32.const 1
          i32.shl
          local.tee 2
          local.get 1
          local.get 2
          i32.gt_u
          select
          local.tee 2
          i32.const 8
          local.get 2
          i32.const 8
          i32.gt_u
          select
          local.tee 2
          i32.const 0
          i32.lt_s
          br_if 0 (;@2;)
          i32.const 0
          local.set 1
          block ;; label = @3
            local.get 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 3
            local.get 5
            i32.store offset=28
            local.get 3
            local.get 0
            i32.load offset=4
            i32.store offset=20
            i32.const 1
            local.set 1
          end
          local.get 3
          local.get 1
          i32.store offset=24
          local.get 3
          i32.const 8
          i32.add
          local.get 2
          local.get 3
          i32.const 20
          i32.add
          call $_ZN5alloc7raw_vec11finish_grow17h55444e06e5faa474E
          local.get 3
          i32.load offset=8
          i32.const 1
          i32.ne
          br_if 1 (;@1;)
          local.get 3
          i32.load offset=16
          local.set 6
          local.get 3
          i32.load offset=12
          local.set 4
        end
        local.get 4
        local.get 6
        global.get $GOT.data.internal.__memory_base
        i32.const 1056728
        i32.add
        call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
        unreachable
      end
      local.get 3
      i32.load offset=12
      local.set 1
      local.get 0
      local.get 2
      i32.store
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 3
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN5alloc7raw_vec11finish_grow17h55444e06e5faa474E (;13;) (type 3) (param i32 i32 i32)
      (local i32)
      block ;; label = @1
        block ;; label = @2
          local.get 2
          i32.load offset=4
          i32.eqz
          br_if 0 (;@2;)
          block ;; label = @3
            local.get 2
            i32.load offset=8
            local.tee 3
            br_if 0 (;@3;)
            call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
            local.get 1
            i32.const 1
            call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
            local.set 2
            br 2 (;@1;)
          end
          local.get 2
          i32.load
          local.get 3
          i32.const 1
          local.get 1
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_realloc
          local.set 2
          br 1 (;@1;)
        end
        call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
        local.get 1
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
        local.set 2
      end
      local.get 0
      local.get 1
      i32.store offset=8
      local.get 0
      local.get 2
      i32.const 1
      local.get 2
      select
      i32.store offset=4
      local.get 0
      local.get 2
      i32.eqz
      i32.store
    )
    (func $_ZN5guest8bindings40__link_custom_section_describing_imports17h1c7bf3d07c76186dE (;14;) (type 7))
    (func $_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h8b8f055207f6ea3eE (;15;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.get 1
      call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h3b63b9c35892d81bE
    )
    (func $docs:guest/runner@0.1.0#run (;16;) (type 6) (result i32)
      (local i32 i32 i64 i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 0
      global.set $__stack_pointer
      call $_ZN11wit_bindgen2rt14run_ctors_once17h775ed74e62fad3b5E
      call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
      block ;; label = @1
        i32.const 16
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc19___rust_alloc_zeroed
        local.tee 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.const 36
        i32.add
        local.get 1
        i32.const 16
        call $_ZN32_$LT$T$u20$as$u20$hex..ToHex$GT$10encode_hex17hba05b495a3676ef6E
        local.get 0
        i32.const 2
        i32.store offset=4
        local.get 0
        global.get $GOT.data.internal.__memory_base
        i32.const 1056760
        i32.add
        i32.store
        local.get 0
        i64.const 1
        i64.store offset=12 align=4
        local.get 0
        global.get $GOT.data.internal.__table_base
        i32.const 0
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 0
        i32.const 36
        i32.add
        i64.extend_i32_u
        i64.or
        local.tee 2
        i64.store offset=24
        local.get 0
        local.get 0
        i32.const 24
        i32.add
        i32.store offset=8
        local.get 0
        call $_ZN3std2io5stdio6_print17h78a8afca499f2881E
        block ;; label = @2
          local.get 0
          i32.load offset=36
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 0
          i32.load offset=40
          local.get 3
          i32.const 1
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 1
        i32.const 16
        call $_ZN5guest8bindings4docs5guest6hosted13host_function11wit_import117h03a6fa1e4c00efa1E
        local.get 0
        i32.const 36
        i32.add
        local.get 1
        i32.const 16
        call $_ZN32_$LT$T$u20$as$u20$hex..ToHex$GT$10encode_hex17hba05b495a3676ef6E
        local.get 0
        i32.const 2
        i32.store offset=4
        local.get 0
        global.get $GOT.data.internal.__memory_base
        i32.const 1056776
        i32.add
        i32.store
        local.get 0
        local.get 2
        i64.store offset=24
        local.get 0
        i64.const 1
        i64.store offset=12 align=4
        local.get 0
        local.get 0
        i32.const 24
        i32.add
        i32.store offset=8
        local.get 0
        call $_ZN3std2io5stdio6_print17h78a8afca499f2881E
        block ;; label = @2
          local.get 0
          i32.load offset=36
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 0
          i32.load offset=40
          local.get 3
          i32.const 1
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 1
        i32.const 16
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        local.get 0
        i32.const 48
        i32.add
        global.set $__stack_pointer
        i32.const 0
        return
      end
      i32.const 1
      i32.const 16
      global.get $GOT.data.internal.__memory_base
      i32.const 1056744
      i32.add
      call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
      unreachable
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc (;17;) (type 2) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      call $_RNvCskdKJRKLKjqM_7___rustc11___rdl_alloc
      return
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc (;18;) (type 3) (param i32 i32 i32)
      local.get 0
      local.get 1
      local.get 2
      call $_RNvCskdKJRKLKjqM_7___rustc13___rdl_dealloc
      return
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc14___rust_realloc (;19;) (type 8) (param i32 i32 i32 i32) (result i32)
      local.get 0
      local.get 1
      local.get 2
      local.get 3
      call $_RNvCskdKJRKLKjqM_7___rustc13___rdl_realloc
      return
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc19___rust_alloc_zeroed (;20;) (type 2) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      call $_RNvCskdKJRKLKjqM_7___rustc18___rdl_alloc_zeroed
      return
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc26___rust_alloc_error_handler (;21;) (type 1) (param i32 i32)
      local.get 0
      local.get 1
      call $_RNvCskdKJRKLKjqM_7___rustc8___rg_oom
      return
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc42___rust_alloc_error_handler_should_panic_v2 (;22;) (type 6) (result i32)
      i32.const 0
      return
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2 (;23;) (type 7)
      return
    )
    (func $_ZN79_$LT$hex..BytesToHexChars$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17ha40dd11ec0ec33beE (;24;) (type 9) (param i32) (result i32)
      (local i32 i32)
      local.get 0
      i32.load
      local.set 1
      local.get 0
      i32.const 1114112
      i32.store
      block ;; label = @1
        local.get 1
        i32.const 1114112
        i32.ne
        br_if 0 (;@1;)
        i32.const 1114112
        local.set 1
        local.get 0
        i32.load offset=4
        local.tee 2
        local.get 0
        i32.load offset=8
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        local.get 2
        i32.const 1
        i32.add
        i32.store offset=4
        local.get 0
        local.get 0
        i32.load offset=12
        local.tee 1
        local.get 2
        i32.load8_u
        local.tee 2
        i32.const 15
        i32.and
        i32.add
        i32.load8_u
        i32.store
        local.get 1
        local.get 2
        i32.const 4
        i32.shr_u
        i32.add
        i32.load8_u
        local.set 1
      end
      local.get 1
    )
    (func $_ZN11wit_bindgen2rt14run_ctors_once17h775ed74e62fad3b5E (;25;) (type 7)
      (local i32)
      block ;; label = @1
        global.get $GOT.data.internal.__memory_base
        i32.const 1058624
        i32.add
        i32.load8_u
        br_if 0 (;@1;)
        global.get $GOT.data.internal.__memory_base
        local.set 0
        call $__wasm_call_ctors
        local.get 0
        i32.const 1058624
        i32.add
        i32.const 1
        i32.store8
      end
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc18___rust_start_panic (;26;) (type 2) (param i32 i32) (result i32)
      call $_RNvCskdKJRKLKjqM_7___rustc12___rust_abort
      unreachable
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc10rust_panic (;27;) (type 1) (param i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      local.get 0
      local.get 1
      call $_RNvCskdKJRKLKjqM_7___rustc18___rust_start_panic
      i32.store offset=12
      local.get 2
      i64.const 0
      i64.store offset=16
      local.get 2
      i32.const 2
      i32.store offset=36
      local.get 2
      global.get $GOT.data.internal.__memory_base
      i32.const 1056796
      i32.add
      i32.store offset=32
      local.get 2
      i64.const 1
      i64.store offset=44 align=4
      local.get 2
      global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 2
      i32.const 12
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=56
      local.get 2
      local.get 2
      i32.const 56
      i32.add
      i32.store offset=40
      local.get 2
      i32.const 24
      i32.add
      local.get 2
      i32.const 16
      i32.add
      local.get 2
      i32.const 32
      i32.add
      call $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E
      local.get 2
      i32.load8_u offset=24
      local.get 2
      i32.load offset=28
      call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
      local.get 2
      i32.const 16
      i32.add
      call $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E
      call $_ZN3std7process5abort17h0feca9790f118023E
      unreachable
    )
    (func $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E (;28;) (type 3) (param i32 i32 i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      i32.const 16
      i32.add
      local.get 2
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      local.get 2
      i64.load align=4
      i64.store
      local.get 3
      i32.const 4
      i32.store8 offset=24
      local.get 3
      local.get 1
      i32.store offset=32
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 24
            i32.add
            global.get $GOT.data.internal.__memory_base
            i32.const 1056884
            i32.add
            local.get 3
            call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
            i32.eqz
            br_if 0 (;@3;)
            local.get 3
            i32.load8_u offset=24
            i32.const 4
            i32.ne
            br_if 1 (;@2;)
            local.get 3
            i32.const 0
            i32.store offset=56
            local.get 3
            i32.const 1
            i32.store offset=44
            local.get 3
            i64.const 4
            i64.store offset=48 align=4
            local.get 3
            global.get $GOT.data.internal.__memory_base
            local.tee 2
            i32.const 1056836
            i32.add
            i32.store offset=40
            local.get 3
            i32.const 40
            i32.add
            local.get 2
            i32.const 1056844
            i32.add
            call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
            unreachable
          end
          local.get 0
          i32.const 4
          i32.store8
          local.get 3
          i32.load offset=28
          local.set 1
          block ;; label = @3
            local.get 3
            i32.load8_u offset=24
            local.tee 2
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            i32.const 3
            i32.ne
            br_if 2 (;@1;)
          end
          local.get 1
          i32.load
          local.set 0
          block ;; label = @3
            local.get 1
            i32.const 4
            i32.add
            i32.load
            local.tee 2
            i32.load
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 2
            i32.load offset=4
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            local.get 2
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 1
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          br 1 (;@1;)
        end
        local.get 0
        local.get 3
        i64.load offset=24
        i64.store align=4
      end
      local.get 3
      i32.const 64
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE (;29;) (type 1) (param i32 i32)
      (local i32 i32)
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.const 255
          i32.and
          local.tee 0
          i32.const 4
          i32.gt_u
          br_if 0 (;@2;)
          local.get 0
          i32.const 3
          i32.ne
          br_if 1 (;@1;)
        end
        local.get 1
        i32.load
        local.set 2
        block ;; label = @2
          local.get 1
          i32.const 4
          i32.add
          i32.load
          local.tee 0
          i32.load
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 3
          call_indirect (type 0)
        end
        block ;; label = @2
          local.get 0
          i32.load offset=4
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 3
          local.get 0
          i32.load offset=8
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 1
        i32.const 12
        i32.const 4
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
    )
    (func $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E (;30;) (type 0) (param i32)
      block ;; label = @1
        local.get 0
        i32.load
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.tee 0
        i32.const -1
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        call $_ZN99_$LT$wasi..imports..wasi..io..streams..OutputStream$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17h7934a0c99c3ab69aE
      end
    )
    (func $_ZN3std7process5abort17h0feca9790f118023E (;31;) (type 7)
      call $_ZN3std3sys3pal6wasip27helpers14abort_internal17h0f2c0424e81d1365E
      unreachable
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc11___rdl_alloc (;32;) (type 2) (param i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.const 8
            i32.gt_u
            br_if 0 (;@3;)
            local.get 1
            local.get 0
            i32.le_u
            br_if 1 (;@2;)
          end
          local.get 2
          i32.const 0
          i32.store offset=12
          local.get 2
          i32.const 12
          i32.add
          local.get 1
          i32.const 4
          local.get 1
          i32.const 4
          i32.gt_u
          select
          local.get 0
          call $posix_memalign
          local.set 1
          i32.const 0
          local.get 2
          i32.load offset=12
          local.get 1
          select
          local.set 1
          br 1 (;@1;)
        end
        local.get 0
        call $malloc
        local.set 1
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc12___rust_abort (;33;) (type 7)
      call $_ZN3std7process5abort17h0feca9790f118023E
      unreachable
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc13___rdl_dealloc (;34;) (type 3) (param i32 i32 i32)
      local.get 0
      call $free
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc13___rdl_realloc (;35;) (type 8) (param i32 i32 i32 i32) (result i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 2
            i32.const 8
            i32.gt_u
            local.tee 5
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.le_u
            br_if 1 (;@2;)
          end
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                local.get 5
                br_if 0 (;@5;)
                local.get 2
                local.get 3
                i32.le_u
                br_if 1 (;@4;)
              end
              i32.const 0
              local.set 5
              local.get 4
              i32.const 0
              i32.store offset=12
              local.get 4
              i32.const 12
              i32.add
              local.get 2
              i32.const 4
              local.get 2
              i32.const 4
              i32.gt_u
              select
              local.get 3
              call $posix_memalign
              br_if 3 (;@1;)
              local.get 4
              i32.load offset=12
              local.set 5
              br 1 (;@3;)
            end
            local.get 3
            call $malloc
            local.set 5
          end
          block ;; label = @3
            local.get 5
            br_if 0 (;@3;)
            i32.const 0
            local.set 5
            br 2 (;@1;)
          end
          block ;; label = @3
            local.get 3
            local.get 1
            local.get 3
            local.get 1
            i32.lt_u
            select
            local.tee 2
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 0
            local.get 2
            memory.copy
          end
          local.get 0
          call $free
          br 1 (;@1;)
        end
        local.get 0
        local.get 3
        call $realloc
        local.set 5
      end
      local.get 4
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 5
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc17rust_begin_unwind (;36;) (type 0) (param i32)
      (local i32 i64)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 0
      i64.load align=4
      local.set 2
      local.get 1
      local.get 0
      i32.store offset=12
      local.get 1
      local.get 2
      i64.store offset=4 align=4
      local.get 1
      i32.const 4
      i32.add
      call $_ZN3std3sys9backtrace26__rust_end_short_backtrace17hcf057782ca878a29E
      unreachable
    )
    (func $_ZN3std3sys9backtrace26__rust_end_short_backtrace17hcf057782ca878a29E (;37;) (type 0) (param i32)
      local.get 0
      call $_ZN3std9panicking13panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h3336da97c87e6cc5E
      unreachable
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc18___rdl_alloc_zeroed (;38;) (type 2) (param i32 i32) (result i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.const 8
            i32.gt_u
            br_if 0 (;@3;)
            local.get 1
            local.get 0
            i32.le_u
            br_if 1 (;@2;)
          end
          i32.const 0
          local.set 3
          local.get 2
          i32.const 0
          i32.store offset=12
          local.get 2
          i32.const 12
          i32.add
          local.get 1
          i32.const 4
          local.get 1
          i32.const 4
          i32.gt_u
          select
          local.get 0
          call $posix_memalign
          br_if 1 (;@1;)
          local.get 2
          i32.load offset=12
          local.tee 1
          i32.eqz
          br_if 1 (;@1;)
          block ;; label = @3
            local.get 0
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            i32.const 0
            local.get 0
            memory.fill
          end
          local.get 1
          local.set 3
          br 1 (;@1;)
        end
        local.get 0
        i32.const 1
        call $calloc
        local.set 3
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 3
    )
    (func $_RNvCskdKJRKLKjqM_7___rustc8___rg_oom (;39;) (type 1) (param i32 i32)
      local.get 1
      local.get 0
      call $_ZN3std5alloc8rust_oom17hf900d1ba50462312E
      unreachable
    )
    (func $_ZN3std5alloc8rust_oom17hf900d1ba50462312E (;40;) (type 1) (param i32 i32)
      (local i32)
      local.get 0
      local.get 1
      global.get $GOT.data.internal._ZN3std5alloc4HOOK17he5d603f2dec7f193E
      i32.load
      local.tee 2
      global.get $GOT.func.internal._ZN3std5alloc24default_alloc_error_hook17h0bfe682eedaf7f14E
      local.get 2
      select
      call_indirect (type 1)
      call $_ZN3std7process5abort17h0feca9790f118023E
      unreachable
    )
    (func $"#func41 _ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h8b8f055207f6ea3eE" (@name "_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h8b8f055207f6ea3eE") (;41;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.get 1
      call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h3b63b9c35892d81bE
    )
    (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h3d7bab46fcd346b6E (;42;) (type 1) (param i32 i32)
      (local i32)
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1049620
      i32.add
      local.tee 2
      i64.load align=4
      i64.store align=4
      local.get 0
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i64.load align=4
      i64.store align=4
    )
    (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h79d0a380526b2d0fE (;43;) (type 1) (param i32 i32)
      (local i32)
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1049636
      i32.add
      local.tee 2
      i64.load align=4
      i64.store align=4
      local.get 0
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i64.load align=4
      i64.store align=4
    )
    (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf8fdca988682a902E (;44;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load
      local.get 0
      i32.load offset=4
      local.get 1
      call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h3b63b9c35892d81bE
    )
    (func $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E (;45;) (type 10) (param i32 i32 i32 i32 i32)
      (local i32 i32 i32 i64 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 5
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 2
            local.get 1
            i32.add
            local.tee 1
            local.get 2
            i32.ge_u
            br_if 0 (;@3;)
            i32.const 0
            local.set 6
            br 1 (;@2;)
          end
          i32.const 0
          local.set 6
          block ;; label = @3
            local.get 3
            local.get 4
            i32.add
            i32.const -1
            i32.add
            i32.const 0
            local.get 3
            i32.sub
            i32.and
            i64.extend_i32_u
            local.get 1
            local.get 0
            i32.load
            local.tee 7
            i32.const 1
            i32.shl
            local.tee 2
            local.get 1
            local.get 2
            i32.gt_u
            select
            local.tee 2
            i32.const 8
            i32.const 4
            local.get 4
            i32.const 1
            i32.eq
            select
            local.tee 1
            local.get 2
            local.get 1
            i32.gt_u
            select
            local.tee 1
            i64.extend_i32_u
            i64.mul
            local.tee 8
            i64.const 32
            i64.shr_u
            i32.wrap_i64
            i32.eqz
            br_if 0 (;@3;)
            br 1 (;@2;)
          end
          local.get 8
          i32.wrap_i64
          local.tee 9
          i32.const -2147483648
          local.get 3
          i32.sub
          i32.gt_u
          br_if 0 (;@2;)
          i32.const 0
          local.set 2
          block ;; label = @3
            local.get 7
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 7
            local.get 4
            i32.mul
            i32.store offset=28
            local.get 5
            local.get 0
            i32.load offset=4
            i32.store offset=20
            local.get 3
            local.set 2
          end
          local.get 5
          local.get 2
          i32.store offset=24
          local.get 5
          i32.const 8
          i32.add
          local.get 3
          local.get 9
          local.get 5
          i32.const 20
          i32.add
          call $_ZN5alloc7raw_vec11finish_grow17h554712b1797863cdE
          local.get 5
          i32.load offset=8
          i32.const 1
          i32.ne
          br_if 1 (;@1;)
          local.get 5
          i32.load offset=16
          local.set 2
          local.get 5
          i32.load offset=12
          local.set 6
        end
        local.get 6
        local.get 2
        global.get $GOT.data.internal.__memory_base
        i32.const 1057744
        i32.add
        call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
        unreachable
      end
      local.get 5
      i32.load offset=12
      local.set 3
      local.get 0
      local.get 1
      i32.store
      local.get 0
      local.get 3
      i32.store offset=4
      local.get 5
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN5alloc7raw_vec11finish_grow17h554712b1797863cdE (;46;) (type 5) (param i32 i32 i32 i32)
      (local i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 3
              i32.load offset=4
              i32.eqz
              br_if 0 (;@4;)
              block ;; label = @5
                local.get 3
                i32.load offset=8
                local.tee 4
                br_if 0 (;@5;)
                local.get 2
                br_if 2 (;@3;)
                i32.const 0
                local.set 3
                br 4 (;@1;)
              end
              local.get 3
              i32.load
              local.get 4
              local.get 1
              local.get 2
              call $_RNvCskdKJRKLKjqM_7___rustc14___rust_realloc
              local.set 3
              br 2 (;@2;)
            end
            local.get 2
            br_if 0 (;@3;)
            i32.const 0
            local.set 3
            br 2 (;@1;)
          end
          call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
          local.get 2
          local.get 1
          call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
          local.set 3
        end
        local.get 3
        local.get 1
        local.get 3
        select
        local.set 1
        local.get 3
        i32.eqz
        local.set 3
      end
      local.get 0
      local.get 2
      i32.store offset=8
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 0
      local.get 3
      i32.store
    )
    (func $_ZN3std2io5error5Error3new17h6d5ce351550dc8b3E (;47;) (type 3) (param i32 i32 i32)
      (local i32)
      call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
      block ;; label = @1
        block ;; label = @2
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 3
          local.get 2
          i64.load align=4
          i64.store align=4
          local.get 3
          i32.const 8
          i32.add
          local.get 2
          i32.const 8
          i32.add
          i32.load
          i32.store
          call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
          local.tee 2
          i32.eqz
          br_if 1 (;@1;)
          local.get 2
          local.get 1
          i32.store8 offset=8
          local.get 2
          local.get 3
          i32.store
          local.get 2
          global.get $GOT.data.internal.__memory_base
          i32.const 1057700
          i32.add
          i32.store offset=4
          local.get 0
          local.get 2
          i64.extend_i32_u
          i64.const 32
          i64.shl
          i64.const 3
          i64.or
          i64.store align=4
          return
        end
        i32.const 4
        i32.const 12
        call $_ZN5alloc5alloc18handle_alloc_error17h2e6feec2f4ff6c76E
        unreachable
      end
      i32.const 4
      i32.const 12
      call $_ZN5alloc5alloc18handle_alloc_error17h2e6feec2f4ff6c76E
      unreachable
    )
    (func $_ZN3std2io5Write14write_vectored17hd9f7e319fdaf1decE (;48;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32)
      local.get 3
      i32.const 3
      i32.shl
      local.set 3
      local.get 2
      i32.const 4
      i32.add
      local.set 2
      loop ;; label = @1
        block ;; label = @2
          local.get 3
          br_if 0 (;@2;)
          local.get 0
          local.get 1
          i32.const 1
          i32.const 0
          call $_ZN66_$LT$std..sys..stdio..wasip2..Stderr$u20$as$u20$std..io..Write$GT$5write17h9a91659d675ae5aaE
          return
        end
        local.get 3
        i32.const -8
        i32.add
        local.set 3
        local.get 2
        i32.load
        local.set 4
        local.get 2
        i32.const 8
        i32.add
        local.tee 5
        local.set 2
        local.get 4
        i32.eqz
        br_if 0 (;@1;)
      end
      local.get 0
      local.get 1
      local.get 5
      i32.const -12
      i32.add
      i32.load
      local.get 4
      call $_ZN66_$LT$std..sys..stdio..wasip2..Stderr$u20$as$u20$std..io..Write$GT$5write17h9a91659d675ae5aaE
    )
    (func $_ZN66_$LT$std..sys..stdio..wasip2..Stderr$u20$as$u20$std..io..Write$GT$5write17h9a91659d675ae5aaE (;49;) (type 5) (param i32 i32 i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        local.get 1
        i32.load
        br_if 0 (;@1;)
        local.get 1
        call $_ZN4wasi7imports4wasi3cli6stderr10get_stderr17h7c2dde8461585e97E
        i32.store offset=4
        local.get 1
        i32.const 1
        i32.store
      end
      local.get 4
      local.get 1
      i32.const 4
      i32.add
      local.get 2
      local.get 3
      i32.const 4096
      local.get 3
      i32.const 4096
      i32.lt_u
      select
      local.tee 1
      call $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush17hefeb5e876bcc0d5eE
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i32.load
          local.tee 3
          i32.const 2
          i32.eq
          br_if 0 (;@2;)
          block ;; label = @3
            local.get 3
            i32.const 1
            i32.and
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            i32.const 4
            i32.store8
            local.get 0
            i32.const 0
            i32.store offset=4
            br 2 (;@1;)
          end
          local.get 4
          local.get 4
          i32.load offset=4
          i32.store offset=16
          local.get 4
          i32.const 20
          i32.add
          local.get 4
          i32.const 16
          i32.add
          call $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string17h686362aefc88ac06E
          local.get 4
          i32.const 8
          i32.add
          i32.const 40
          local.get 4
          i32.const 20
          i32.add
          call $_ZN3std2io5error5Error3new17h6d5ce351550dc8b3E
          block ;; label = @3
            local.get 4
            i32.load offset=16
            local.tee 1
            i32.const -1
            i32.eq
            br_if 0 (;@3;)
            local.get 1
            call $_ZN90_$LT$wasi..imports..wasi..io..error..Error$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17hc8137117dbb2cdf8E
          end
          local.get 0
          local.get 4
          i64.load offset=8
          i64.store align=4
          br 1 (;@1;)
        end
        local.get 0
        i32.const 4
        i32.store8
        local.get 0
        local.get 1
        i32.store offset=4
      end
      local.get 4
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std2io5Write17is_write_vectored17h8933f3dea39b82baE (;50;) (type 9) (param i32) (result i32)
      i32.const 0
    )
    (func $_ZN3std2io5Write18write_all_vectored17h2fa6eb0ca671d7d9E (;51;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32 i64 i64 i32 i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 3
              i32.eqz
              br_if 0 (;@4;)
              local.get 2
              i32.const 4
              i32.add
              local.set 5
              local.get 3
              i32.const 3
              i32.shl
              local.tee 6
              i32.const -8
              i32.add
              i32.const 3
              i32.shr_u
              i32.const 1
              i32.add
              local.set 7
              i32.const 0
              local.set 8
              block ;; label = @5
                loop ;; label = @6
                  local.get 5
                  i32.load
                  br_if 1 (;@5;)
                  local.get 5
                  i32.const 8
                  i32.add
                  local.set 5
                  local.get 8
                  i32.const 1
                  i32.add
                  local.set 8
                  local.get 6
                  i32.const -8
                  i32.add
                  local.tee 6
                  br_if 0 (;@6;)
                end
                local.get 7
                local.set 8
              end
              local.get 3
              local.get 8
              i32.lt_u
              br_if 2 (;@2;)
              local.get 3
              local.get 8
              i32.eq
              br_if 0 (;@4;)
              local.get 1
              i32.const 4
              i32.add
              local.set 9
              local.get 3
              local.get 8
              i32.sub
              local.set 10
              local.get 2
              local.get 8
              i32.const 3
              i32.shl
              i32.add
              local.set 7
              loop ;; label = @5
                local.get 10
                i32.const 3
                i32.shl
                local.set 8
                i32.const 0
                local.set 2
                i32.const 0
                local.set 5
                block ;; label = @6
                  loop ;; label = @7
                    block ;; label = @8
                      local.get 8
                      local.get 5
                      i32.ne
                      br_if 0 (;@8;)
                      i32.const 1
                      local.set 5
                      br 2 (;@6;)
                    end
                    local.get 7
                    local.get 5
                    i32.add
                    local.set 6
                    local.get 5
                    i32.const 8
                    i32.add
                    local.tee 3
                    local.set 5
                    local.get 6
                    i32.const 4
                    i32.add
                    i32.load
                    local.tee 6
                    i32.eqz
                    br_if 0 (;@7;)
                  end
                  local.get 7
                  local.get 3
                  i32.add
                  i32.const -8
                  i32.add
                  i32.load
                  local.set 5
                  local.get 6
                  local.set 2
                end
                block ;; label = @6
                  local.get 1
                  i32.load
                  br_if 0 (;@6;)
                  local.get 1
                  call $_ZN4wasi7imports4wasi3cli6stderr10get_stderr17h7c2dde8461585e97E
                  i32.store offset=4
                  local.get 1
                  i32.const 1
                  i32.store
                end
                local.get 4
                i32.const 24
                i32.add
                local.get 9
                local.get 5
                local.get 2
                i32.const 4096
                local.get 2
                i32.const 4096
                i32.lt_u
                select
                local.tee 11
                call $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush17hefeb5e876bcc0d5eE
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          block ;; label = @11
                            block ;; label = @12
                              local.get 4
                              i32.load offset=24
                              local.tee 5
                              i32.const 2
                              i32.eq
                              br_if 0 (;@12;)
                              i32.const 0
                              local.set 11
                              local.get 5
                              i32.const 1
                              i32.and
                              br_if 0 (;@12;)
                              local.get 4
                              local.get 4
                              i32.load offset=28
                              i32.store offset=44
                              local.get 4
                              local.get 4
                              i32.const 44
                              i32.add
                              call $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string17h686362aefc88ac06E
                              local.get 4
                              i32.const 32
                              i32.add
                              i32.const 40
                              local.get 4
                              call $_ZN3std2io5error5Error3new17h6d5ce351550dc8b3E
                              block ;; label = @13
                                local.get 4
                                i32.load offset=44
                                local.tee 5
                                i32.const -1
                                i32.eq
                                br_if 0 (;@13;)
                                local.get 5
                                call $_ZN90_$LT$wasi..imports..wasi..io..error..Error$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17hc8137117dbb2cdf8E
                              end
                              local.get 4
                              i64.load offset=32
                              local.tee 12
                              i64.const 32
                              i64.shr_u
                              local.tee 13
                              i32.wrap_i64
                              local.set 5
                              local.get 4
                              i32.load offset=32
                              local.set 14
                              local.get 4
                              i32.load offset=36
                              local.set 11
                              block ;; label = @13
                                block ;; label = @14
                                  block ;; label = @15
                                    local.get 12
                                    i32.wrap_i64
                                    i32.const 255
                                    i32.and
                                    br_table 5 (;@10;) 0 (;@15;) 1 (;@14;) 2 (;@13;) 4 (;@11;) 5 (;@10;)
                                  end
                                  local.get 12
                                  i64.const 65280
                                  i64.and
                                  i64.const 8960
                                  i64.ne
                                  br_if 5 (;@9;)
                                  br 8 (;@6;)
                                end
                                local.get 5
                                i32.load8_u offset=8
                                i32.const 35
                                i32.ne
                                br_if 4 (;@9;)
                                br 7 (;@6;)
                              end
                              local.get 5
                              i32.load8_u offset=8
                              i32.const 35
                              i32.ne
                              br_if 3 (;@9;)
                              br 5 (;@7;)
                            end
                            local.get 14
                            i32.const -256
                            i32.and
                            i32.const 4
                            i32.or
                            local.set 14
                            local.get 11
                            local.set 5
                          end
                          block ;; label = @11
                            local.get 5
                            br_if 0 (;@11;)
                            global.get $GOT.data.internal.__memory_base
                            i32.const 1056944
                            i32.add
                            i64.load
                            local.set 12
                            br 2 (;@9;)
                          end
                          local.get 7
                          i32.const 4
                          i32.add
                          local.set 6
                          local.get 8
                          i32.const -8
                          i32.add
                          i32.const 3
                          i32.shr_u
                          i32.const 1
                          i32.add
                          local.set 15
                          i32.const 0
                          local.set 3
                          loop ;; label = @11
                            local.get 5
                            local.get 6
                            i32.load
                            local.tee 2
                            i32.lt_u
                            br_if 3 (;@8;)
                            local.get 6
                            i32.const 8
                            i32.add
                            local.set 6
                            local.get 3
                            i32.const 1
                            i32.add
                            local.set 3
                            local.get 5
                            local.get 2
                            i32.sub
                            local.set 5
                            local.get 8
                            i32.const -8
                            i32.add
                            local.tee 8
                            br_if 0 (;@11;)
                          end
                          local.get 15
                          local.set 3
                          br 2 (;@8;)
                        end
                        local.get 13
                        i64.const 27
                        i64.eq
                        br_if 3 (;@6;)
                      end
                      local.get 0
                      local.get 12
                      i64.store align=4
                      br 7 (;@1;)
                    end
                    local.get 10
                    local.get 3
                    i32.lt_u
                    br_if 4 (;@3;)
                    block ;; label = @8
                      local.get 10
                      local.get 3
                      i32.ne
                      br_if 0 (;@8;)
                      local.get 5
                      i32.eqz
                      br_if 4 (;@4;)
                      local.get 4
                      i32.const 0
                      i32.store offset=16
                      local.get 4
                      i32.const 1
                      i32.store offset=4
                      local.get 4
                      i64.const 4
                      i64.store offset=8 align=4
                      local.get 4
                      global.get $GOT.data.internal.__memory_base
                      local.tee 5
                      i32.const 1057040
                      i32.add
                      i32.store
                      local.get 4
                      local.get 5
                      i32.const 1057048
                      i32.add
                      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
                      unreachable
                    end
                    block ;; label = @8
                      local.get 7
                      local.get 3
                      i32.const 3
                      i32.shl
                      i32.add
                      local.tee 7
                      i32.load offset=4
                      local.tee 8
                      local.get 5
                      i32.ge_u
                      br_if 0 (;@8;)
                      local.get 4
                      i32.const 0
                      i32.store offset=16
                      local.get 4
                      i32.const 1
                      i32.store offset=4
                      local.get 4
                      i64.const 4
                      i64.store offset=8 align=4
                      local.get 4
                      global.get $GOT.data.internal.__memory_base
                      local.tee 5
                      i32.const 1057064
                      i32.add
                      i32.store
                      local.get 4
                      local.get 5
                      i32.const 1057072
                      i32.add
                      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
                      unreachable
                    end
                    local.get 10
                    local.get 3
                    i32.sub
                    local.set 10
                    local.get 7
                    local.get 8
                    local.get 5
                    i32.sub
                    i32.store offset=4
                    local.get 7
                    local.get 7
                    i32.load
                    local.get 5
                    i32.add
                    i32.store
                    local.get 14
                    i32.const 255
                    i32.and
                    local.tee 5
                    i32.const 4
                    i32.gt_u
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const 3
                    i32.ne
                    br_if 1 (;@6;)
                  end
                  local.get 11
                  i32.load
                  local.set 8
                  block ;; label = @7
                    local.get 11
                    i32.const 4
                    i32.add
                    i32.load
                    local.tee 5
                    i32.load
                    local.tee 6
                    i32.eqz
                    br_if 0 (;@7;)
                    local.get 8
                    local.get 6
                    call_indirect (type 0)
                  end
                  block ;; label = @7
                    local.get 5
                    i32.load offset=4
                    local.tee 6
                    i32.eqz
                    br_if 0 (;@7;)
                    local.get 8
                    local.get 6
                    local.get 5
                    i32.load offset=8
                    call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                  end
                  local.get 11
                  i32.const 12
                  i32.const 4
                  call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                end
                local.get 10
                br_if 0 (;@5;)
              end
            end
            local.get 0
            i32.const 4
            i32.store8
            br 2 (;@1;)
          end
          local.get 3
          local.get 10
          local.get 10
          global.get $GOT.data.internal.__memory_base
          i32.const 1057024
          i32.add
          call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
          unreachable
        end
        local.get 8
        local.get 3
        local.get 3
        global.get $GOT.data.internal.__memory_base
        i32.const 1057024
        i32.add
        call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
        unreachable
      end
      local.get 4
      i32.const 48
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std2io5Write9write_all17h616ed9cf9247be18E (;52;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32 i64 i64 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            i32.const 4
            i32.add
            local.set 5
            loop ;; label = @4
              block ;; label = @5
                local.get 1
                i32.load
                br_if 0 (;@5;)
                local.get 1
                call $_ZN4wasi7imports4wasi3cli6stdout10get_stdout17h651418575672c601E
                i32.store offset=4
                local.get 1
                i32.const 1
                i32.store
              end
              local.get 4
              local.get 5
              local.get 2
              local.get 3
              i32.const 4096
              local.get 3
              i32.const 4096
              i32.lt_u
              select
              local.tee 6
              call $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush17hefeb5e876bcc0d5eE
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        local.get 4
                        i32.load
                        local.tee 7
                        i32.const 2
                        i32.eq
                        br_if 0 (;@9;)
                        i32.const 0
                        local.set 6
                        local.get 7
                        i32.const 1
                        i32.and
                        br_if 0 (;@9;)
                        local.get 4
                        local.get 4
                        i32.load offset=4
                        i32.store offset=16
                        local.get 4
                        i32.const 20
                        i32.add
                        local.get 4
                        i32.const 16
                        i32.add
                        call $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string17h686362aefc88ac06E
                        local.get 4
                        i32.const 8
                        i32.add
                        i32.const 40
                        local.get 4
                        i32.const 20
                        i32.add
                        call $_ZN3std2io5error5Error3new17h6d5ce351550dc8b3E
                        block ;; label = @10
                          local.get 4
                          i32.load offset=16
                          local.tee 6
                          i32.const -1
                          i32.eq
                          br_if 0 (;@10;)
                          local.get 6
                          call $_ZN90_$LT$wasi..imports..wasi..io..error..Error$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17hc8137117dbb2cdf8E
                        end
                        local.get 4
                        i64.load offset=8
                        local.tee 8
                        i64.const 32
                        i64.shr_u
                        local.tee 9
                        i32.wrap_i64
                        local.set 6
                        block ;; label = @10
                          block ;; label = @11
                            local.get 8
                            i32.wrap_i64
                            i32.const 255
                            i32.and
                            br_table 3 (;@8;) 0 (;@11;) 1 (;@10;) 5 (;@6;) 2 (;@9;) 3 (;@8;)
                          end
                          local.get 8
                          i64.const 65280
                          i64.and
                          i64.const 8960
                          i64.ne
                          br_if 8 (;@2;)
                          br 5 (;@5;)
                        end
                        local.get 6
                        i32.load8_u offset=8
                        i32.const 35
                        i32.ne
                        br_if 7 (;@2;)
                        br 4 (;@5;)
                      end
                      block ;; label = @9
                        local.get 6
                        br_if 0 (;@9;)
                        global.get $GOT.data.internal.__memory_base
                        i32.const 1056944
                        i32.add
                        i64.load
                        local.set 8
                        br 7 (;@2;)
                      end
                      local.get 3
                      local.get 6
                      i32.ge_u
                      br_if 1 (;@7;)
                      local.get 6
                      local.get 3
                      local.get 3
                      global.get $GOT.data.internal.__memory_base
                      i32.const 1056952
                      i32.add
                      call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
                      unreachable
                    end
                    local.get 9
                    i64.const 27
                    i64.eq
                    br_if 2 (;@5;)
                    br 5 (;@2;)
                  end
                  local.get 2
                  local.get 6
                  i32.add
                  local.set 2
                  local.get 3
                  local.get 6
                  i32.sub
                  local.set 3
                  br 1 (;@5;)
                end
                local.get 6
                i32.load8_u offset=8
                i32.const 35
                i32.ne
                br_if 3 (;@2;)
                local.get 6
                i32.load
                local.set 10
                block ;; label = @6
                  local.get 6
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 7
                  i32.load
                  local.tee 11
                  i32.eqz
                  br_if 0 (;@6;)
                  local.get 10
                  local.get 11
                  call_indirect (type 0)
                end
                block ;; label = @6
                  local.get 7
                  i32.load offset=4
                  local.tee 11
                  i32.eqz
                  br_if 0 (;@6;)
                  local.get 10
                  local.get 11
                  local.get 7
                  i32.load offset=8
                  call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                end
                local.get 6
                i32.const 12
                i32.const 4
                call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
              end
              local.get 3
              br_if 0 (;@4;)
            end
          end
          local.get 0
          i32.const 4
          i32.store8
          br 1 (;@1;)
        end
        local.get 0
        local.get 8
        i64.store align=4
      end
      local.get 4
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std2io5Write9write_all17h6cce4afb022c1e6bE (;53;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32 i64 i64 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            i32.const 4
            i32.add
            local.set 5
            loop ;; label = @4
              block ;; label = @5
                local.get 1
                i32.load
                br_if 0 (;@5;)
                local.get 1
                call $_ZN4wasi7imports4wasi3cli6stderr10get_stderr17h7c2dde8461585e97E
                i32.store offset=4
                local.get 1
                i32.const 1
                i32.store
              end
              local.get 4
              local.get 5
              local.get 2
              local.get 3
              i32.const 4096
              local.get 3
              i32.const 4096
              i32.lt_u
              select
              local.tee 6
              call $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush17hefeb5e876bcc0d5eE
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        local.get 4
                        i32.load
                        local.tee 7
                        i32.const 2
                        i32.eq
                        br_if 0 (;@9;)
                        i32.const 0
                        local.set 6
                        local.get 7
                        i32.const 1
                        i32.and
                        br_if 0 (;@9;)
                        local.get 4
                        local.get 4
                        i32.load offset=4
                        i32.store offset=16
                        local.get 4
                        i32.const 20
                        i32.add
                        local.get 4
                        i32.const 16
                        i32.add
                        call $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string17h686362aefc88ac06E
                        local.get 4
                        i32.const 8
                        i32.add
                        i32.const 40
                        local.get 4
                        i32.const 20
                        i32.add
                        call $_ZN3std2io5error5Error3new17h6d5ce351550dc8b3E
                        block ;; label = @10
                          local.get 4
                          i32.load offset=16
                          local.tee 6
                          i32.const -1
                          i32.eq
                          br_if 0 (;@10;)
                          local.get 6
                          call $_ZN90_$LT$wasi..imports..wasi..io..error..Error$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17hc8137117dbb2cdf8E
                        end
                        local.get 4
                        i64.load offset=8
                        local.tee 8
                        i64.const 32
                        i64.shr_u
                        local.tee 9
                        i32.wrap_i64
                        local.set 6
                        block ;; label = @10
                          block ;; label = @11
                            local.get 8
                            i32.wrap_i64
                            i32.const 255
                            i32.and
                            br_table 3 (;@8;) 0 (;@11;) 1 (;@10;) 5 (;@6;) 2 (;@9;) 3 (;@8;)
                          end
                          local.get 8
                          i64.const 65280
                          i64.and
                          i64.const 8960
                          i64.ne
                          br_if 8 (;@2;)
                          br 5 (;@5;)
                        end
                        local.get 6
                        i32.load8_u offset=8
                        i32.const 35
                        i32.ne
                        br_if 7 (;@2;)
                        br 4 (;@5;)
                      end
                      block ;; label = @9
                        local.get 6
                        br_if 0 (;@9;)
                        global.get $GOT.data.internal.__memory_base
                        i32.const 1056944
                        i32.add
                        i64.load
                        local.set 8
                        br 7 (;@2;)
                      end
                      local.get 3
                      local.get 6
                      i32.ge_u
                      br_if 1 (;@7;)
                      local.get 6
                      local.get 3
                      local.get 3
                      global.get $GOT.data.internal.__memory_base
                      i32.const 1056952
                      i32.add
                      call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
                      unreachable
                    end
                    local.get 9
                    i64.const 27
                    i64.eq
                    br_if 2 (;@5;)
                    br 5 (;@2;)
                  end
                  local.get 2
                  local.get 6
                  i32.add
                  local.set 2
                  local.get 3
                  local.get 6
                  i32.sub
                  local.set 3
                  br 1 (;@5;)
                end
                local.get 6
                i32.load8_u offset=8
                i32.const 35
                i32.ne
                br_if 3 (;@2;)
                local.get 6
                i32.load
                local.set 10
                block ;; label = @6
                  local.get 6
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 7
                  i32.load
                  local.tee 11
                  i32.eqz
                  br_if 0 (;@6;)
                  local.get 10
                  local.get 11
                  call_indirect (type 0)
                end
                block ;; label = @6
                  local.get 7
                  i32.load offset=4
                  local.tee 11
                  i32.eqz
                  br_if 0 (;@6;)
                  local.get 10
                  local.get 11
                  local.get 7
                  i32.load offset=8
                  call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                end
                local.get 6
                i32.const 12
                i32.const 4
                call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
              end
              local.get 3
              br_if 0 (;@4;)
            end
          end
          local.get 0
          i32.const 4
          i32.store8
          br 1 (;@1;)
        end
        local.get 0
        local.get 8
        i64.store align=4
      end
      local.get 4
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std2io5Write9write_fmt17h995e0d97b2ee8b94E (;54;) (type 3) (param i32 i32 i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      i32.const 16
      i32.add
      local.get 2
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      local.get 2
      i64.load align=4
      i64.store
      local.get 3
      i32.const 4
      i32.store8 offset=24
      local.get 3
      local.get 1
      i32.store offset=32
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 24
            i32.add
            global.get $GOT.data.internal.__memory_base
            i32.const 1056908
            i32.add
            local.get 3
            call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
            i32.eqz
            br_if 0 (;@3;)
            local.get 3
            i32.load8_u offset=24
            i32.const 4
            i32.ne
            br_if 1 (;@2;)
            local.get 3
            i32.const 0
            i32.store offset=56
            local.get 3
            i32.const 1
            i32.store offset=44
            local.get 3
            i64.const 4
            i64.store offset=48 align=4
            local.get 3
            global.get $GOT.data.internal.__memory_base
            local.tee 2
            i32.const 1056836
            i32.add
            i32.store offset=40
            local.get 3
            i32.const 40
            i32.add
            local.get 2
            i32.const 1056844
            i32.add
            call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
            unreachable
          end
          local.get 0
          i32.const 4
          i32.store8
          local.get 3
          i32.load offset=28
          local.set 1
          block ;; label = @3
            local.get 3
            i32.load8_u offset=24
            local.tee 2
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            i32.const 3
            i32.ne
            br_if 2 (;@1;)
          end
          local.get 1
          i32.load
          local.set 0
          block ;; label = @3
            local.get 1
            i32.const 4
            i32.add
            i32.load
            local.tee 2
            i32.load
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 2
            i32.load offset=4
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            local.get 2
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 1
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          br 1 (;@1;)
        end
        local.get 0
        local.get 3
        i64.load offset=24
        i64.store align=4
      end
      local.get 3
      i32.const 64
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std2io5Write9write_fmt17hab634e1b5ef51410E (;55;) (type 3) (param i32 i32 i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      i32.const 16
      i32.add
      local.get 2
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      local.get 2
      i64.load align=4
      i64.store
      local.get 3
      i32.const 4
      i32.store8 offset=24
      local.get 3
      local.get 1
      i32.store offset=32
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 24
            i32.add
            global.get $GOT.data.internal.__memory_base
            i32.const 1056812
            i32.add
            local.get 3
            call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
            i32.eqz
            br_if 0 (;@3;)
            local.get 3
            i32.load8_u offset=24
            i32.const 4
            i32.ne
            br_if 1 (;@2;)
            local.get 3
            i32.const 0
            i32.store offset=56
            local.get 3
            i32.const 1
            i32.store offset=44
            local.get 3
            i64.const 4
            i64.store offset=48 align=4
            local.get 3
            global.get $GOT.data.internal.__memory_base
            local.tee 2
            i32.const 1056836
            i32.add
            i32.store offset=40
            local.get 3
            i32.const 40
            i32.add
            local.get 2
            i32.const 1056844
            i32.add
            call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
            unreachable
          end
          local.get 0
          i32.const 4
          i32.store8
          local.get 3
          i32.load offset=28
          local.set 1
          block ;; label = @3
            local.get 3
            i32.load8_u offset=24
            local.tee 2
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            i32.const 3
            i32.ne
            br_if 2 (;@1;)
          end
          local.get 1
          i32.load
          local.set 0
          block ;; label = @3
            local.get 1
            i32.const 4
            i32.add
            i32.load
            local.tee 2
            i32.load
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 2
            i32.load offset=4
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            local.get 2
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 1
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          br 1 (;@1;)
        end
        local.get 0
        local.get 3
        i64.load offset=24
        i64.store align=4
      end
      local.get 3
      i32.const 64
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std3sys3pal6wasip22os12error_string17h6c20c5f2d2238f7fE (;56;) (type 1) (param i32 i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 1056
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        i32.const 1024
        i32.eqz
        br_if 0 (;@1;)
        local.get 2
        i32.const 0
        i32.const 1024
        memory.fill
      end
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            local.get 2
            i32.const 1024
            call $strerror_r
            i32.const 0
            i32.lt_s
            br_if 0 (;@3;)
            local.get 2
            i32.const 1024
            i32.add
            local.get 2
            local.get 2
            call $strlen
            call $_ZN4core3str8converts9from_utf817h25f60ed39aa8d897E
            local.get 2
            i32.load offset=1024
            br_if 1 (;@2;)
            i32.const 0
            local.set 3
            local.get 2
            i32.load offset=1032
            local.tee 1
            i32.const 0
            i32.lt_s
            br_if 2 (;@1;)
            local.get 2
            i32.load offset=1028
            local.set 4
            block ;; label = @4
              block ;; label = @5
                local.get 1
                br_if 0 (;@5;)
                i32.const 1
                local.set 5
                br 1 (;@4;)
              end
              call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
              i32.const 1
              local.set 3
              local.get 1
              i32.const 1
              call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
              local.tee 5
              i32.eqz
              br_if 3 (;@1;)
            end
            block ;; label = @4
              local.get 1
              i32.eqz
              br_if 0 (;@4;)
              local.get 5
              local.get 4
              local.get 1
              memory.copy
            end
            local.get 0
            local.get 1
            i32.store offset=8
            local.get 0
            local.get 5
            i32.store offset=4
            local.get 0
            local.get 1
            i32.store
            local.get 2
            i32.const 1056
            i32.add
            global.set $__stack_pointer
            return
          end
          local.get 2
          i32.const 0
          i32.store offset=1040
          local.get 2
          i32.const 1
          i32.store offset=1028
          local.get 2
          i64.const 4
          i64.store offset=1032 align=4
          local.get 2
          global.get $GOT.data.internal.__memory_base
          local.tee 1
          i32.const 1057152
          i32.add
          i32.store offset=1024
          local.get 2
          i32.const 1024
          i32.add
          local.get 1
          i32.const 1057160
          i32.add
          call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
          unreachable
        end
        local.get 2
        local.get 2
        i64.load offset=1028 align=4
        i64.store offset=1048
        global.get $GOT.data.internal.__memory_base
        local.tee 1
        i32.const 1050668
        i32.add
        i32.const 43
        local.get 2
        i32.const 1048
        i32.add
        local.get 1
        i32.const 1057100
        i32.add
        local.get 1
        i32.const 1057136
        i32.add
        call $_ZN4core6result13unwrap_failed17h448fe3da622852aeE
        unreachable
      end
      local.get 3
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1057872
      i32.add
      call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
      unreachable
    )
    (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$14write_vectored17h710fcb13e5f21c1eE (;57;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          local.get 3
          br_if 0 (;@2;)
          i32.const 0
          local.set 4
          br 1 (;@1;)
        end
        local.get 3
        i32.const 3
        i32.and
        local.set 5
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 4
            i32.ge_u
            br_if 0 (;@3;)
            i32.const 0
            local.set 4
            i32.const 0
            local.set 6
            br 1 (;@2;)
          end
          local.get 2
          i32.const 28
          i32.add
          local.set 7
          local.get 3
          i32.const -4
          i32.and
          local.set 8
          i32.const 0
          local.set 4
          i32.const 0
          local.set 6
          loop ;; label = @3
            local.get 7
            i32.load
            local.get 7
            i32.const -8
            i32.add
            i32.load
            local.get 7
            i32.const -16
            i32.add
            i32.load
            local.get 7
            i32.const -24
            i32.add
            i32.load
            local.get 4
            i32.add
            i32.add
            i32.add
            i32.add
            local.set 4
            local.get 7
            i32.const 32
            i32.add
            local.set 7
            local.get 8
            local.get 6
            i32.const 4
            i32.add
            local.tee 6
            i32.ne
            br_if 0 (;@3;)
          end
        end
        block ;; label = @2
          local.get 5
          i32.eqz
          br_if 0 (;@2;)
          local.get 6
          i32.const 3
          i32.shl
          local.get 2
          i32.add
          i32.const 4
          i32.add
          local.set 7
          loop ;; label = @3
            local.get 7
            i32.load
            local.get 4
            i32.add
            local.set 4
            local.get 7
            i32.const 8
            i32.add
            local.set 7
            local.get 5
            i32.const -1
            i32.add
            local.tee 5
            br_if 0 (;@3;)
          end
        end
        local.get 3
        i32.const 3
        i32.shl
        local.set 7
        block ;; label = @2
          local.get 4
          local.get 1
          i32.load
          local.get 1
          i32.load offset=8
          local.tee 5
          i32.sub
          i32.le_u
          br_if 0 (;@2;)
          local.get 1
          local.get 5
          local.get 4
          i32.const 1
          i32.const 1
          call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
        end
        local.get 2
        local.get 7
        i32.add
        local.set 8
        local.get 1
        i32.load offset=8
        local.set 7
        loop ;; label = @2
          local.get 2
          i32.load
          local.set 6
          block ;; label = @3
            local.get 2
            i32.const 4
            i32.add
            i32.load
            local.tee 5
            local.get 1
            i32.load
            local.get 7
            i32.sub
            i32.le_u
            br_if 0 (;@3;)
            local.get 1
            local.get 7
            local.get 5
            i32.const 1
            i32.const 1
            call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
            local.get 1
            i32.load offset=8
            local.set 7
          end
          block ;; label = @3
            local.get 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            i32.load offset=4
            local.get 7
            i32.add
            local.get 6
            local.get 5
            memory.copy
          end
          local.get 1
          local.get 7
          local.get 5
          i32.add
          local.tee 7
          i32.store offset=8
          local.get 2
          i32.const 8
          i32.add
          local.tee 2
          local.get 8
          i32.ne
          br_if 0 (;@2;)
        end
      end
      local.get 0
      i32.const 4
      i32.store8
      local.get 0
      local.get 4
      i32.store offset=4
    )
    (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$17is_write_vectored17had9d3e2305c5930bE (;58;) (type 9) (param i32) (result i32)
      i32.const 1
    )
    (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$18write_all_vectored17hb9cf078a3786329fE (;59;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32 i32)
      block ;; label = @1
        local.get 3
        i32.eqz
        br_if 0 (;@1;)
        local.get 3
        i32.const 3
        i32.and
        local.set 4
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 4
            i32.ge_u
            br_if 0 (;@3;)
            i32.const 0
            local.set 5
            i32.const 0
            local.set 6
            br 1 (;@2;)
          end
          local.get 2
          i32.const 28
          i32.add
          local.set 7
          local.get 3
          i32.const -4
          i32.and
          local.set 8
          i32.const 0
          local.set 5
          i32.const 0
          local.set 6
          loop ;; label = @3
            local.get 7
            i32.load
            local.get 7
            i32.const -8
            i32.add
            i32.load
            local.get 7
            i32.const -16
            i32.add
            i32.load
            local.get 7
            i32.const -24
            i32.add
            i32.load
            local.get 5
            i32.add
            i32.add
            i32.add
            i32.add
            local.set 5
            local.get 7
            i32.const 32
            i32.add
            local.set 7
            local.get 8
            local.get 6
            i32.const 4
            i32.add
            local.tee 6
            i32.ne
            br_if 0 (;@3;)
          end
        end
        block ;; label = @2
          local.get 4
          i32.eqz
          br_if 0 (;@2;)
          local.get 6
          i32.const 3
          i32.shl
          local.get 2
          i32.add
          i32.const 4
          i32.add
          local.set 7
          loop ;; label = @3
            local.get 7
            i32.load
            local.get 5
            i32.add
            local.set 5
            local.get 7
            i32.const 8
            i32.add
            local.set 7
            local.get 4
            i32.const -1
            i32.add
            local.tee 4
            br_if 0 (;@3;)
          end
        end
        local.get 3
        i32.const 3
        i32.shl
        local.set 4
        block ;; label = @2
          local.get 5
          local.get 1
          i32.load
          local.get 1
          i32.load offset=8
          local.tee 7
          i32.sub
          i32.le_u
          br_if 0 (;@2;)
          local.get 1
          local.get 7
          local.get 5
          i32.const 1
          i32.const 1
          call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
          local.get 1
          i32.load offset=8
          local.set 7
        end
        local.get 2
        local.get 4
        i32.add
        local.set 6
        loop ;; label = @2
          local.get 2
          i32.load
          local.set 4
          block ;; label = @3
            local.get 2
            i32.const 4
            i32.add
            i32.load
            local.tee 5
            local.get 1
            i32.load
            local.get 7
            i32.sub
            i32.le_u
            br_if 0 (;@3;)
            local.get 1
            local.get 7
            local.get 5
            i32.const 1
            i32.const 1
            call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
            local.get 1
            i32.load offset=8
            local.set 7
          end
          block ;; label = @3
            local.get 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            i32.load offset=4
            local.get 7
            i32.add
            local.get 4
            local.get 5
            memory.copy
          end
          local.get 1
          local.get 7
          local.get 5
          i32.add
          local.tee 7
          i32.store offset=8
          local.get 2
          i32.const 8
          i32.add
          local.tee 2
          local.get 6
          i32.ne
          br_if 0 (;@2;)
        end
      end
      local.get 0
      i32.const 4
      i32.store8
    )
    (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5flush17h7cef622e8da8605cE (;60;) (type 1) (param i32 i32)
      local.get 0
      i32.const 4
      i32.store8
    )
    (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5write17h6db40419abd2303bE (;61;) (type 5) (param i32 i32 i32 i32)
      (local i32)
      block ;; label = @1
        local.get 3
        local.get 1
        i32.load
        local.get 1
        i32.load offset=8
        local.tee 4
        i32.sub
        i32.le_u
        br_if 0 (;@1;)
        local.get 1
        local.get 4
        local.get 3
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
        local.get 1
        i32.load offset=8
        local.set 4
      end
      block ;; label = @1
        local.get 3
        i32.eqz
        br_if 0 (;@1;)
        local.get 1
        i32.load offset=4
        local.get 4
        i32.add
        local.get 2
        local.get 3
        memory.copy
      end
      local.get 0
      local.get 3
      i32.store offset=4
      local.get 1
      local.get 4
      local.get 3
      i32.add
      i32.store offset=8
      local.get 0
      i32.const 4
      i32.store8
    )
    (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$9write_all17he77f898d39ebae62E (;62;) (type 5) (param i32 i32 i32 i32)
      (local i32)
      block ;; label = @1
        local.get 3
        local.get 1
        i32.load
        local.get 1
        i32.load offset=8
        local.tee 4
        i32.sub
        i32.le_u
        br_if 0 (;@1;)
        local.get 1
        local.get 4
        local.get 3
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
        local.get 1
        i32.load offset=8
        local.set 4
      end
      block ;; label = @1
        local.get 3
        i32.eqz
        br_if 0 (;@1;)
        local.get 1
        i32.load offset=4
        local.get 4
        i32.add
        local.get 2
        local.get 3
        memory.copy
      end
      local.get 0
      i32.const 4
      i32.store8
      local.get 1
      local.get 4
      local.get 3
      i32.add
      i32.store offset=8
    )
    (func $_ZN3std2io5stdio31print_to_buffer_if_capture_used17h17506a62346c2b22E (;63;) (type 9) (param i32) (result i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            global.get $GOT.data.internal.__memory_base
            i32.const 1058632
            i32.add
            i32.load8_u
            br_if 0 (;@3;)
            i32.const 0
            local.set 2
            br 1 (;@2;)
          end
          global.get $GOT.data.internal.__memory_base
          i32.const 1058628
          i32.add
          local.tee 3
          i32.load
          local.set 4
          i32.const 0
          local.set 2
          local.get 3
          i32.const 0
          i32.store
          local.get 4
          i32.eqz
          br_if 0 (;@2;)
          local.get 4
          i32.load8_u offset=8
          local.set 2
          local.get 4
          i32.const 1
          i32.store8 offset=8
          local.get 1
          local.get 2
          i32.store8 offset=7
          local.get 2
          i32.const 1
          i32.eq
          br_if 1 (;@1;)
          local.get 1
          i32.const 8
          i32.add
          local.get 4
          i32.const 12
          i32.add
          local.get 0
          call $_ZN3std2io5Write9write_fmt17hab634e1b5ef51410E
          local.get 1
          i32.load offset=12
          local.set 0
          block ;; label = @3
            block ;; label = @4
              local.get 1
              i32.load8_u offset=8
              local.tee 2
              i32.const 4
              i32.gt_u
              br_if 0 (;@4;)
              local.get 2
              i32.const 3
              i32.ne
              br_if 1 (;@3;)
            end
            local.get 0
            i32.load
            local.set 3
            block ;; label = @4
              local.get 0
              i32.const 4
              i32.add
              i32.load
              local.tee 2
              i32.load
              local.tee 5
              i32.eqz
              br_if 0 (;@4;)
              local.get 3
              local.get 5
              call_indirect (type 0)
            end
            block ;; label = @4
              local.get 2
              i32.load offset=4
              local.tee 5
              i32.eqz
              br_if 0 (;@4;)
              local.get 3
              local.get 5
              local.get 2
              i32.load offset=8
              call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
            end
            local.get 0
            i32.const 12
            i32.const 4
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 4
          i32.const 0
          i32.store8 offset=8
          global.get $GOT.data.internal.__memory_base
          i32.const 1058628
          i32.add
          local.tee 0
          i32.load
          local.set 2
          local.get 0
          local.get 4
          i32.store
          local.get 1
          local.get 2
          i32.store offset=8
          block ;; label = @3
            local.get 2
            i32.eqz
            br_if 0 (;@3;)
            local.get 2
            local.get 2
            i32.load
            local.tee 4
            i32.const -1
            i32.add
            i32.store
            local.get 4
            i32.const 1
            i32.ne
            br_if 0 (;@3;)
            local.get 1
            i32.const 8
            i32.add
            call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17hcb8df63f968a2f36E
          end
          i32.const 1
          local.set 2
        end
        local.get 1
        i32.const 32
        i32.add
        global.set $__stack_pointer
        local.get 2
        return
      end
      local.get 1
      i64.const 0
      i64.store offset=20 align=4
      local.get 1
      i64.const 17179869185
      i64.store offset=12 align=4
      local.get 1
      global.get $GOT.data.internal.__memory_base
      local.tee 4
      i32.const 1057224
      i32.add
      i32.store offset=8
      i32.const 0
      local.get 1
      i32.const 7
      i32.add
      global.get $GOT.data.internal._ZN3std4sync4mpmc5waker17current_thread_id5DUMMY28_$u7b$$u7b$closure$u7d$$u7d$3VAL17ha7daa1f1ce7c8643E
      local.get 1
      i32.const 8
      i32.add
      local.get 4
      i32.const 1057232
      i32.add
      call $_ZN4core9panicking13assert_failed17hfa1bda2295d26ecdE
      unreachable
    )
    (func $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17hcb8df63f968a2f36E (;64;) (type 0) (param i32)
      (local i32)
      block ;; label = @1
        local.get 0
        i32.load
        local.tee 0
        i32.const 12
        i32.add
        i32.load
        local.tee 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.const 16
        i32.add
        i32.load
        local.get 1
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
      block ;; label = @1
        local.get 0
        i32.const -1
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        local.get 0
        i32.load offset=4
        local.tee 1
        i32.const -1
        i32.add
        i32.store offset=4
        local.get 1
        i32.const 1
        i32.ne
        br_if 0 (;@1;)
        local.get 0
        i32.const 24
        i32.const 4
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
    )
    (func $_ZN4core9panicking13assert_failed17hfa1bda2295d26ecdE (;65;) (type 10) (param i32 i32 i32 i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 5
      global.set $__stack_pointer
      local.get 5
      local.get 2
      i32.store offset=12
      local.get 5
      local.get 1
      i32.store offset=8
      local.get 0
      local.get 5
      i32.const 8
      i32.add
      global.get $GOT.data.internal.__memory_base
      i32.const 1057652
      i32.add
      local.tee 2
      local.get 5
      i32.const 12
      i32.add
      local.get 2
      local.get 3
      local.get 4
      call $_ZN4core9panicking19assert_failed_inner17h948b46d16a47337bE
      unreachable
    )
    (func $_ZN3std2io5stdio6Stderr4lock17hf17233a863288a15E (;66;) (type 9) (param i32) (result i32)
      (local i32 i32 i32 i64 i64 i64)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      global.get $GOT.data.internal._ZN3std6thread7current2id2ID17hf355b94f07b7e26bE
      local.set 2
      local.get 0
      i32.load
      local.set 3
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 2
              i64.load
              local.tee 4
              i64.const 0
              i64.ne
              br_if 0 (;@4;)
              global.get $GOT.data.internal.__memory_base
              i32.const 1058736
              i32.add
              i64.load
              local.set 5
              loop ;; label = @5
                local.get 5
                i64.const -1
                i64.eq
                br_if 2 (;@3;)
                global.get $GOT.data.internal.__memory_base
                i32.const 1058736
                i32.add
                local.tee 0
                local.get 5
                i64.const 1
                i64.add
                local.tee 4
                local.get 0
                i64.load
                local.tee 6
                local.get 6
                local.get 5
                i64.eq
                local.tee 0
                select
                i64.store
                local.get 6
                local.set 5
                local.get 0
                i32.eqz
                br_if 0 (;@5;)
              end
              global.get $GOT.data.internal._ZN3std6thread7current2id2ID17hf355b94f07b7e26bE
              local.get 4
              i64.store
            end
            block ;; label = @4
              block ;; label = @5
                local.get 4
                local.get 3
                i64.load
                i64.eq
                br_if 0 (;@5;)
                local.get 3
                i32.load8_u offset=12
                local.set 0
                local.get 3
                i32.const 1
                i32.store8 offset=12
                local.get 1
                local.get 0
                i32.store8 offset=7
                local.get 0
                br_if 3 (;@2;)
                local.get 3
                i32.const 1
                i32.store offset=8
                local.get 3
                local.get 4
                i64.store
                br 1 (;@4;)
              end
              local.get 3
              i32.load offset=8
              local.tee 0
              i32.const -1
              i32.eq
              br_if 3 (;@1;)
              local.get 3
              local.get 0
              i32.const 1
              i32.add
              i32.store offset=8
            end
            local.get 1
            i32.const 32
            i32.add
            global.set $__stack_pointer
            local.get 3
            return
          end
          call $_ZN3std6thread8ThreadId3new9exhausted17h3e67a518470126f4E
          unreachable
        end
        local.get 1
        i64.const 0
        i64.store offset=20 align=4
        local.get 1
        i64.const 17179869185
        i64.store offset=12 align=4
        local.get 1
        global.get $GOT.data.internal.__memory_base
        local.tee 0
        i32.const 1057224
        i32.add
        i32.store offset=8
        i32.const 0
        local.get 1
        i32.const 7
        i32.add
        global.get $GOT.data.internal._ZN3std4sync4mpmc5waker17current_thread_id5DUMMY28_$u7b$$u7b$closure$u7d$$u7d$3VAL17ha7daa1f1ce7c8643E
        local.get 1
        i32.const 8
        i32.add
        local.get 0
        i32.const 1057232
        i32.add
        call $_ZN4core9panicking13assert_failed17hfa1bda2295d26ecdE
        unreachable
      end
      global.get $GOT.data.internal.__memory_base
      local.tee 0
      i32.const 1051021
      i32.add
      i32.const 38
      local.get 0
      i32.const 1057248
      i32.add
      call $_ZN4core6option13expect_failed17had8d4ff3f7f9fec5E
      unreachable
    )
    (func $_ZN3std6thread8ThreadId3new9exhausted17h3e67a518470126f4E (;67;) (type 7)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 0
      global.set $__stack_pointer
      local.get 0
      i32.const 0
      i32.store offset=24
      local.get 0
      i32.const 1
      i32.store offset=12
      local.get 0
      i64.const 4
      i64.store offset=16 align=4
      local.get 0
      global.get $GOT.data.internal.__memory_base
      local.tee 1
      i32.const 1057328
      i32.add
      i32.store offset=8
      local.get 0
      i32.const 8
      i32.add
      local.get 1
      i32.const 1057336
      i32.add
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN3std2io5stdio6_print17h78a8afca499f2881E (;68;) (type 0) (param i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 80
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 1
      i32.const 6
      i32.store offset=12
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1050536
      i32.add
      i32.store offset=8
      block ;; label = @1
        block ;; label = @2
          local.get 0
          call $_ZN3std2io5stdio31print_to_buffer_if_capture_used17h17506a62346c2b22E
          br_if 0 (;@2;)
          block ;; label = @3
            global.get $GOT.data.internal.__memory_base
            i32.const 1058640
            i32.add
            i32.load8_u offset=48
            i32.const 3
            i32.eq
            br_if 0 (;@3;)
            call $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17ha455f2774e16ecf8E
          end
          local.get 1
          global.get $GOT.data.internal.__memory_base
          i32.const 1058640
          i32.add
          i32.store offset=28
          local.get 1
          local.get 1
          i32.const 28
          i32.add
          i32.store offset=40
          local.get 1
          i32.const 16
          i32.add
          local.get 1
          i32.const 40
          i32.add
          local.get 0
          call $_ZN61_$LT$$RF$std..io..stdio..Stdout$u20$as$u20$std..io..Write$GT$9write_fmt17h41e6363b818b9d86E
          local.get 1
          i32.load8_u offset=16
          i32.const 4
          i32.ne
          br_if 1 (;@1;)
        end
        local.get 1
        i32.const 80
        i32.add
        global.set $__stack_pointer
        return
      end
      local.get 1
      local.get 1
      i64.load offset=16
      i64.store offset=32
      local.get 1
      i32.const 2
      i32.store offset=44
      local.get 1
      global.get $GOT.data.internal.__memory_base
      local.tee 0
      i32.const 1056992
      i32.add
      i32.store offset=40
      local.get 1
      i64.const 2
      i64.store offset=52 align=4
      local.get 1
      global.get $GOT.func.internal._ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h254e3ec8c3e51a1fE
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 1
      i32.const 32
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=72
      local.get 1
      global.get $GOT.data.internal.__table_base
      i32.const 5
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 1
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=64
      local.get 1
      local.get 1
      i32.const 64
      i32.add
      i32.store offset=48
      local.get 1
      i32.const 40
      i32.add
      local.get 0
      i32.const 1057008
      i32.add
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17ha455f2774e16ecf8E (;69;) (type 7)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 0
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              global.get $GOT.data.internal.__memory_base
              i32.const 1058640
              i32.add
              i32.load8_u offset=48
              br_table 0 (;@4;) 0 (;@4;) 3 (;@1;) 1 (;@3;) 0 (;@4;)
            end
            global.get $GOT.data.internal.__memory_base
            i32.const 1058640
            i32.add
            i32.const 2
            i32.store8 offset=48
            call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
            i32.const 1024
            i32.const 1
            call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
            local.tee 1
            i32.eqz
            br_if 1 (;@2;)
            global.get $GOT.data.internal.__memory_base
            i32.const 1058640
            i32.add
            local.tee 2
            i32.const 3
            i32.store8 offset=48
            local.get 2
            i64.const 0
            i64.store offset=36 align=4
            local.get 2
            i32.const 0
            i32.store8 offset=32
            local.get 2
            i32.const 0
            i32.store offset=28
            local.get 2
            local.get 1
            i32.store offset=24
            local.get 2
            i64.const 4398046511104
            i64.store offset=16
            local.get 2
            i32.const 0
            i32.store8 offset=12
            local.get 2
            i32.const 0
            i32.store offset=8
            local.get 2
            i64.const 0
            i64.store
          end
          local.get 0
          i32.const 32
          i32.add
          global.set $__stack_pointer
          return
        end
        i32.const 1
        i32.const 1024
        global.get $GOT.data.internal.__memory_base
        i32.const 1056976
        i32.add
        call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
        unreachable
      end
      local.get 0
      i32.const 0
      i32.store offset=24
      local.get 0
      i32.const 1
      i32.store offset=12
      local.get 0
      i64.const 4
      i64.store offset=16 align=4
      local.get 0
      global.get $GOT.data.internal.__memory_base
      local.tee 2
      i32.const 1057208
      i32.add
      i32.store offset=8
      local.get 0
      i32.const 8
      i32.add
      local.get 2
      i32.const 1057264
      i32.add
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN61_$LT$$RF$std..io..stdio..Stdout$u20$as$u20$std..io..Write$GT$9write_fmt17h41e6363b818b9d86E (;70;) (type 3) (param i32 i32 i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 80
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      i32.load
      call $_ZN3std2io5stdio6Stderr4lock17hf17233a863288a15E
      i32.store offset=12
      local.get 3
      i32.const 16
      i32.add
      i32.const 16
      i32.add
      local.get 2
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      i32.const 16
      i32.add
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 3
      local.get 2
      i64.load align=4
      i64.store offset=16
      local.get 3
      i32.const 4
      i32.store8 offset=40
      global.get $GOT.data.internal.__memory_base
      local.set 2
      local.get 3
      local.get 3
      i32.const 12
      i32.add
      i32.store offset=48
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 40
            i32.add
            local.get 2
            i32.const 1056860
            i32.add
            local.get 3
            i32.const 16
            i32.add
            call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
            i32.eqz
            br_if 0 (;@3;)
            local.get 3
            i32.load8_u offset=40
            i32.const 4
            i32.ne
            br_if 1 (;@2;)
            local.get 3
            i32.const 0
            i32.store offset=72
            local.get 3
            i32.const 1
            i32.store offset=60
            local.get 3
            i64.const 4
            i64.store offset=64 align=4
            local.get 3
            global.get $GOT.data.internal.__memory_base
            local.tee 2
            i32.const 1056836
            i32.add
            i32.store offset=56
            local.get 3
            i32.const 56
            i32.add
            local.get 2
            i32.const 1056844
            i32.add
            call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
            unreachable
          end
          local.get 0
          i32.const 4
          i32.store8
          local.get 3
          i32.load offset=44
          local.set 1
          block ;; label = @3
            local.get 3
            i32.load8_u offset=40
            local.tee 2
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            i32.const 3
            i32.ne
            br_if 2 (;@1;)
          end
          local.get 1
          i32.load
          local.set 0
          block ;; label = @3
            local.get 1
            i32.const 4
            i32.add
            i32.load
            local.tee 2
            i32.load
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 2
            i32.load offset=4
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            local.get 2
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 1
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          br 1 (;@1;)
        end
        local.get 0
        local.get 3
        i64.load offset=40
        i64.store align=4
      end
      local.get 3
      i32.load offset=12
      local.tee 2
      local.get 2
      i32.load offset=8
      i32.const -1
      i32.add
      local.tee 1
      i32.store offset=8
      block ;; label = @1
        local.get 1
        br_if 0 (;@1;)
        local.get 2
        i32.const 0
        i32.store8 offset=12
        local.get 2
        i64.const 0
        i64.store
      end
      local.get 3
      i32.const 80
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h254e3ec8c3e51a1fE (;71;) (type 2) (param i32 i32) (result i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                local.get 0
                i32.load8_u
                br_table 0 (;@5;) 1 (;@4;) 2 (;@3;) 3 (;@2;) 0 (;@5;)
              end
              local.get 2
              local.get 0
              i32.load offset=4
              local.tee 0
              i32.store offset=4
              local.get 2
              i32.const 8
              i32.add
              local.get 0
              call $_ZN3std3sys3pal6wasip22os12error_string17h6c20c5f2d2238f7fE
              local.get 2
              global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17hc286a2587fb896f9E
              i64.extend_i32_u
              i64.const 32
              i64.shl
              local.get 2
              i32.const 4
              i32.add
              i64.extend_i32_u
              i64.or
              i64.store offset=32
              local.get 2
              global.get $GOT.data.internal.__table_base
              i32.const 7
              i32.add
              i64.extend_i32_u
              i64.const 32
              i64.shl
              local.get 2
              i32.const 8
              i32.add
              i64.extend_i32_u
              i64.or
              i64.store offset=24
              local.get 1
              i32.load
              local.set 0
              local.get 1
              i32.load offset=4
              local.set 1
              local.get 2
              i64.const 2
              i64.store offset=52 align=4
              local.get 2
              i32.const 3
              i32.store offset=44
              local.get 2
              global.get $GOT.data.internal.__memory_base
              i32.const 1057760
              i32.add
              i32.store offset=40
              local.get 2
              local.get 2
              i32.const 24
              i32.add
              i32.store offset=48
              local.get 0
              local.get 1
              local.get 2
              i32.const 40
              i32.add
              call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
              local.set 0
              local.get 2
              i32.load offset=8
              local.tee 1
              i32.eqz
              br_if 3 (;@1;)
              local.get 2
              i32.load offset=12
              local.get 1
              i32.const 1
              call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
              br 3 (;@1;)
            end
            local.get 2
            global.get $GOT.data.internal.__memory_base
            local.tee 3
            i32.const 1051552
            i32.add
            local.get 0
            i32.load8_u offset=1
            i32.const 2
            i32.shl
            local.tee 0
            i32.add
            i32.load
            i32.store offset=28
            local.get 2
            local.get 3
            i32.const 1057920
            i32.add
            local.get 0
            i32.add
            i32.load
            i32.store offset=24
            local.get 2
            global.get $GOT.data.internal.__table_base
            i32.const 5
            i32.add
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 2
            i32.const 24
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=8
            local.get 1
            i32.load
            local.set 0
            local.get 1
            i32.load offset=4
            local.set 1
            local.get 2
            i64.const 1
            i64.store offset=52 align=4
            local.get 2
            i32.const 1
            i32.store offset=44
            local.get 2
            local.get 3
            i32.const 1049652
            i32.add
            i32.store offset=40
            local.get 2
            local.get 2
            i32.const 8
            i32.add
            i32.store offset=48
            local.get 0
            local.get 1
            local.get 2
            i32.const 40
            i32.add
            call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
            local.set 0
            br 2 (;@1;)
          end
          local.get 0
          i32.load offset=4
          local.tee 0
          i32.load
          local.get 0
          i32.load offset=4
          local.get 1
          call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h3b63b9c35892d81bE
          local.set 0
          br 1 (;@1;)
        end
        local.get 0
        i32.load offset=4
        local.tee 0
        i32.load
        local.get 1
        local.get 0
        i32.load offset=4
        i32.load offset=16
        call_indirect (type 2)
        local.set 0
      end
      local.get 2
      i32.const 64
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$9flush_buf17h7ff4363ebaf976d3E (;72;) (type 1) (param i32 i32)
      (local i32 i32 i32 i32 i64 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.load offset=8
            local.tee 3
            br_if 0 (;@3;)
            local.get 0
            i32.const 4
            i32.store8
            br 1 (;@2;)
          end
          local.get 1
          i32.const 16
          i32.add
          local.set 4
          i32.const 0
          local.set 5
          block ;; label = @3
            block ;; label = @4
              loop ;; label = @5
                local.get 1
                i32.const 1
                i32.store8 offset=12
                local.get 2
                i32.const 8
                i32.add
                local.get 4
                local.get 1
                i32.load offset=4
                local.get 5
                i32.add
                local.get 3
                local.get 5
                i32.sub
                call $_ZN60_$LT$std..io..stdio..StdoutRaw$u20$as$u20$std..io..Write$GT$5write17h2076f9e8c2ce79c2E
                local.get 1
                i32.const 0
                i32.store8 offset=12
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          local.get 2
                          i32.load8_u offset=8
                          local.tee 3
                          i32.const 4
                          i32.eq
                          br_if 0 (;@10;)
                          block ;; label = @11
                            block ;; label = @12
                              block ;; label = @13
                                local.get 3
                                br_table 0 (;@13;) 1 (;@12;) 2 (;@11;) 4 (;@9;) 0 (;@13;)
                              end
                              local.get 2
                              i32.load offset=12
                              i32.const 27
                              i32.ne
                              br_if 4 (;@8;)
                              br 6 (;@6;)
                            end
                            local.get 2
                            i32.load8_u offset=9
                            i32.const 35
                            i32.ne
                            br_if 3 (;@8;)
                            br 5 (;@6;)
                          end
                          local.get 2
                          i32.load offset=12
                          i32.load8_u offset=8
                          i32.const 35
                          i32.ne
                          br_if 2 (;@8;)
                          br 4 (;@6;)
                        end
                        block ;; label = @10
                          local.get 2
                          i32.load offset=12
                          local.tee 3
                          br_if 0 (;@10;)
                          global.get $GOT.data.internal.__memory_base
                          i32.const 1057088
                          i32.add
                          i64.extend_i32_u
                          i64.const 32
                          i64.shl
                          i64.const 2
                          i64.or
                          local.set 6
                          br 6 (;@4;)
                        end
                        local.get 3
                        local.get 5
                        i32.add
                        local.set 5
                        br 3 (;@6;)
                      end
                      local.get 2
                      i32.load offset=12
                      local.tee 3
                      i32.load8_u offset=8
                      i32.const 35
                      i32.eq
                      br_if 1 (;@7;)
                    end
                    local.get 2
                    i64.load offset=8
                    local.set 6
                    br 3 (;@4;)
                  end
                  local.get 3
                  i32.load
                  local.set 7
                  block ;; label = @7
                    local.get 3
                    i32.const 4
                    i32.add
                    i32.load
                    local.tee 8
                    i32.load
                    local.tee 9
                    i32.eqz
                    br_if 0 (;@7;)
                    local.get 7
                    local.get 9
                    call_indirect (type 0)
                  end
                  block ;; label = @7
                    local.get 8
                    i32.load offset=4
                    local.tee 9
                    i32.eqz
                    br_if 0 (;@7;)
                    local.get 7
                    local.get 9
                    local.get 8
                    i32.load offset=8
                    call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                  end
                  local.get 3
                  i32.const 12
                  i32.const 4
                  call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                end
                local.get 5
                local.get 1
                i32.load offset=8
                local.tee 3
                i32.ge_u
                br_if 2 (;@3;)
                br 0 (;@5;)
              end
            end
            local.get 0
            local.get 6
            i64.store align=4
            local.get 5
            i32.eqz
            br_if 1 (;@2;)
            block ;; label = @4
              local.get 1
              i32.load offset=8
              local.tee 3
              local.get 5
              i32.lt_u
              br_if 0 (;@4;)
              local.get 1
              i32.const 0
              i32.store offset=8
              local.get 3
              local.get 5
              i32.eq
              br_if 2 (;@2;)
              block ;; label = @5
                local.get 3
                local.get 5
                i32.sub
                local.tee 3
                i32.eqz
                br_if 0 (;@5;)
                local.get 1
                i32.load offset=4
                local.tee 4
                local.get 4
                local.get 5
                i32.add
                local.get 3
                memory.copy
              end
              local.get 1
              local.get 3
              i32.store offset=8
              br 2 (;@2;)
            end
            i32.const 0
            local.get 5
            local.get 3
            global.get $GOT.data.internal.__memory_base
            i32.const 1057668
            i32.add
            call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
            unreachable
          end
          local.get 0
          i32.const 4
          i32.store8
          local.get 5
          i32.eqz
          br_if 0 (;@2;)
          local.get 5
          local.get 3
          i32.gt_u
          br_if 1 (;@1;)
          local.get 1
          i32.const 0
          i32.store offset=8
        end
        local.get 2
        i32.const 16
        i32.add
        global.set $__stack_pointer
        return
      end
      i32.const 0
      local.get 5
      local.get 3
      global.get $GOT.data.internal.__memory_base
      i32.const 1057668
      i32.add
      call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
      unreachable
    )
    (func $_ZN60_$LT$std..io..stdio..StdoutRaw$u20$as$u20$std..io..Write$GT$5write17h2076f9e8c2ce79c2E (;73;) (type 5) (param i32 i32 i32 i32)
      (local i32 i64 i64 i64)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        local.get 1
        i32.load
        br_if 0 (;@1;)
        local.get 1
        call $_ZN4wasi7imports4wasi3cli6stdout10get_stdout17h651418575672c601E
        i32.store offset=4
        local.get 1
        i32.const 1
        i32.store
      end
      local.get 4
      local.get 1
      i32.const 4
      i32.add
      local.get 2
      local.get 3
      i32.const 4096
      local.get 3
      i32.const 4096
      i32.lt_u
      select
      local.tee 1
      call $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush17hefeb5e876bcc0d5eE
      i64.const 4
      local.set 5
      i64.const 0
      local.set 6
      block ;; label = @1
        local.get 4
        i32.load
        local.tee 3
        i32.const 2
        i32.eq
        br_if 0 (;@1;)
        i32.const 0
        local.set 1
        local.get 3
        i32.const 1
        i32.and
        br_if 0 (;@1;)
        local.get 4
        local.get 4
        i32.load offset=4
        i32.store offset=16
        local.get 4
        i32.const 20
        i32.add
        local.get 4
        i32.const 16
        i32.add
        call $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string17h686362aefc88ac06E
        local.get 4
        i32.const 8
        i32.add
        i32.const 40
        local.get 4
        i32.const 20
        i32.add
        call $_ZN3std2io5error5Error3new17h6d5ce351550dc8b3E
        block ;; label = @2
          local.get 4
          i32.load offset=16
          local.tee 1
          i32.const -1
          i32.eq
          br_if 0 (;@2;)
          local.get 1
          call $_ZN90_$LT$wasi..imports..wasi..io..error..Error$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17hc8137117dbb2cdf8E
        end
        local.get 4
        i64.load offset=8
        local.tee 7
        i64.const 255
        i64.and
        local.set 5
        local.get 7
        i64.const 4294967040
        i64.and
        local.set 6
        local.get 7
        i64.const 32
        i64.shr_u
        i32.wrap_i64
        local.set 1
      end
      local.get 0
      local.get 1
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 6
      i64.or
      local.get 5
      i64.or
      i64.store align=4
      local.get 4
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17h4add61127650d4bcE (;74;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          local.get 3
          local.get 1
          i32.load
          local.tee 5
          local.get 1
          i32.load offset=8
          i32.sub
          i32.le_u
          br_if 0 (;@2;)
          local.get 4
          i32.const 8
          i32.add
          local.get 1
          call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$9flush_buf17h7ff4363ebaf976d3E
          block ;; label = @3
            local.get 4
            i32.load8_u offset=8
            i32.const 4
            i32.eq
            br_if 0 (;@3;)
            local.get 0
            local.get 4
            i64.load offset=8
            i64.store align=4
            br 2 (;@1;)
          end
          local.get 1
          i32.load
          local.set 5
        end
        block ;; label = @2
          local.get 3
          local.get 5
          i32.ge_u
          br_if 0 (;@2;)
          local.get 1
          i32.load offset=8
          local.set 5
          block ;; label = @3
            local.get 3
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            i32.load offset=4
            local.get 5
            i32.add
            local.get 2
            local.get 3
            memory.copy
          end
          local.get 0
          i32.const 4
          i32.store8
          local.get 1
          local.get 5
          local.get 3
          i32.add
          i32.store offset=8
          br 1 (;@1;)
        end
        local.get 1
        i32.const 1
        i32.store8 offset=12
        local.get 0
        local.get 1
        i32.const 16
        i32.add
        local.get 2
        local.get 3
        call $_ZN3std2io5Write9write_all17h616ed9cf9247be18E
        local.get 1
        i32.const 0
        i32.store8 offset=12
      end
      local.get 4
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std3env11current_dir17h7be07b83afa290ccE (;75;) (type 0) (param i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
      i32.const 512
      local.set 2
      block ;; label = @1
        block ;; label = @2
          i32.const 512
          i32.const 1
          call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 1
          local.get 3
          i32.store offset=8
          local.get 1
          i32.const 512
          i32.store offset=4
          block ;; label = @3
            block ;; label = @4
              local.get 3
              i32.const 512
              call $getcwd
              br_if 0 (;@4;)
              i32.const 512
              local.set 2
              loop ;; label = @5
                block ;; label = @6
                  global.get $GOT.data.internal.errno
                  i32.load
                  local.tee 4
                  i32.const 68
                  i32.eq
                  br_if 0 (;@6;)
                  local.get 0
                  local.get 4
                  i32.store offset=8
                  local.get 0
                  i64.const 2147483648
                  i64.store align=4
                  local.get 2
                  i32.eqz
                  br_if 3 (;@3;)
                  local.get 3
                  local.get 2
                  i32.const 1
                  call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                  br 3 (;@3;)
                end
                local.get 1
                local.get 2
                i32.store offset=12
                local.get 1
                i32.const 4
                i32.add
                local.get 2
                i32.const 1
                i32.const 1
                i32.const 1
                call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
                local.get 1
                i32.load offset=8
                local.tee 3
                local.get 1
                i32.load offset=4
                local.tee 2
                call $getcwd
                i32.eqz
                br_if 0 (;@5;)
              end
            end
            local.get 1
            local.get 3
            call $strlen
            local.tee 4
            i32.store offset=12
            block ;; label = @4
              local.get 2
              local.get 4
              i32.le_u
              br_if 0 (;@4;)
              block ;; label = @5
                block ;; label = @6
                  local.get 4
                  br_if 0 (;@6;)
                  i32.const 1
                  local.set 5
                  local.get 3
                  local.get 2
                  i32.const 1
                  call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
                  br 1 (;@5;)
                end
                local.get 3
                local.get 2
                i32.const 1
                local.get 4
                call $_RNvCskdKJRKLKjqM_7___rustc14___rust_realloc
                local.tee 5
                i32.eqz
                br_if 4 (;@1;)
              end
              local.get 1
              local.get 4
              i32.store offset=4
              local.get 1
              local.get 5
              i32.store offset=8
            end
            local.get 0
            local.get 1
            i64.load offset=4 align=4
            i64.store align=4
            local.get 0
            i32.const 8
            i32.add
            local.get 1
            i32.const 4
            i32.add
            i32.const 8
            i32.add
            i32.load
            i32.store
          end
          local.get 1
          i32.const 16
          i32.add
          global.set $__stack_pointer
          return
        end
        i32.const 1
        i32.const 512
        global.get $GOT.data.internal.__memory_base
        i32.const 1057176
        i32.add
        call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
        unreachable
      end
      i32.const 1
      local.get 4
      global.get $GOT.data.internal.__memory_base
      i32.const 1057192
      i32.add
      call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
      unreachable
    )
    (func $_ZN3std3env7_var_os17ha40375b13431cf06E (;76;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 416
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 2
            i32.const 383
            i32.gt_u
            br_if 0 (;@3;)
            block ;; label = @4
              local.get 2
              i32.eqz
              br_if 0 (;@4;)
              local.get 3
              i32.const 20
              i32.add
              local.get 1
              local.get 2
              memory.copy
            end
            local.get 3
            i32.const 20
            i32.add
            local.get 2
            i32.add
            i32.const 0
            i32.store8
            local.get 3
            i32.const 404
            i32.add
            local.get 3
            i32.const 20
            i32.add
            local.get 2
            i32.const 1
            i32.add
            call $_ZN4core3ffi5c_str4CStr19from_bytes_with_nul17hdcfbe38e78b1258eE
            block ;; label = @4
              local.get 3
              i32.load offset=404
              i32.const 1
              i32.ne
              br_if 0 (;@4;)
              local.get 3
              global.get $GOT.data.internal.__memory_base
              i32.const 1057128
              i32.add
              i64.load
              i64.store offset=12 align=4
              i32.const -2147483647
              local.set 2
              br 2 (;@2;)
            end
            block ;; label = @4
              local.get 3
              i32.load offset=408
              call $getenv
              local.tee 1
              br_if 0 (;@4;)
              i32.const -2147483648
              local.set 2
              br 2 (;@2;)
            end
            i32.const 0
            local.set 4
            local.get 1
            call $strlen
            local.tee 2
            i32.const 0
            i32.lt_s
            br_if 2 (;@1;)
            block ;; label = @4
              block ;; label = @5
                local.get 2
                br_if 0 (;@5;)
                i32.const 1
                local.set 5
                br 1 (;@4;)
              end
              call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
              i32.const 1
              local.set 4
              local.get 2
              i32.const 1
              call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
              local.tee 5
              i32.eqz
              br_if 3 (;@1;)
            end
            block ;; label = @4
              local.get 2
              i32.eqz
              br_if 0 (;@4;)
              local.get 5
              local.get 1
              local.get 2
              memory.copy
            end
            local.get 3
            local.get 2
            i32.store offset=16
            local.get 3
            local.get 5
            i32.store offset=12
            br 1 (;@2;)
          end
          local.get 3
          i32.const 8
          i32.add
          local.get 1
          local.get 2
          call $_ZN3std3sys3pal6common14small_c_string24run_with_cstr_allocating17hba0039e6125a6e05E
          local.get 3
          i32.load offset=8
          local.set 2
        end
        block ;; label = @2
          block ;; label = @3
            local.get 2
            i32.const -2147483647
            i32.eq
            br_if 0 (;@3;)
            local.get 0
            local.get 3
            i64.load offset=12 align=4
            i64.store offset=4 align=4
            local.get 0
            local.get 2
            i32.store
            br 1 (;@2;)
          end
          block ;; label = @3
            local.get 3
            i32.load8_u offset=12
            i32.const 3
            i32.ne
            br_if 0 (;@3;)
            local.get 3
            i32.load offset=16
            local.tee 2
            i32.load
            local.set 4
            block ;; label = @4
              local.get 2
              i32.const 4
              i32.add
              i32.load
              local.tee 1
              i32.load
              local.tee 5
              i32.eqz
              br_if 0 (;@4;)
              local.get 4
              local.get 5
              call_indirect (type 0)
            end
            block ;; label = @4
              local.get 1
              i32.load offset=4
              local.tee 5
              i32.eqz
              br_if 0 (;@4;)
              local.get 4
              local.get 5
              local.get 1
              i32.load offset=8
              call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
            end
            local.get 2
            i32.const 12
            i32.const 4
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 0
          i32.const -2147483648
          i32.store
        end
        local.get 3
        i32.const 416
        i32.add
        global.set $__stack_pointer
        return
      end
      local.get 4
      local.get 2
      global.get $GOT.data.internal.__memory_base
      i32.const 1057872
      i32.add
      call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
      unreachable
    )
    (func $_ZN3std3sys3pal6common14small_c_string24run_with_cstr_allocating17hba0039e6125a6e05E (;77;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      local.get 2
      call $_ZN72_$LT$$RF$str$u20$as$u20$alloc..ffi..c_str..CString..new..SpecNewImpl$GT$13spec_new_impl17h2a184a51d3df8b57E
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.load
            local.tee 2
            i32.const -2147483648
            i32.ne
            br_if 0 (;@3;)
            local.get 3
            i32.load offset=8
            local.set 1
            block ;; label = @4
              block ;; label = @5
                local.get 3
                i32.load offset=4
                local.tee 4
                call $getenv
                local.tee 5
                br_if 0 (;@5;)
                local.get 0
                i32.const -2147483648
                i32.store
                br 1 (;@4;)
              end
              i32.const 0
              local.set 6
              local.get 5
              call $strlen
              local.tee 2
              i32.const 0
              i32.lt_s
              br_if 3 (;@1;)
              block ;; label = @5
                block ;; label = @6
                  local.get 2
                  br_if 0 (;@6;)
                  i32.const 1
                  local.set 7
                  br 1 (;@5;)
                end
                call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
                i32.const 1
                local.set 6
                local.get 2
                i32.const 1
                call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
                local.tee 7
                i32.eqz
                br_if 4 (;@1;)
              end
              block ;; label = @5
                local.get 2
                i32.eqz
                br_if 0 (;@5;)
                local.get 7
                local.get 5
                local.get 2
                memory.copy
              end
              local.get 0
              local.get 2
              i32.store offset=8
              local.get 0
              local.get 7
              i32.store offset=4
              local.get 0
              local.get 2
              i32.store
            end
            local.get 4
            i32.const 0
            i32.store8
            local.get 1
            i32.eqz
            br_if 1 (;@2;)
            local.get 4
            local.get 1
            i32.const 1
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
            br 1 (;@2;)
          end
          local.get 0
          i32.const -2147483647
          i32.store
          local.get 0
          global.get $GOT.data.internal.__memory_base
          i32.const 1057128
          i32.add
          i64.load
          i64.store offset=4 align=4
          local.get 2
          i32.eqz
          br_if 0 (;@2;)
          local.get 3
          i32.load offset=4
          local.get 2
          i32.const 1
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 3
        i32.const 16
        i32.add
        global.set $__stack_pointer
        return
      end
      local.get 6
      local.get 2
      global.get $GOT.data.internal.__memory_base
      i32.const 1057872
      i32.add
      call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
      unreachable
    )
    (func $_ZN3std3sys3pal6wasip27helpers14abort_internal17h0f2c0424e81d1365E (;78;) (type 7)
      call $abort
      unreachable
    )
    (func $_ZN3std3sys9backtrace13BacktraceLock5print17h69d540a3f4eb0369E (;79;) (type 5) (param i32 i32 i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      local.get 4
      i32.const 1
      i32.store offset=12
      local.get 4
      i64.const 1
      i64.store offset=20 align=4
      local.get 4
      global.get $GOT.data.internal.__memory_base
      i32.const 1049652
      i32.add
      i32.store offset=8
      local.get 4
      local.get 3
      i32.store8 offset=47
      local.get 4
      global.get $GOT.func.internal._ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h165a494cd0246603E
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 4
      i32.const 47
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 4
      local.get 4
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 0
      local.get 1
      local.get 4
      i32.const 8
      i32.add
      local.get 2
      call_indirect (type 3)
      local.get 4
      i32.const 48
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h165a494cd0246603E (;80;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i64 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 1
      i32.load offset=4
      local.set 3
      local.get 1
      i32.load
      local.set 4
      local.get 0
      i32.load8_u
      local.set 0
      local.get 2
      i32.const 4
      i32.add
      call $_ZN3std3env11current_dir17h7be07b83afa290ccE
      local.get 2
      i64.load offset=8 align=4
      local.set 5
      block ;; label = @1
        local.get 2
        i32.load offset=4
        local.tee 1
        i32.const -2147483648
        i32.ne
        br_if 0 (;@1;)
        local.get 5
        i64.const 255
        i64.and
        i64.const 3
        i64.ne
        br_if 0 (;@1;)
        local.get 5
        i64.const 32
        i64.shr_u
        i32.wrap_i64
        local.tee 6
        i32.load
        local.set 7
        block ;; label = @2
          local.get 6
          i32.const 4
          i32.add
          i32.load
          local.tee 8
          i32.load
          local.tee 9
          i32.eqz
          br_if 0 (;@2;)
          local.get 7
          local.get 9
          call_indirect (type 0)
        end
        block ;; label = @2
          local.get 8
          i32.load offset=4
          local.tee 9
          i32.eqz
          br_if 0 (;@2;)
          local.get 7
          local.get 9
          local.get 8
          i32.load offset=8
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 6
        i32.const 12
        i32.const 4
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 4
            global.get $GOT.data.internal.__memory_base
            i32.const 1050884
            i32.add
            i32.const 17
            local.get 3
            i32.load offset=12
            local.tee 3
            call_indirect (type 4)
            br_if 0 (;@3;)
            block ;; label = @4
              local.get 0
              i32.const 1
              i32.and
              br_if 0 (;@4;)
              local.get 4
              global.get $GOT.data.internal.__memory_base
              i32.const 1050901
              i32.add
              i32.const 88
              local.get 3
              call_indirect (type 4)
              br_if 1 (;@3;)
            end
            i32.const 0
            local.set 4
            local.get 1
            i32.const -2147483648
            i32.or
            i32.const -2147483648
            i32.eq
            br_if 2 (;@1;)
            br 1 (;@2;)
          end
          i32.const 1
          local.set 4
          local.get 1
          i32.const -2147483648
          i32.or
          i32.const -2147483648
          i32.eq
          br_if 1 (;@1;)
        end
        local.get 5
        i32.wrap_i64
        local.get 1
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 4
    )
    (func $_ZN3std9panicking13panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h3336da97c87e6cc5E (;81;) (type 0) (param i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 0
      i32.load
      local.tee 2
      i32.load offset=12
      local.set 3
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 2
              i32.load offset=4
              br_table 0 (;@4;) 1 (;@3;) 2 (;@2;)
            end
            local.get 3
            br_if 1 (;@2;)
            i32.const 1
            local.set 2
            i32.const 0
            local.set 3
            br 2 (;@1;)
          end
          local.get 3
          br_if 0 (;@2;)
          local.get 2
          i32.load
          local.tee 2
          i32.load offset=4
          local.set 3
          local.get 2
          i32.load
          local.set 2
          br 1 (;@1;)
        end
        local.get 1
        i32.const -2147483648
        i32.store
        global.get $GOT.data.internal.__memory_base
        local.set 2
        local.get 1
        local.get 0
        i32.store offset=12
        local.get 1
        local.get 2
        i32.const 1057552
        i32.add
        local.get 0
        i32.load offset=4
        local.get 0
        i32.load offset=8
        local.tee 0
        i32.load8_u offset=8
        local.get 0
        i32.load8_u offset=9
        call $_ZN3std9panicking15panic_with_hook17h874e3943ae58e2b0E
        unreachable
      end
      local.get 1
      local.get 3
      i32.store offset=4
      local.get 1
      local.get 2
      i32.store
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1057524
      i32.add
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.load8_u offset=8
      local.get 0
      i32.load8_u offset=9
      call $_ZN3std9panicking15panic_with_hook17h874e3943ae58e2b0E
      unreachable
    )
    (func $_ZN3std3sys9backtrace4lock17h790784d776800908E (;82;) (type 6) (result i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 0
      global.set $__stack_pointer
      global.get $GOT.data.internal.__memory_base
      i32.const 1058696
      i32.add
      local.tee 1
      i32.load8_u
      local.set 2
      local.get 1
      i32.const 1
      i32.store8
      local.get 0
      local.get 2
      i32.store8 offset=7
      block ;; label = @1
        local.get 2
        i32.const 1
        i32.ne
        br_if 0 (;@1;)
        local.get 0
        i64.const 0
        i64.store offset=20 align=4
        local.get 0
        i64.const 17179869185
        i64.store offset=12 align=4
        local.get 0
        global.get $GOT.data.internal.__memory_base
        local.tee 2
        i32.const 1057224
        i32.add
        i32.store offset=8
        i32.const 0
        local.get 0
        i32.const 7
        i32.add
        global.get $GOT.data.internal._ZN3std4sync4mpmc5waker17current_thread_id5DUMMY28_$u7b$$u7b$closure$u7d$$u7d$3VAL17ha7daa1f1ce7c8643E
        local.get 0
        i32.const 8
        i32.add
        local.get 2
        i32.const 1057232
        i32.add
        call $_ZN4core9panicking13assert_failed17hfa1bda2295d26ecdE
        unreachable
      end
      global.get $GOT.data.internal.__memory_base
      local.set 2
      local.get 0
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 2
      i32.const 1058696
      i32.add
    )
    (func $_ZN3std4sync6poison5mutex14Mutex$LT$T$GT$4lock17h79e1d104d1326323E (;83;) (type 9) (param i32) (result i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 0
      i32.load8_u
      local.set 2
      local.get 0
      i32.const 1
      i32.store8
      local.get 1
      local.get 2
      i32.store8 offset=7
      block ;; label = @1
        local.get 2
        i32.const 1
        i32.ne
        br_if 0 (;@1;)
        local.get 1
        i64.const 0
        i64.store offset=20 align=4
        local.get 1
        i64.const 17179869185
        i64.store offset=12 align=4
        local.get 1
        global.get $GOT.data.internal.__memory_base
        local.tee 0
        i32.const 1057224
        i32.add
        i32.store offset=8
        i32.const 0
        local.get 1
        i32.const 7
        i32.add
        global.get $GOT.data.internal._ZN3std4sync4mpmc5waker17current_thread_id5DUMMY28_$u7b$$u7b$closure$u7d$$u7d$3VAL17ha7daa1f1ce7c8643E
        local.get 1
        i32.const 8
        i32.add
        local.get 0
        i32.const 1057232
        i32.add
        call $_ZN4core9panicking13assert_failed17hfa1bda2295d26ecdE
        unreachable
      end
      local.get 1
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN3std5alloc24default_alloc_error_hook17h0bfe682eedaf7f14E (;84;) (type 1) (param i32 i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        call $_RNvCskdKJRKLKjqM_7___rustc42___rust_alloc_error_handler_should_panic_v2
        i32.const 255
        i32.and
        br_if 0 (;@1;)
        local.get 2
        i64.const 0
        i64.store offset=8
        local.get 2
        i32.const 2
        i32.store offset=28
        local.get 2
        global.get $GOT.data.internal.__memory_base
        i32.const 1057280
        i32.add
        i32.store offset=24
        local.get 2
        i64.const 1
        i64.store offset=36 align=4
        local.get 2
        global.get $GOT.func.internal._ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hb45d88c0adbb2ec4E
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 2
        i32.const 60
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=48
        local.get 2
        local.get 1
        i32.store offset=60
        local.get 2
        local.get 2
        i32.const 48
        i32.add
        i32.store offset=32
        local.get 2
        i32.const 16
        i32.add
        local.get 2
        i32.const 8
        i32.add
        local.get 2
        i32.const 24
        i32.add
        call $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E
        local.get 2
        i32.load offset=20
        local.set 3
        block ;; label = @2
          block ;; label = @3
            local.get 2
            i32.load8_u offset=16
            local.tee 1
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 1
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 3
          i32.load
          local.set 4
          block ;; label = @3
            local.get 3
            i32.const 4
            i32.add
            i32.load
            local.tee 1
            i32.load
            local.tee 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 4
            local.get 5
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 1
            i32.load offset=4
            local.tee 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 4
            local.get 5
            local.get 1
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 3
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        block ;; label = @2
          local.get 2
          i32.load offset=8
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          i32.load offset=12
          local.tee 1
          i32.const -1
          i32.eq
          br_if 0 (;@2;)
          local.get 1
          call $_ZN99_$LT$wasi..imports..wasi..io..streams..OutputStream$u20$as$u20$wasi..imports.._rt..WasmResource$GT$4drop4drop17h7934a0c99c3ab69aE
        end
        local.get 2
        i32.const 64
        i32.add
        global.set $__stack_pointer
        return
      end
      local.get 2
      i32.const 2
      i32.store offset=28
      local.get 2
      i64.const 1
      i64.store offset=36 align=4
      local.get 2
      global.get $GOT.data.internal.__memory_base
      local.tee 3
      i32.const 1057296
      i32.add
      i32.store offset=24
      local.get 2
      local.get 1
      i32.store offset=16
      local.get 2
      global.get $GOT.func.internal._ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17hb45d88c0adbb2ec4E
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 2
      i32.const 16
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=48
      local.get 2
      local.get 2
      i32.const 48
      i32.add
      i32.store offset=32
      local.get 2
      i32.const 24
      i32.add
      local.get 3
      i32.const 1057312
      i32.add
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN3std5panic19get_backtrace_style17h0e693fd7a839e338E (;85;) (type 6) (result i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 0
      global.set $__stack_pointer
      i32.const 3
      local.set 1
      block ;; label = @1
        global.get $GOT.data.internal.__memory_base
        i32.const 1058704
        i32.add
        i32.load8_u
        i32.const -1
        i32.add
        local.tee 2
        i32.const 255
        i32.and
        i32.const 3
        i32.lt_u
        br_if 0 (;@1;)
        local.get 0
        i32.const 4
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1051108
        i32.add
        i32.const 14
        call $_ZN3std3env7_var_os17ha40375b13431cf06E
        i32.const 2
        local.set 2
        block ;; label = @2
          local.get 0
          i32.load offset=4
          local.tee 3
          i32.const -2147483648
          i32.eq
          br_if 0 (;@2;)
          local.get 0
          i32.load offset=8
          local.set 4
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 0
                    i32.load offset=12
                    i32.const -1
                    i32.add
                    br_table 1 (;@6;) 2 (;@5;) 2 (;@5;) 0 (;@7;) 2 (;@5;)
                  end
                  local.get 4
                  i32.load align=1
                  i32.const 1819047270
                  i32.ne
                  br_if 1 (;@5;)
                  i32.const 1
                  local.set 2
                  i32.const 2
                  local.set 1
                  local.get 3
                  br_if 3 (;@3;)
                  br 4 (;@2;)
                end
                local.get 4
                i32.load8_u
                i32.const 48
                i32.eq
                br_if 1 (;@4;)
              end
              i32.const 0
              local.set 2
              i32.const 1
              local.set 1
              local.get 3
              i32.eqz
              br_if 2 (;@2;)
              br 1 (;@3;)
            end
            i32.const 2
            local.set 2
            i32.const 3
            local.set 1
            local.get 3
            i32.eqz
            br_if 1 (;@2;)
          end
          local.get 4
          local.get 3
          i32.const 1
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        global.get $GOT.data.internal.__memory_base
        i32.const 1058704
        i32.add
        local.tee 3
        local.get 3
        i32.load8_u
        local.tee 3
        local.get 1
        local.get 3
        select
        i32.store8
        local.get 3
        i32.eqz
        br_if 0 (;@1;)
        i32.const 3
        local.set 2
        local.get 3
        i32.const 4
        i32.ge_u
        br_if 0 (;@1;)
        i32.const 33619971
        local.get 3
        i32.const 3
        i32.shl
        i32.const 248
        i32.and
        i32.shr_u
        local.set 2
      end
      local.get 0
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 2
    )
    (func $_ZN3std9panicking15panic_with_hook17h874e3943ae58e2b0E (;86;) (type 10) (param i32 i32 i32 i32 i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 112
      i32.sub
      local.tee 5
      global.set $__stack_pointer
      local.get 5
      local.get 1
      i32.store offset=40
      local.get 5
      local.get 0
      i32.store offset=36
      local.get 5
      local.get 2
      i32.store offset=44
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              i32.const 1
              call $_ZN3std9panicking11panic_count8increase17h4e198e157b6d0948E
              i32.const 255
              i32.and
              local.tee 6
              i32.const 2
              i32.eq
              br_if 0 (;@4;)
              local.get 6
              i32.const 1
              i32.and
              i32.eqz
              br_if 1 (;@3;)
              local.get 5
              i32.const 24
              i32.add
              local.get 0
              local.get 1
              i32.load offset=24
              call_indirect (type 1)
              local.get 5
              local.get 5
              i32.load offset=28
              i32.const 0
              local.get 5
              i32.load offset=24
              local.tee 1
              select
              i32.store offset=52
              local.get 5
              local.get 1
              i32.const 1
              local.get 1
              select
              i32.store offset=48
              local.get 5
              i64.const 0
              i64.store offset=56
              local.get 5
              i32.const 3
              i32.store offset=92
              local.get 5
              global.get $GOT.data.internal.__memory_base
              i32.const 1057604
              i32.add
              i32.store offset=88
              local.get 5
              i64.const 2
              i64.store offset=100 align=4
              local.get 5
              global.get $GOT.data.internal.__table_base
              local.tee 1
              i32.const 5
              i32.add
              i64.extend_i32_u
              i64.const 32
              i64.shl
              local.get 5
              i32.const 48
              i32.add
              i64.extend_i32_u
              i64.or
              i64.store offset=72
              local.get 5
              local.get 1
              i32.const 9
              i32.add
              i64.extend_i32_u
              i64.const 32
              i64.shl
              local.get 5
              i32.const 44
              i32.add
              i64.extend_i32_u
              i64.or
              i64.store offset=64
              local.get 5
              local.get 5
              i32.const 64
              i32.add
              i32.store offset=96
              local.get 5
              i32.const 80
              i32.add
              local.get 5
              i32.const 56
              i32.add
              local.get 5
              i32.const 88
              i32.add
              call $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E
              local.get 5
              i32.load8_u offset=80
              local.get 5
              i32.load offset=84
              call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
              local.get 5
              i32.const 56
              i32.add
              call $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E
              br 3 (;@1;)
            end
            global.get $GOT.data.internal._ZN3std9panicking4HOOK17h77b165253788937cE
            i32.load
            local.tee 6
            i32.const -1
            i32.gt_s
            br_if 1 (;@2;)
            local.get 5
            i64.const 0
            i64.store offset=80
            local.get 5
            i32.const 0
            i32.store offset=104
            local.get 5
            i32.const 1
            i32.store offset=92
            local.get 5
            global.get $GOT.data.internal.__memory_base
            i32.const 1057216
            i32.add
            i32.store offset=88
            local.get 5
            i64.const 4
            i64.store offset=96 align=4
            local.get 5
            i32.const 64
            i32.add
            local.get 5
            i32.const 80
            i32.add
            local.get 5
            i32.const 88
            i32.add
            call $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E
            local.get 5
            i32.load8_u offset=64
            local.get 5
            i32.load offset=68
            call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
            local.get 5
            i32.const 80
            i32.add
            call $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E
            br 2 (;@1;)
          end
          local.get 5
          i64.const 0
          i64.store offset=56
          local.get 5
          i32.const 3
          i32.store offset=92
          local.get 5
          global.get $GOT.data.internal.__memory_base
          i32.const 1057580
          i32.add
          i32.store offset=88
          local.get 5
          i64.const 2
          i64.store offset=100 align=4
          local.get 5
          global.get $GOT.data.internal.__table_base
          local.tee 1
          i32.const 10
          i32.add
          i64.extend_i32_u
          i64.const 32
          i64.shl
          local.get 5
          i32.const 36
          i32.add
          i64.extend_i32_u
          i64.or
          i64.store offset=72
          local.get 5
          local.get 1
          i32.const 9
          i32.add
          i64.extend_i32_u
          i64.const 32
          i64.shl
          local.get 5
          i32.const 44
          i32.add
          i64.extend_i32_u
          i64.or
          i64.store offset=64
          local.get 5
          local.get 5
          i32.const 64
          i32.add
          i32.store offset=96
          local.get 5
          i32.const 80
          i32.add
          local.get 5
          i32.const 56
          i32.add
          local.get 5
          i32.const 88
          i32.add
          call $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E
          local.get 5
          i32.load8_u offset=80
          local.get 5
          i32.load offset=84
          call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
          local.get 5
          i32.const 56
          i32.add
          call $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E
          br 1 (;@1;)
        end
        global.get $GOT.data.internal._ZN3std9panicking4HOOK17h77b165253788937cE
        local.tee 7
        local.get 6
        i32.const 1
        i32.add
        i32.store
        block ;; label = @2
          block ;; label = @3
            local.get 7
            i32.load offset=4
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            i32.const 16
            i32.add
            local.get 0
            local.get 1
            i32.load offset=20
            call_indirect (type 1)
            local.get 5
            local.get 4
            i32.store8 offset=101
            local.get 5
            local.get 3
            i32.store8 offset=100
            local.get 5
            local.get 2
            i32.store offset=96
            local.get 5
            local.get 5
            i64.load offset=16
            i64.store offset=88 align=4
            global.get $GOT.data.internal._ZN3std9panicking4HOOK17h77b165253788937cE
            local.tee 2
            i32.load offset=4
            local.get 5
            i32.const 88
            i32.add
            local.get 2
            i32.load offset=8
            i32.load offset=20
            call_indirect (type 1)
            br 1 (;@2;)
          end
          local.get 5
          i32.const 8
          i32.add
          local.get 0
          local.get 1
          i32.load offset=20
          call_indirect (type 1)
          local.get 5
          local.get 4
          i32.store8 offset=101
          local.get 5
          local.get 3
          i32.store8 offset=100
          local.get 5
          local.get 2
          i32.store offset=96
          local.get 5
          local.get 5
          i64.load offset=8
          i64.store offset=88 align=4
          local.get 5
          i32.const 88
          i32.add
          call $_ZN3std9panicking12default_hook17h3ddd230aa78153cfE
        end
        global.get $GOT.data.internal.__memory_base
        i32.const 1058748
        i32.add
        i32.const 0
        i32.store8
        global.get $GOT.data.internal._ZN3std9panicking4HOOK17h77b165253788937cE
        local.tee 2
        local.get 2
        i32.load
        i32.const -1
        i32.add
        i32.store
        block ;; label = @2
          local.get 3
          br_if 0 (;@2;)
          local.get 5
          i64.const 0
          i64.store offset=80
          local.get 5
          i32.const 0
          i32.store offset=104
          local.get 5
          i32.const 1
          i32.store offset=92
          local.get 5
          global.get $GOT.data.internal.__memory_base
          i32.const 1057628
          i32.add
          i32.store offset=88
          local.get 5
          i64.const 4
          i64.store offset=96 align=4
          local.get 5
          i32.const 64
          i32.add
          local.get 5
          i32.const 80
          i32.add
          local.get 5
          i32.const 88
          i32.add
          call $_ZN3std2io5Write9write_fmt17hde1e468edc3f94b1E
          local.get 5
          i32.load8_u offset=64
          local.get 5
          i32.load offset=68
          call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
          local.get 5
          i32.const 80
          i32.add
          call $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E
          br 1 (;@1;)
        end
        local.get 0
        local.get 1
        call $_RNvCskdKJRKLKjqM_7___rustc10rust_panic
        unreachable
      end
      call $_ZN3std7process5abort17h0feca9790f118023E
      unreachable
    )
    (func $_ZN3std9panicking11panic_count8increase17h4e198e157b6d0948E (;87;) (type 9) (param i32) (result i32)
      (local i32 i32)
      global.get $GOT.data.internal._ZN3std9panicking11panic_count18GLOBAL_PANIC_COUNT17h6e1fdb7f2bdc90f2E
      local.tee 1
      local.get 1
      i32.load
      local.tee 2
      i32.const 1
      i32.add
      i32.store
      i32.const 0
      local.set 1
      block ;; label = @1
        local.get 2
        i32.const 0
        i32.lt_s
        br_if 0 (;@1;)
        i32.const 1
        local.set 1
        global.get $GOT.data.internal.__memory_base
        i32.const 1058748
        i32.add
        i32.load8_u
        br_if 0 (;@1;)
        global.get $GOT.data.internal.__memory_base
        local.tee 1
        i32.const 1058748
        i32.add
        local.get 0
        i32.store8
        local.get 1
        i32.const 1058744
        i32.add
        local.tee 1
        local.get 1
        i32.load
        i32.const 1
        i32.add
        i32.store
        i32.const 2
        local.set 1
      end
      local.get 1
    )
    (func $_ZN3std9panicking12default_hook17h3ddd230aa78153cfE (;88;) (type 0) (param i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      i32.const 3
      local.set 2
      block ;; label = @1
        local.get 0
        i32.load8_u offset=13
        br_if 0 (;@1;)
        i32.const 1
        local.set 2
        global.get $GOT.data.internal.__memory_base
        i32.const 1058744
        i32.add
        i32.load
        i32.const 1
        i32.gt_u
        br_if 0 (;@1;)
        call $_ZN3std5panic19get_backtrace_style17h0e693fd7a839e338E
        i32.const 255
        i32.and
        local.set 2
      end
      local.get 1
      local.get 2
      i32.store8 offset=15
      local.get 1
      local.get 0
      i32.load offset=8
      i32.store offset=16
      local.get 1
      local.get 0
      i32.load
      local.get 0
      i32.load offset=4
      call $_ZN3std9panicking14payload_as_str17h3e898ed88b6f7b53E
      local.get 1
      local.get 1
      i64.load
      i64.store offset=20 align=4
      global.get $GOT.data.internal.__memory_base
      i32.const 1058632
      i32.add
      i32.load8_u
      local.set 0
      local.get 1
      local.get 1
      i32.const 15
      i32.add
      i32.store offset=36
      local.get 1
      local.get 1
      i32.const 20
      i32.add
      i32.store offset=32
      local.get 1
      local.get 1
      i32.const 16
      i32.add
      i32.store offset=28
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.eqz
          br_if 0 (;@2;)
          global.get $GOT.data.internal.__memory_base
          local.tee 0
          i32.const 1058632
          i32.add
          i32.const 1
          i32.store8
          local.get 0
          i32.const 1058628
          i32.add
          local.tee 2
          i32.load
          local.set 0
          local.get 2
          i32.const 0
          i32.store
          local.get 0
          i32.eqz
          br_if 0 (;@2;)
          global.get $GOT.data.internal.__memory_base
          local.set 2
          local.get 1
          i32.const 28
          i32.add
          local.get 0
          i32.const 8
          i32.add
          call $_ZN3std4sync6poison5mutex14Mutex$LT$T$GT$4lock17h79e1d104d1326323E
          local.tee 3
          i32.const 4
          i32.add
          local.get 2
          i32.const 1057352
          i32.add
          call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$17h3109a2bdb9b14659E
          local.get 3
          i32.const 0
          i32.store8
          local.get 2
          i32.const 1058632
          i32.add
          i32.const 1
          i32.store8
          local.get 2
          i32.const 1058628
          i32.add
          local.tee 3
          i32.load
          local.set 2
          local.get 3
          local.get 0
          i32.store
          local.get 1
          local.get 2
          i32.store offset=44
          local.get 1
          i32.const 1
          i32.store offset=40
          local.get 2
          i32.eqz
          br_if 1 (;@1;)
          local.get 2
          local.get 2
          i32.load
          local.tee 0
          i32.const -1
          i32.add
          i32.store
          local.get 0
          i32.const 1
          i32.ne
          br_if 1 (;@1;)
          local.get 1
          i32.const 40
          i32.add
          i32.const 4
          i32.add
          call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17hcb8df63f968a2f36E
          br 1 (;@1;)
        end
        local.get 1
        i64.const 0
        i64.store offset=40
        local.get 1
        i32.const 28
        i32.add
        local.get 1
        i32.const 40
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1057392
        i32.add
        call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$17h3109a2bdb9b14659E
        local.get 1
        i32.const 40
        i32.add
        call $_ZN4core3ptr52drop_in_place$LT$std..sys..stdio..wasip2..Stderr$GT$17hdbeece36f653fa90E
      end
      local.get 1
      i32.const 48
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std9panicking14payload_as_str17h3e898ed88b6f7b53E (;89;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32 i64 i64)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      local.get 2
      i32.load offset=12
      local.tee 4
      call_indirect (type 1)
      i32.const 4
      local.set 2
      local.get 1
      local.set 5
      block ;; label = @1
        block ;; label = @2
          local.get 3
          i64.load
          i64.const 7199936582794304877
          i64.xor
          local.get 3
          i64.load offset=8
          i64.const -5076933981314334344
          i64.xor
          i64.or
          i64.eqz
          br_if 0 (;@2;)
          local.get 3
          local.get 1
          local.get 4
          call_indirect (type 1)
          local.get 3
          i64.load offset=8
          local.set 6
          local.get 3
          i64.load
          local.set 7
          global.get $GOT.data.internal.__memory_base
          local.set 2
          block ;; label = @3
            local.get 7
            i64.const 5006904218026651033
            i64.xor
            local.get 6
            i64.const -5595636112403832390
            i64.xor
            i64.or
            i64.const 0
            i64.eq
            br_if 0 (;@3;)
            local.get 2
            i32.const 1051296
            i32.add
            local.set 1
            i32.const 12
            local.set 2
            br 2 (;@1;)
          end
          local.get 1
          i32.const 4
          i32.add
          local.set 5
          i32.const 8
          local.set 2
        end
        local.get 1
        local.get 2
        i32.add
        i32.load
        local.set 2
        local.get 5
        i32.load
        local.set 1
      end
      local.get 0
      local.get 2
      i32.store offset=4
      local.get 0
      local.get 1
      i32.store
      local.get 3
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$17h3109a2bdb9b14659E (;90;) (type 3) (param i32 i32 i32)
      (local i32 i32 i64 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      call $_ZN3std3sys9backtrace4lock17h790784d776800908E
      local.set 4
      local.get 0
      i64.load align=4
      local.set 5
      local.get 3
      local.get 2
      i32.store offset=20
      local.get 3
      local.get 1
      i32.store offset=16
      local.get 3
      local.get 5
      i64.store offset=8 align=4
      block ;; label = @1
        block ;; label = @2
          global.get $GOT.data.internal._ZN3std6thread7current7CURRENT17hbfa7d7ebebd0919dE
          i32.load
          local.tee 6
          i32.const 2
          i32.gt_u
          br_if 0 (;@2;)
          global.get $GOT.data.internal.__memory_base
          i32.const 1058712
          i32.add
          i64.load
          local.set 5
          global.get $GOT.data.internal._ZN3std6thread7current2id2ID17hf355b94f07b7e26bE
          local.set 6
          block ;; label = @3
            block ;; label = @4
              local.get 5
              i64.eqz
              br_if 0 (;@4;)
              local.get 6
              i64.load
              local.get 5
              i64.eq
              br_if 1 (;@3;)
            end
            local.get 3
            i32.const 8
            i32.add
            i32.const 0
            local.get 3
            call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17h95ce1134a19b47bfE
            br 2 (;@1;)
          end
          local.get 3
          i32.const 8
          i32.add
          global.get $GOT.data.internal.__memory_base
          i32.const 1051122
          i32.add
          i32.const 4
          call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17h95ce1134a19b47bfE
          br 1 (;@1;)
        end
        block ;; label = @2
          local.get 6
          i32.load offset=8
          local.tee 7
          i32.eqz
          br_if 0 (;@2;)
          local.get 3
          i32.const 8
          i32.add
          local.get 7
          local.get 6
          i32.const 12
          i32.add
          i32.load
          i32.const -1
          i32.add
          call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17h95ce1134a19b47bfE
          br 1 (;@1;)
        end
        global.get $GOT.data.internal.__memory_base
        local.set 7
        block ;; label = @2
          local.get 6
          i64.load
          local.get 7
          i32.const 1058712
          i32.add
          i64.load
          i64.ne
          br_if 0 (;@2;)
          local.get 3
          i32.const 8
          i32.add
          global.get $GOT.data.internal.__memory_base
          i32.const 1051122
          i32.add
          i32.const 4
          call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17h95ce1134a19b47bfE
          br 1 (;@1;)
        end
        local.get 3
        i32.const 8
        i32.add
        i32.const 0
        local.get 3
        call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17h95ce1134a19b47bfE
      end
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 0
              i32.load offset=8
              i32.load8_u
              br_table 0 (;@4;) 1 (;@3;) 2 (;@2;) 3 (;@1;) 0 (;@4;)
            end
            local.get 3
            i32.const 8
            i32.add
            local.get 1
            local.get 2
            i32.load offset=36
            i32.const 0
            call $_ZN3std3sys9backtrace13BacktraceLock5print17h69d540a3f4eb0369E
            local.get 3
            i32.load8_u offset=8
            local.get 3
            i32.load offset=12
            call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
            br 2 (;@1;)
          end
          local.get 3
          i32.const 8
          i32.add
          local.get 1
          local.get 2
          i32.load offset=36
          i32.const 1
          call $_ZN3std3sys9backtrace13BacktraceLock5print17h69d540a3f4eb0369E
          local.get 3
          i32.load8_u offset=8
          local.get 3
          i32.load offset=12
          call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
          br 1 (;@1;)
        end
        global.get $GOT.data.internal.__memory_base
        i32.const 1057432
        i32.add
        local.tee 0
        i32.load8_u
        local.set 6
        local.get 0
        i32.const 0
        i32.store8
        local.get 6
        i32.eqz
        br_if 0 (;@1;)
        local.get 3
        i32.const 0
        i32.store offset=24
        local.get 3
        i32.const 1
        i32.store offset=12
        local.get 3
        global.get $GOT.data.internal.__memory_base
        i32.const 1057436
        i32.add
        i32.store offset=8
        local.get 3
        i64.const 4
        i64.store offset=16 align=4
        local.get 3
        local.get 1
        local.get 3
        i32.const 8
        i32.add
        local.get 2
        i32.load offset=36
        call_indirect (type 3)
        local.get 3
        i32.load8_u
        local.get 3
        i32.load offset=4
        call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h69d4c735ad4535fbE
      end
      local.get 4
      i32.const 0
      i32.store8
      local.get 3
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17h95ce1134a19b47bfE (;91;) (type 3) (param i32 i32 i32)
      (local i32 i64 i64 i64 i64 i32 i32)
      global.get $__stack_pointer
      i32.const 608
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 2
      i32.const 9
      local.get 1
      select
      i32.store offset=4
      local.get 3
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1051259
      i32.add
      local.get 1
      select
      i32.store
      block ;; label = @1
        block ;; label = @2
          global.get $GOT.data.internal._ZN3std6thread7current2id2ID17hf355b94f07b7e26bE
          i64.load
          local.tee 4
          i64.const 0
          i64.ne
          br_if 0 (;@2;)
          global.get $GOT.data.internal.__memory_base
          i32.const 1058736
          i32.add
          i64.load
          local.set 5
          loop ;; label = @3
            local.get 5
            i64.const -1
            i64.eq
            br_if 2 (;@1;)
            global.get $GOT.data.internal.__memory_base
            i32.const 1058736
            i32.add
            local.tee 1
            local.get 5
            i64.const 1
            i64.add
            local.tee 4
            local.get 1
            i64.load
            local.tee 6
            local.get 6
            local.get 5
            i64.eq
            local.tee 1
            select
            i64.store
            local.get 6
            local.set 5
            local.get 1
            i32.eqz
            br_if 0 (;@3;)
          end
          global.get $GOT.data.internal._ZN3std6thread7current2id2ID17hf355b94f07b7e26bE
          local.get 4
          i64.store
        end
        local.get 3
        local.get 4
        i64.store offset=8
        block ;; label = @2
          i32.const 512
          i32.eqz
          br_if 0 (;@2;)
          local.get 3
          i32.const 16
          i32.add
          i32.const 0
          i32.const 512
          memory.fill
        end
        local.get 3
        i64.const 0
        i64.store offset=536
        local.get 3
        i32.const 512
        i32.store offset=532
        local.get 3
        local.get 3
        i32.const 16
        i32.add
        i32.store offset=528
        local.get 0
        i64.load32_u
        local.set 5
        local.get 0
        i64.load32_u offset=4
        local.set 6
        local.get 3
        i32.const 5
        i32.store offset=556
        local.get 3
        global.get $GOT.data.internal.__memory_base
        i32.const 1057460
        i32.add
        i32.store offset=552
        local.get 3
        i64.const 4
        i64.store offset=564 align=4
        local.get 3
        local.get 6
        global.get $GOT.data.internal.__table_base
        local.tee 1
        i32.const 5
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.tee 4
        i64.or
        local.tee 6
        i64.store offset=600
        local.get 3
        local.get 5
        local.get 1
        i32.const 9
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        i64.or
        local.tee 5
        i64.store offset=592
        local.get 3
        global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h075952d02013a81eE
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 3
        i32.const 8
        i32.add
        i64.extend_i32_u
        i64.or
        local.tee 7
        i64.store offset=584
        local.get 3
        local.get 4
        local.get 3
        i64.extend_i32_u
        i64.or
        local.tee 4
        i64.store offset=576
        local.get 3
        local.get 3
        i32.const 576
        i32.add
        i32.store offset=560
        local.get 3
        i32.const 544
        i32.add
        local.get 3
        i32.const 528
        i32.add
        local.get 3
        i32.const 552
        i32.add
        call $_ZN3std2io5Write9write_fmt17h995e0d97b2ee8b94E
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 3
              i32.load8_u offset=544
              local.tee 1
              i32.const 4
              i32.ne
              br_if 0 (;@4;)
              local.get 3
              i32.load offset=536
              local.tee 1
              i32.const 513
              i32.lt_u
              br_if 1 (;@3;)
              i32.const 0
              local.get 1
              i32.const 512
              global.get $GOT.data.internal.__memory_base
              i32.const 1057444
              i32.add
              call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
              unreachable
            end
            block ;; label = @4
              local.get 1
              i32.const 3
              i32.lt_u
              br_if 0 (;@4;)
              local.get 3
              i32.load offset=548
              local.tee 1
              i32.load
              local.set 8
              block ;; label = @5
                local.get 1
                i32.const 4
                i32.add
                i32.load
                local.tee 2
                i32.load
                local.tee 9
                i32.eqz
                br_if 0 (;@5;)
                local.get 8
                local.get 9
                call_indirect (type 0)
              end
              block ;; label = @5
                local.get 2
                i32.load offset=4
                local.tee 9
                i32.eqz
                br_if 0 (;@5;)
                local.get 8
                local.get 9
                local.get 2
                i32.load offset=8
                call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
              end
              local.get 1
              i32.const 12
              i32.const 4
              call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
            end
            local.get 0
            i32.load offset=12
            i32.const 36
            i32.add
            i32.load
            local.set 1
            local.get 0
            i32.load offset=8
            local.set 0
            local.get 3
            i32.const 5
            i32.store offset=556
            local.get 3
            global.get $GOT.data.internal.__memory_base
            i32.const 1057460
            i32.add
            i32.store offset=552
            local.get 3
            i64.const 4
            i64.store offset=564 align=4
            local.get 3
            local.get 6
            i64.store offset=600
            local.get 3
            local.get 5
            i64.store offset=592
            local.get 3
            local.get 7
            i64.store offset=584
            local.get 3
            local.get 4
            i64.store offset=576
            local.get 3
            local.get 3
            i32.const 576
            i32.add
            i32.store offset=560
            local.get 3
            i32.const 544
            i32.add
            local.get 0
            local.get 3
            i32.const 552
            i32.add
            local.get 1
            call_indirect (type 3)
            local.get 3
            i32.load offset=548
            local.set 0
            block ;; label = @4
              local.get 3
              i32.load8_u offset=544
              local.tee 1
              i32.const 4
              i32.gt_u
              br_if 0 (;@4;)
              local.get 1
              i32.const 3
              i32.ne
              br_if 2 (;@2;)
            end
            local.get 0
            i32.load
            local.set 2
            block ;; label = @4
              local.get 0
              i32.const 4
              i32.add
              i32.load
              local.tee 1
              i32.load
              local.tee 8
              i32.eqz
              br_if 0 (;@4;)
              local.get 2
              local.get 8
              call_indirect (type 0)
            end
            block ;; label = @4
              local.get 1
              i32.load offset=4
              local.tee 8
              i32.eqz
              br_if 0 (;@4;)
              local.get 2
              local.get 8
              local.get 1
              i32.load offset=8
              call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
            end
            local.get 0
            i32.const 12
            i32.const 4
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
            br 1 (;@2;)
          end
          local.get 3
          i32.const 576
          i32.add
          local.get 0
          i32.load offset=8
          local.get 3
          i32.const 16
          i32.add
          local.get 1
          local.get 0
          i32.load offset=12
          i32.load offset=28
          call_indirect (type 5)
          local.get 3
          i32.load offset=580
          local.set 0
          block ;; label = @3
            local.get 3
            i32.load8_u offset=576
            local.tee 1
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 1
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 0
          i32.load
          local.set 2
          block ;; label = @3
            local.get 0
            i32.const 4
            i32.add
            i32.load
            local.tee 1
            i32.load
            local.tee 8
            i32.eqz
            br_if 0 (;@3;)
            local.get 2
            local.get 8
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 1
            i32.load offset=4
            local.tee 8
            i32.eqz
            br_if 0 (;@3;)
            local.get 2
            local.get 8
            local.get 1
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 0
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 3
        i32.const 608
        i32.add
        global.set $__stack_pointer
        return
      end
      call $_ZN3std6thread8ThreadId3new9exhausted17h3e67a518470126f4E
      unreachable
    )
    (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h785dd27ec708a479E (;92;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i64)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 1
      i32.load offset=4
      local.set 3
      local.get 1
      i32.load
      local.set 4
      local.get 2
      local.get 0
      i32.load
      local.tee 1
      i64.load align=4
      i64.store offset=8 align=4
      local.get 2
      global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 5
      local.get 1
      i32.const 12
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 2
      local.get 5
      local.get 1
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=24
      local.get 2
      global.get $GOT.data.internal.__table_base
      i32.const 5
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 2
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=16
      local.get 2
      i64.const 3
      i64.store offset=52 align=4
      local.get 2
      i32.const 3
      i32.store offset=44
      local.get 2
      global.get $GOT.data.internal.__memory_base
      i32.const 1057832
      i32.add
      i32.store offset=40
      local.get 2
      local.get 2
      i32.const 16
      i32.add
      i32.store offset=48
      local.get 4
      local.get 3
      local.get 2
      i32.const 40
      i32.add
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
      local.set 1
      local.get 2
      i32.const 64
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN52_$LT$$RF$mut$u20$T$u20$as$u20$core..fmt..Display$GT$3fmt17h7da13e6d971e0f2cE (;93;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load
      local.get 1
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 2)
    )
    (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h1c40dc1697f02d7fE (;94;) (type 2) (param i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.load
          local.tee 0
          i32.load8_u
          i32.const 1
          i32.ne
          br_if 0 (;@2;)
          local.get 2
          local.get 0
          i32.const 1
          i32.add
          i32.store offset=12
          local.get 1
          global.get $GOT.data.internal.__memory_base
          local.tee 0
          i32.const 1051545
          i32.add
          i32.const 4
          local.get 2
          i32.const 12
          i32.add
          local.get 0
          i32.const 1057636
          i32.add
          call $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h0b6484f914d461a8E
          local.set 0
          br 1 (;@1;)
        end
        local.get 1
        global.get $GOT.data.internal.__memory_base
        i32.const 1051541
        i32.add
        i32.const 4
        call $_ZN4core3fmt9Formatter9write_str17h2218e50d8c415133E
        local.set 0
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb0fe84bda0291ac1E (;95;) (type 2) (param i32 i32) (result i32)
      (local i32)
      local.get 0
      i32.load
      local.set 0
      block ;; label = @1
        local.get 1
        i32.load offset=8
        local.tee 2
        i32.const 33554432
        i32.and
        br_if 0 (;@1;)
        block ;; label = @2
          local.get 2
          i32.const 67108864
          i32.and
          br_if 0 (;@2;)
          local.get 0
          local.get 1
          call $_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17hf9cdf4ac9c5498a7E
          return
        end
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u8$GT$3fmt17h1a44585e24c514deE
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u8$GT$3fmt17h063a5a81464c7db2E
    )
    (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hc9b8f81248cf3579E (;96;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load
      local.get 1
      call $_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17h20cb72827ef30f53E
    )
    (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17h4bff67059979ac39E (;97;) (type 2) (param i32 i32) (result i32)
      (local i32)
      block ;; label = @1
        local.get 1
        i32.load offset=8
        local.tee 2
        i32.const 33554432
        i32.and
        br_if 0 (;@1;)
        block ;; label = @2
          local.get 2
          i32.const 67108864
          i32.and
          br_if 0 (;@2;)
          local.get 0
          local.get 1
          call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
          return
        end
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h358537a2663ec30eE
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hebbdd05705cf5268E
    )
    (func $_ZN4core3fmt5Write10write_char17h1d334f24580e619eE (;98;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 0
      i32.store offset=12
      block ;; label = @1
        block ;; label = @2
          local.get 1
          i32.const 128
          i32.lt_u
          br_if 0 (;@2;)
          local.get 1
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 3
          local.get 1
          i32.const 6
          i32.shr_u
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 2048
            i32.ge_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=13
            local.get 2
            local.get 4
            i32.const 192
            i32.or
            i32.store8 offset=12
            i32.const 2
            local.set 1
            br 2 (;@1;)
          end
          local.get 1
          i32.const 12
          i32.shr_u
          local.set 5
          local.get 4
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 65535
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=14
            local.get 2
            local.get 4
            i32.store8 offset=13
            local.get 2
            local.get 5
            i32.const 224
            i32.or
            i32.store8 offset=12
            i32.const 3
            local.set 1
            br 2 (;@1;)
          end
          local.get 2
          local.get 3
          i32.store8 offset=15
          local.get 2
          local.get 4
          i32.store8 offset=14
          local.get 2
          local.get 5
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          i32.store8 offset=13
          local.get 2
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const -16
          i32.or
          i32.store8 offset=12
          i32.const 4
          local.set 1
          br 1 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=12
        i32.const 1
        local.set 1
      end
      block ;; label = @1
        local.get 1
        local.get 0
        i32.load offset=8
        local.tee 0
        i32.load
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.sub
        i32.le_u
        br_if 0 (;@1;)
        local.get 0
        local.get 3
        local.get 1
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
        local.get 0
        i32.load offset=8
        local.set 3
      end
      block ;; label = @1
        local.get 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.get 3
        i32.add
        local.get 2
        i32.const 12
        i32.add
        local.get 1
        memory.copy
      end
      local.get 0
      local.get 3
      local.get 1
      i32.add
      i32.store offset=8
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      i32.const 0
    )
    (func $_ZN4core3fmt5Write10write_char17h797290c63af11536E (;99;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 0
      i32.store offset=4
      block ;; label = @1
        block ;; label = @2
          local.get 1
          i32.const 128
          i32.lt_u
          br_if 0 (;@2;)
          local.get 1
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 3
          local.get 1
          i32.const 6
          i32.shr_u
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 2048
            i32.ge_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=5
            local.get 2
            local.get 4
            i32.const 192
            i32.or
            i32.store8 offset=4
            i32.const 2
            local.set 1
            br 2 (;@1;)
          end
          local.get 1
          i32.const 12
          i32.shr_u
          local.set 5
          local.get 4
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 65535
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=6
            local.get 2
            local.get 4
            i32.store8 offset=5
            local.get 2
            local.get 5
            i32.const 224
            i32.or
            i32.store8 offset=4
            i32.const 3
            local.set 1
            br 2 (;@1;)
          end
          local.get 2
          local.get 3
          i32.store8 offset=7
          local.get 2
          local.get 4
          i32.store8 offset=6
          local.get 2
          local.get 5
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          i32.store8 offset=5
          local.get 2
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const -16
          i32.or
          i32.store8 offset=4
          i32.const 4
          local.set 1
          br 1 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=4
        i32.const 1
        local.set 1
      end
      local.get 2
      i32.const 8
      i32.add
      local.get 0
      i32.load offset=8
      local.get 2
      i32.const 4
      i32.add
      local.get 1
      call $_ZN3std2io5Write9write_all17h6cce4afb022c1e6bE
      block ;; label = @1
        local.get 2
        i32.load8_u offset=8
        local.tee 1
        i32.const 4
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.set 4
        block ;; label = @2
          block ;; label = @3
            local.get 0
            i32.load8_u
            local.tee 3
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 3
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 4
          i32.load
          local.set 5
          block ;; label = @3
            local.get 4
            i32.const 4
            i32.add
            i32.load
            local.tee 3
            i32.load
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 3
            i32.load offset=4
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            local.get 3
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 4
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 0
        local.get 2
        i64.load offset=8
        i64.store align=4
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 1
      i32.const 4
      i32.ne
    )
    (func $_ZN4core3fmt5Write10write_char17h803f709043db8c93E (;100;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i64 i32 i64)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 0
      i32.store offset=12
      block ;; label = @1
        block ;; label = @2
          local.get 1
          i32.const 128
          i32.lt_u
          br_if 0 (;@2;)
          local.get 1
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 3
          local.get 1
          i32.const 6
          i32.shr_u
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 2048
            i32.ge_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=13
            local.get 2
            local.get 4
            i32.const 192
            i32.or
            i32.store8 offset=12
            i32.const 2
            local.set 1
            br 2 (;@1;)
          end
          local.get 1
          i32.const 12
          i32.shr_u
          local.set 5
          local.get 4
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 65535
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=14
            local.get 2
            local.get 4
            i32.store8 offset=13
            local.get 2
            local.get 5
            i32.const 224
            i32.or
            i32.store8 offset=12
            i32.const 3
            local.set 1
            br 2 (;@1;)
          end
          local.get 2
          local.get 3
          i32.store8 offset=15
          local.get 2
          local.get 4
          i32.store8 offset=14
          local.get 2
          local.get 5
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          i32.store8 offset=13
          local.get 2
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const -16
          i32.or
          i32.store8 offset=12
          i32.const 4
          local.set 1
          br 1 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=12
        i32.const 1
        local.set 1
      end
      i32.const 0
      local.set 6
      block ;; label = @1
        i32.const 0
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.load offset=4
        local.tee 5
        local.get 3
        i64.load offset=8
        local.tee 7
        i64.const 4294967295
        local.get 7
        i64.const 4294967295
        i64.lt_u
        select
        i32.wrap_i64
        i32.sub
        local.tee 4
        local.get 4
        local.get 5
        i32.gt_u
        select
        local.tee 4
        local.get 1
        local.get 4
        local.get 1
        i32.lt_u
        select
        local.tee 8
        i32.eqz
        br_if 0 (;@1;)
        local.get 3
        i32.load
        local.get 7
        local.get 5
        i64.extend_i32_u
        local.tee 9
        local.get 7
        local.get 9
        i64.lt_u
        select
        i32.wrap_i64
        i32.add
        local.get 2
        i32.const 12
        i32.add
        local.get 8
        memory.copy
      end
      local.get 3
      local.get 7
      local.get 8
      i64.extend_i32_u
      i64.add
      i64.store offset=8
      block ;; label = @1
        local.get 4
        local.get 1
        i32.ge_u
        br_if 0 (;@1;)
        global.get $GOT.data.internal.__memory_base
        i32.const 1056944
        i32.add
        i64.load
        local.tee 7
        i64.const 255
        i64.and
        i64.const 4
        i64.eq
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.set 3
        block ;; label = @2
          block ;; label = @3
            local.get 0
            i32.load8_u
            local.tee 1
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 1
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 3
          i32.load
          local.set 4
          block ;; label = @3
            local.get 3
            i32.const 4
            i32.add
            i32.load
            local.tee 1
            i32.load
            local.tee 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 4
            local.get 5
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 1
            i32.load offset=4
            local.tee 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 4
            local.get 5
            local.get 1
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 3
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 0
        local.get 7
        i64.store align=4
        i32.const 1
        local.set 6
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 6
    )
    (func $_ZN4core3fmt5Write10write_char17he0a925f15d03e732E (;101;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 0
      i32.store offset=4
      block ;; label = @1
        block ;; label = @2
          local.get 1
          i32.const 128
          i32.lt_u
          br_if 0 (;@2;)
          local.get 1
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 3
          local.get 1
          i32.const 6
          i32.shr_u
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 2048
            i32.ge_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=5
            local.get 2
            local.get 4
            i32.const 192
            i32.or
            i32.store8 offset=4
            i32.const 2
            local.set 1
            br 2 (;@1;)
          end
          local.get 1
          i32.const 12
          i32.shr_u
          local.set 5
          local.get 4
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 4
          block ;; label = @3
            local.get 1
            i32.const 65535
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            i32.store8 offset=6
            local.get 2
            local.get 4
            i32.store8 offset=5
            local.get 2
            local.get 5
            i32.const 224
            i32.or
            i32.store8 offset=4
            i32.const 3
            local.set 1
            br 2 (;@1;)
          end
          local.get 2
          local.get 3
          i32.store8 offset=7
          local.get 2
          local.get 4
          i32.store8 offset=6
          local.get 2
          local.get 5
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          i32.store8 offset=5
          local.get 2
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const -16
          i32.or
          i32.store8 offset=4
          i32.const 4
          local.set 1
          br 1 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=4
        i32.const 1
        local.set 1
      end
      local.get 2
      i32.const 8
      i32.add
      local.get 0
      i32.load offset=8
      local.get 2
      i32.const 4
      i32.add
      local.get 1
      call $_ZN61_$LT$std..io..stdio..StdoutLock$u20$as$u20$std..io..Write$GT$9write_all17h24094c8b22ddcbc1E
      block ;; label = @1
        local.get 2
        i32.load8_u offset=8
        local.tee 1
        i32.const 4
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.set 4
        block ;; label = @2
          block ;; label = @3
            local.get 0
            i32.load8_u
            local.tee 3
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 3
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 4
          i32.load
          local.set 5
          block ;; label = @3
            local.get 4
            i32.const 4
            i32.add
            i32.load
            local.tee 3
            i32.load
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 3
            i32.load offset=4
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            local.get 3
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 4
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 0
        local.get 2
        i64.load offset=8
        i64.store align=4
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 1
      i32.const 4
      i32.ne
    )
    (func $_ZN61_$LT$std..io..stdio..StdoutLock$u20$as$u20$std..io..Write$GT$9write_all17h24094c8b22ddcbc1E (;102;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.load
            local.tee 1
            i32.load offset=16
            br_if 0 (;@3;)
            local.get 1
            i32.const -1
            i32.store offset=16
            local.get 4
            i32.const 10
            local.get 2
            local.get 3
            call $_ZN4core5slice6memchr7memrchr17hdc45ebff6cde5bbdE
            local.get 1
            i32.const 20
            i32.add
            local.set 5
            block ;; label = @4
              block ;; label = @5
                local.get 4
                i32.load
                i32.const 1
                i32.and
                i32.eqz
                br_if 0 (;@5;)
                local.get 3
                local.get 4
                i32.load offset=4
                i32.const 1
                i32.add
                local.tee 6
                i32.ge_u
                br_if 1 (;@4;)
                local.get 4
                i32.const 0
                i32.store offset=24
                local.get 4
                i32.const 1
                i32.store offset=12
                local.get 4
                i64.const 4
                i64.store offset=16 align=4
                local.get 4
                global.get $GOT.data.internal.__memory_base
                local.tee 1
                i32.const 1056968
                i32.add
                i32.store offset=8
                local.get 4
                i32.const 8
                i32.add
                local.get 1
                i32.const 1057888
                i32.add
                call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
                unreachable
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 1
                  i32.load offset=28
                  local.tee 6
                  br_if 0 (;@6;)
                  i32.const 0
                  local.set 6
                  br 1 (;@5;)
                end
                local.get 1
                i32.load offset=24
                local.get 6
                i32.add
                i32.const -1
                i32.add
                i32.load8_u
                i32.const 10
                i32.ne
                br_if 0 (;@5;)
                local.get 4
                i32.const 8
                i32.add
                local.get 5
                call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$9flush_buf17h7ff4363ebaf976d3E
                local.get 4
                i32.load8_u offset=8
                i32.const 4
                i32.ne
                br_if 3 (;@2;)
                local.get 1
                i32.load offset=28
                local.set 6
              end
              block ;; label = @5
                local.get 3
                local.get 5
                i32.load
                local.get 6
                i32.sub
                i32.lt_u
                br_if 0 (;@5;)
                local.get 0
                local.get 5
                local.get 2
                local.get 3
                call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17h4add61127650d4bcE
                br 4 (;@1;)
              end
              block ;; label = @5
                local.get 3
                i32.eqz
                br_if 0 (;@5;)
                local.get 1
                i32.load offset=24
                local.get 6
                i32.add
                local.get 2
                local.get 3
                memory.copy
              end
              local.get 0
              i32.const 4
              i32.store8
              local.get 1
              local.get 6
              local.get 3
              i32.add
              i32.store offset=28
              br 3 (;@1;)
            end
            block ;; label = @4
              block ;; label = @5
                local.get 1
                i32.load offset=28
                local.tee 7
                br_if 0 (;@5;)
                local.get 4
                i32.const 8
                i32.add
                local.get 1
                i32.const 36
                i32.add
                local.get 2
                local.get 6
                call $_ZN3std2io5Write9write_all17h616ed9cf9247be18E
                local.get 4
                i32.load8_u offset=8
                i32.const 4
                i32.eq
                br_if 1 (;@4;)
                local.get 0
                local.get 4
                i64.load offset=8
                i64.store align=4
                br 4 (;@1;)
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 6
                  local.get 5
                  i32.load
                  local.get 7
                  i32.sub
                  i32.lt_u
                  br_if 0 (;@6;)
                  local.get 4
                  i32.const 8
                  i32.add
                  local.get 5
                  local.get 2
                  local.get 6
                  call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17h4add61127650d4bcE
                  local.get 4
                  i32.load8_u offset=8
                  i32.const 4
                  i32.eq
                  br_if 1 (;@5;)
                  local.get 0
                  local.get 4
                  i64.load offset=8
                  i64.store align=4
                  br 5 (;@1;)
                end
                block ;; label = @6
                  local.get 6
                  i32.eqz
                  br_if 0 (;@6;)
                  local.get 1
                  i32.load offset=24
                  local.get 7
                  i32.add
                  local.get 2
                  local.get 6
                  memory.copy
                end
                local.get 1
                local.get 7
                local.get 6
                i32.add
                i32.store offset=28
              end
              local.get 4
              i32.const 8
              i32.add
              local.get 5
              call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$9flush_buf17h7ff4363ebaf976d3E
              local.get 4
              i32.load8_u offset=8
              i32.const 4
              i32.eq
              br_if 0 (;@4;)
              local.get 0
              local.get 4
              i64.load offset=8
              i64.store align=4
              br 3 (;@1;)
            end
            local.get 2
            local.get 6
            i32.add
            local.set 7
            block ;; label = @4
              local.get 3
              local.get 6
              i32.sub
              local.tee 3
              local.get 1
              i32.load offset=20
              local.get 1
              i32.load offset=28
              local.tee 2
              i32.sub
              i32.lt_u
              br_if 0 (;@4;)
              local.get 0
              local.get 5
              local.get 7
              local.get 3
              call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17h4add61127650d4bcE
              br 3 (;@1;)
            end
            block ;; label = @4
              local.get 3
              i32.eqz
              br_if 0 (;@4;)
              local.get 1
              i32.load offset=24
              local.get 2
              i32.add
              local.get 7
              local.get 3
              memory.copy
            end
            local.get 0
            i32.const 4
            i32.store8
            local.get 1
            local.get 2
            local.get 3
            i32.add
            i32.store offset=28
            br 2 (;@1;)
          end
          global.get $GOT.data.internal.__memory_base
          i32.const 1057784
          i32.add
          call $_ZN4core4cell22panic_already_borrowed17hea6cbdb897553084E
          unreachable
        end
        local.get 0
        local.get 4
        i64.load offset=8
        i64.store align=4
      end
      local.get 1
      local.get 1
      i32.load offset=16
      i32.const 1
      i32.add
      i32.store offset=16
      local.get 4
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN4core3fmt5Write9write_fmt17h0ea7a0e97e97c86dE (;103;) (type 2) (param i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 8
      i32.add
      i32.const 16
      i32.add
      local.get 1
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 1
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 1
      i64.load align=4
      i64.store offset=8
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1056812
      i32.add
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
      local.set 1
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN4core3fmt5Write9write_fmt17h4b44b2f1f6740e2cE (;104;) (type 2) (param i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 8
      i32.add
      i32.const 16
      i32.add
      local.get 1
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 1
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 1
      i64.load align=4
      i64.store offset=8
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1056860
      i32.add
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
      local.set 1
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN4core3fmt5Write9write_fmt17hbb042da8f8664a0dE (;105;) (type 2) (param i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 8
      i32.add
      i32.const 16
      i32.add
      local.get 1
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 1
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 1
      i64.load align=4
      i64.store offset=8
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1057500
      i32.add
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
      local.set 1
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN4core3fmt5Write9write_fmt17hdb5aea470d4ca65aE (;106;) (type 2) (param i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 8
      i32.add
      i32.const 16
      i32.add
      local.get 1
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 1
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 1
      i64.load align=4
      i64.store offset=8
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1056908
      i32.add
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
      local.set 1
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN4core3fmt5Write9write_fmt17hf77d4e0ae6399248E (;107;) (type 2) (param i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 8
      i32.add
      i32.const 16
      i32.add
      local.get 1
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 1
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 1
      i64.load align=4
      i64.store offset=8
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1056884
      i32.add
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
      local.set 1
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN4core3ptr119drop_in_place$LT$std..io..default_write_fmt..Adapter$LT$std..io..cursor..Cursor$LT$$RF$mut$u20$$u5b$u8$u5d$$GT$$GT$$GT$17hd074874d6972ccb4E (;108;) (type 0) (param i32)
      (local i32 i32 i32)
      local.get 0
      i32.load offset=4
      local.set 1
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.load8_u
          local.tee 0
          i32.const 4
          i32.gt_u
          br_if 0 (;@2;)
          local.get 0
          i32.const 3
          i32.ne
          br_if 1 (;@1;)
        end
        local.get 1
        i32.load
        local.set 2
        block ;; label = @2
          local.get 1
          i32.const 4
          i32.add
          i32.load
          local.tee 0
          i32.load
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 3
          call_indirect (type 0)
        end
        block ;; label = @2
          local.get 0
          i32.load offset=4
          local.tee 3
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 3
          local.get 0
          i32.load offset=8
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 1
        i32.const 12
        i32.const 4
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
    )
    (func $_ZN4core3ptr238drop_in_place$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$GT$17h131a71a08b780a40E (;109;) (type 0) (param i32)
      (local i32)
      block ;; label = @1
        local.get 0
        i32.load
        local.tee 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.get 1
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
    )
    (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17haf7718004385d68dE (;110;) (type 0) (param i32)
      (local i32)
      block ;; label = @1
        local.get 0
        i32.load
        local.tee 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.get 1
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
    )
    (func $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17he97abafe01721ee9E (;111;) (type 0) (param i32)
      (local i32)
      block ;; label = @1
        local.get 0
        i32.load
        local.tee 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.get 1
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
    )
    (func $_ZN4core3ptr71drop_in_place$LT$std..panicking..panic_handler..FormatStringPayload$GT$17hadf49e1afc862199E (;112;) (type 0) (param i32)
      (local i32)
      block ;; label = @1
        local.get 0
        i32.load
        local.tee 1
        i32.const -2147483648
        i32.or
        i32.const -2147483648
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.get 1
        i32.const 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
      end
    )
    (func $_ZN4core5error5Error11description17h22e11b214aeeeb04E (;113;) (type 1) (param i32 i32)
      local.get 0
      i32.const 40
      i32.store offset=4
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1051441
      i32.add
      i32.store
    )
    (func $_ZN4core5error5Error5cause17hb8017ed64a669664E (;114;) (type 1) (param i32 i32)
      local.get 0
      i32.const 0
      i32.store
    )
    (func $_ZN4core5error5Error7provide17hbec58b8c086da44eE (;115;) (type 3) (param i32 i32 i32))
    (func $_ZN4core5error5Error7type_id17hcfdc7eff7fa59173E (;116;) (type 1) (param i32 i32)
      (local i32)
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1051484
      i32.add
      local.tee 2
      i64.load align=4
      i64.store align=4
      local.get 0
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i64.load align=4
      i64.store align=4
    )
    (func $_ZN4core5panic12PanicPayload6as_str17h5c36130b677cff8bE (;117;) (type 1) (param i32 i32)
      local.get 0
      i32.const 0
      i32.store
    )
    (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h6821774e0abcbbf0E (;118;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32)
      local.get 0
      i32.load offset=8
      local.set 2
      block ;; label = @1
        block ;; label = @2
          local.get 1
          i32.const 128
          i32.ge_u
          br_if 0 (;@2;)
          i32.const 1
          local.set 3
          br 1 (;@1;)
        end
        block ;; label = @2
          local.get 1
          i32.const 2048
          i32.ge_u
          br_if 0 (;@2;)
          i32.const 2
          local.set 3
          br 1 (;@1;)
        end
        i32.const 3
        i32.const 4
        local.get 1
        i32.const 65536
        i32.lt_u
        select
        local.set 3
      end
      local.get 2
      local.set 4
      block ;; label = @1
        local.get 3
        local.get 0
        i32.load
        local.get 2
        i32.sub
        i32.le_u
        br_if 0 (;@1;)
        local.get 0
        local.get 2
        local.get 3
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
        local.get 0
        i32.load offset=8
        local.set 4
      end
      local.get 0
      i32.load offset=4
      local.get 4
      i32.add
      local.set 4
      block ;; label = @1
        block ;; label = @2
          local.get 1
          i32.const 128
          i32.lt_u
          br_if 0 (;@2;)
          local.get 1
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 5
          local.get 1
          i32.const 6
          i32.shr_u
          local.set 6
          block ;; label = @3
            local.get 1
            i32.const 2048
            i32.ge_u
            br_if 0 (;@3;)
            local.get 4
            local.get 5
            i32.store8 offset=1
            local.get 4
            local.get 6
            i32.const 192
            i32.or
            i32.store8
            br 2 (;@1;)
          end
          local.get 1
          i32.const 12
          i32.shr_u
          local.set 7
          local.get 6
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          local.set 6
          block ;; label = @3
            local.get 1
            i32.const 65535
            i32.gt_u
            br_if 0 (;@3;)
            local.get 4
            local.get 5
            i32.store8 offset=2
            local.get 4
            local.get 6
            i32.store8 offset=1
            local.get 4
            local.get 7
            i32.const 224
            i32.or
            i32.store8
            br 2 (;@1;)
          end
          local.get 4
          local.get 5
          i32.store8 offset=3
          local.get 4
          local.get 6
          i32.store8 offset=2
          local.get 4
          local.get 7
          i32.const 63
          i32.and
          i32.const -128
          i32.or
          i32.store8 offset=1
          local.get 4
          local.get 1
          i32.const 18
          i32.shr_u
          i32.const -16
          i32.or
          i32.store8
          br 1 (;@1;)
        end
        local.get 4
        local.get 1
        i32.store8
      end
      local.get 0
      local.get 3
      local.get 2
      i32.add
      i32.store offset=8
      i32.const 0
    )
    (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h37bc7f65accfd1cfE (;119;) (type 4) (param i32 i32 i32) (result i32)
      (local i32)
      block ;; label = @1
        local.get 2
        local.get 0
        i32.load
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.sub
        i32.le_u
        br_if 0 (;@1;)
        local.get 0
        local.get 3
        local.get 2
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
        local.get 0
        i32.load offset=8
        local.set 3
      end
      block ;; label = @1
        local.get 2
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.get 3
        i32.add
        local.get 1
        local.get 2
        memory.copy
      end
      local.get 0
      local.get 3
      local.get 2
      i32.add
      i32.store offset=8
      i32.const 0
    )
    (func $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17hdf8e65e67aa48b04E (;120;) (type 2) (param i32 i32) (result i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      local.get 0
      i32.const 4
      i32.add
      i32.store offset=12
      local.get 1
      global.get $GOT.data.internal.__memory_base
      local.tee 3
      i32.const 1051512
      i32.add
      i32.const 9
      local.get 3
      i32.const 1051521
      i32.add
      i32.const 11
      local.get 0
      local.get 3
      i32.const 1057800
      i32.add
      local.get 3
      i32.const 1051532
      i32.add
      i32.const 9
      local.get 2
      i32.const 12
      i32.add
      local.get 3
      i32.const 1057816
      i32.add
      call $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h5ecaa9e0e5a3130bE
      local.set 3
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 3
    )
    (func $_ZN66_$LT$std..sys..stdio..wasip2..Stderr$u20$as$u20$std..io..Write$GT$5flush17hc3bbe25176b00fb5E (;121;) (type 1) (param i32 i32)
      local.get 0
      i32.const 4
      i32.store8
    )
    (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h6cb8e96e4ec727ecE (;122;) (type 4) (param i32 i32 i32) (result i32)
      (local i32)
      block ;; label = @1
        local.get 2
        local.get 0
        i32.load offset=8
        local.tee 0
        i32.load
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.sub
        i32.le_u
        br_if 0 (;@1;)
        local.get 0
        local.get 3
        local.get 2
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hc9798b89131e2356E
        local.get 0
        i32.load offset=8
        local.set 3
      end
      block ;; label = @1
        local.get 2
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.get 3
        i32.add
        local.get 1
        local.get 2
        memory.copy
      end
      local.get 0
      local.get 3
      local.get 2
      i32.add
      i32.store offset=8
      i32.const 0
    )
    (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17ha388109139f2a9c5E (;123;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      i32.const 8
      i32.add
      local.get 0
      i32.load offset=8
      local.get 1
      local.get 2
      call $_ZN3std2io5Write9write_all17h6cce4afb022c1e6bE
      block ;; label = @1
        local.get 3
        i32.load8_u offset=8
        local.tee 2
        i32.const 4
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.set 4
        block ;; label = @2
          block ;; label = @3
            local.get 0
            i32.load8_u
            local.tee 1
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 1
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 4
          i32.load
          local.set 5
          block ;; label = @3
            local.get 4
            i32.const 4
            i32.add
            i32.load
            local.tee 1
            i32.load
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 1
            i32.load offset=4
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            local.get 1
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 4
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 0
        local.get 3
        i64.load offset=8
        i64.store align=4
      end
      local.get 3
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 2
      i32.const 4
      i32.ne
    )
    (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hbb04cb6b362374dbE (;124;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      i32.const 8
      i32.add
      local.get 0
      i32.load offset=8
      local.get 1
      local.get 2
      call $_ZN61_$LT$std..io..stdio..StdoutLock$u20$as$u20$std..io..Write$GT$9write_all17h24094c8b22ddcbc1E
      block ;; label = @1
        local.get 3
        i32.load8_u offset=8
        local.tee 2
        i32.const 4
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.set 4
        block ;; label = @2
          block ;; label = @3
            local.get 0
            i32.load8_u
            local.tee 1
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 1
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 4
          i32.load
          local.set 5
          block ;; label = @3
            local.get 4
            i32.const 4
            i32.add
            i32.load
            local.tee 1
            i32.load
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 1
            i32.load offset=4
            local.tee 6
            i32.eqz
            br_if 0 (;@3;)
            local.get 5
            local.get 6
            local.get 1
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 4
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 0
        local.get 3
        i64.load offset=8
        i64.store align=4
      end
      local.get 3
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 2
      i32.const 4
      i32.ne
    )
    (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hc3537371107a7c50E (;125;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i64 i32 i32 i64)
      i32.const 0
      local.set 3
      block ;; label = @1
        i32.const 0
        local.get 0
        i32.load offset=8
        local.tee 4
        i32.load offset=4
        local.tee 5
        local.get 4
        i64.load offset=8
        local.tee 6
        i64.const 4294967295
        local.get 6
        i64.const 4294967295
        i64.lt_u
        select
        i32.wrap_i64
        i32.sub
        local.tee 7
        local.get 7
        local.get 5
        i32.gt_u
        select
        local.tee 7
        local.get 2
        local.get 7
        local.get 2
        i32.lt_u
        select
        local.tee 8
        i32.eqz
        br_if 0 (;@1;)
        local.get 4
        i32.load
        local.get 6
        local.get 5
        i64.extend_i32_u
        local.tee 9
        local.get 6
        local.get 9
        i64.lt_u
        select
        i32.wrap_i64
        i32.add
        local.get 1
        local.get 8
        memory.copy
      end
      local.get 4
      local.get 6
      local.get 8
      i64.extend_i32_u
      i64.add
      i64.store offset=8
      block ;; label = @1
        local.get 7
        local.get 2
        i32.ge_u
        br_if 0 (;@1;)
        global.get $GOT.data.internal.__memory_base
        i32.const 1056944
        i32.add
        i64.load
        local.tee 6
        i64.const 255
        i64.and
        i64.const 4
        i64.eq
        br_if 0 (;@1;)
        local.get 0
        i32.load offset=4
        local.set 4
        block ;; label = @2
          block ;; label = @3
            local.get 0
            i32.load8_u
            local.tee 2
            i32.const 4
            i32.gt_u
            br_if 0 (;@3;)
            local.get 2
            i32.const 3
            i32.ne
            br_if 1 (;@2;)
          end
          local.get 4
          i32.load
          local.set 7
          block ;; label = @3
            local.get 4
            i32.const 4
            i32.add
            i32.load
            local.tee 2
            i32.load
            local.tee 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 7
            local.get 5
            call_indirect (type 0)
          end
          block ;; label = @3
            local.get 2
            i32.load offset=4
            local.tee 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 7
            local.get 5
            local.get 2
            i32.load offset=8
            call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          end
          local.get 4
          i32.const 12
          i32.const 4
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
        end
        local.get 0
        local.get 6
        i64.store align=4
        i32.const 1
        local.set 3
      end
      local.get 3
    )
    (func $_ZN86_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17hfaf43aa2b55c6473E (;126;) (type 2) (param i32 i32) (result i32)
      local.get 1
      local.get 0
      i32.load
      local.get 0
      i32.load offset=4
      call $_ZN4core3fmt9Formatter9write_str17h2218e50d8c415133E
    )
    (func $_ZN89_$LT$std..panicking..panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h122740778386db5bE (;127;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i64 i64)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.load
          i32.const -2147483648
          i32.eq
          br_if 0 (;@2;)
          local.get 1
          local.get 0
          i32.load offset=4
          local.get 0
          i32.load offset=8
          call $_ZN4core3fmt9Formatter9write_str17h2218e50d8c415133E
          local.set 0
          br 1 (;@1;)
        end
        local.get 1
        i32.load offset=4
        local.set 3
        local.get 1
        i32.load
        local.set 1
        local.get 0
        i32.load offset=12
        i32.load
        local.tee 0
        i64.load align=4
        local.set 4
        local.get 0
        i64.load offset=8 align=4
        local.set 5
        local.get 2
        local.get 0
        i64.load offset=16 align=4
        i64.store offset=24 align=4
        local.get 2
        local.get 5
        i64.store offset=16 align=4
        local.get 2
        local.get 4
        i64.store offset=8 align=4
        local.get 1
        local.get 3
        local.get 2
        i32.const 8
        i32.add
        call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
        local.set 0
      end
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN93_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h39b4b5b7682ddc91E (;128;) (type 1) (param i32 i32)
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1057856
      i32.add
      i32.store offset=4
      local.get 0
      local.get 1
      i32.store
    )
    (func $_ZN93_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17h013e14653dda53dbE (;129;) (type 1) (param i32 i32)
      local.get 0
      local.get 1
      i64.load align=4
      i64.store
    )
    (func $_ZN93_$LT$std..panicking..panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h32bf4f2a94ae4e2fE (;130;) (type 1) (param i32 i32)
      (local i32 i32)
      local.get 1
      i32.load offset=4
      local.set 2
      local.get 1
      i32.load
      local.set 3
      call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
      block ;; label = @1
        i32.const 8
        i32.const 4
        call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
        local.tee 1
        br_if 0 (;@1;)
        i32.const 4
        i32.const 8
        call $_ZN5alloc5alloc18handle_alloc_error17h2e6feec2f4ff6c76E
        unreachable
      end
      local.get 1
      local.get 2
      i32.store offset=4
      local.get 1
      local.get 3
      i32.store
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1057856
      i32.add
      i32.store offset=4
      local.get 0
      local.get 1
      i32.store
    )
    (func $_ZN96_$LT$std..panicking..panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h9955d5602166b291E (;131;) (type 1) (param i32 i32)
      (local i32 i32 i32 i64 i64)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        local.get 1
        i32.load
        i32.const -2147483648
        i32.ne
        br_if 0 (;@1;)
        local.get 1
        i32.load offset=12
        local.set 3
        local.get 2
        i32.const 12
        i32.add
        i32.const 8
        i32.add
        local.tee 4
        i32.const 0
        i32.store
        local.get 2
        i64.const 4294967296
        i64.store offset=12 align=4
        local.get 3
        i32.load
        local.tee 3
        i64.load align=4
        local.set 5
        local.get 3
        i64.load offset=8 align=4
        local.set 6
        local.get 2
        local.get 3
        i64.load offset=16 align=4
        i64.store offset=40 align=4
        local.get 2
        local.get 6
        i64.store offset=32 align=4
        local.get 2
        local.get 5
        i64.store offset=24 align=4
        local.get 2
        i32.const 12
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1057500
        i32.add
        local.get 2
        i32.const 24
        i32.add
        call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
        drop
        local.get 2
        i32.const 8
        i32.add
        local.get 4
        i32.load
        local.tee 3
        i32.store
        local.get 2
        local.get 2
        i64.load offset=12 align=4
        local.tee 5
        i64.store
        local.get 1
        i32.const 8
        i32.add
        local.get 3
        i32.store
        local.get 1
        local.get 5
        i64.store align=4
      end
      local.get 0
      local.get 1
      i32.store
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1057904
      i32.add
      i32.store offset=4
      local.get 2
      i32.const 48
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN96_$LT$std..panicking..panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17hd7e2201362e07481E (;132;) (type 1) (param i32 i32)
      (local i32 i32 i32 i64 i64)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        local.get 1
        i32.load
        i32.const -2147483648
        i32.ne
        br_if 0 (;@1;)
        local.get 1
        i32.load offset=12
        local.set 3
        local.get 2
        i32.const 28
        i32.add
        i32.const 8
        i32.add
        local.tee 4
        i32.const 0
        i32.store
        local.get 2
        i64.const 4294967296
        i64.store offset=28 align=4
        local.get 3
        i32.load
        local.tee 3
        i64.load align=4
        local.set 5
        local.get 3
        i64.load offset=8 align=4
        local.set 6
        local.get 2
        local.get 3
        i64.load offset=16 align=4
        i64.store offset=56 align=4
        local.get 2
        local.get 6
        i64.store offset=48 align=4
        local.get 2
        local.get 5
        i64.store offset=40 align=4
        local.get 2
        i32.const 28
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1057500
        i32.add
        local.get 2
        i32.const 40
        i32.add
        call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
        drop
        local.get 2
        i32.const 16
        i32.add
        i32.const 8
        i32.add
        local.get 4
        i32.load
        local.tee 3
        i32.store
        local.get 2
        local.get 2
        i64.load offset=28 align=4
        local.tee 5
        i64.store offset=16
        local.get 1
        i32.const 8
        i32.add
        local.get 3
        i32.store
        local.get 1
        local.get 5
        i64.store align=4
      end
      local.get 1
      i64.load align=4
      local.set 5
      local.get 1
      i64.const 4294967296
      i64.store align=4
      local.get 2
      i32.const 8
      i32.add
      local.tee 3
      local.get 1
      i32.const 8
      i32.add
      local.tee 1
      i32.load
      i32.store
      local.get 1
      i32.const 0
      i32.store
      local.get 2
      local.get 5
      i64.store
      call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
      block ;; label = @1
        i32.const 12
        i32.const 4
        call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
        local.tee 1
        br_if 0 (;@1;)
        i32.const 4
        i32.const 12
        call $_ZN5alloc5alloc18handle_alloc_error17h2e6feec2f4ff6c76E
        unreachable
      end
      local.get 1
      local.get 2
      i64.load
      i64.store align=4
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.load
      i32.store
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1057904
      i32.add
      i32.store offset=4
      local.get 0
      local.get 1
      i32.store
      local.get 2
      i32.const 64
      i32.add
      global.set $__stack_pointer
    )
    (func $cabi_realloc (;133;) (type 8) (param i32 i32 i32 i32) (result i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            br_if 0 (;@3;)
            local.get 3
            i32.eqz
            br_if 2 (;@1;)
            call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
            local.get 3
            local.get 2
            call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
            local.tee 2
            i32.eqz
            br_if 1 (;@2;)
            br 2 (;@1;)
          end
          local.get 0
          local.get 1
          local.get 2
          local.get 3
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_realloc
          local.tee 2
          br_if 1 (;@1;)
        end
        call $_ZN3std3sys3pal6wasip27helpers14abort_internal17h0f2c0424e81d1365E
        unreachable
      end
      local.get 2
    )
    (func $_ZN4wasi5proxy40__link_custom_section_describing_imports17hde78c366373157cdE (;134;) (type 7))
    (func $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string17h686362aefc88ac06E (;135;) (type 1) (param i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i64.const 0
      i64.store offset=8
      local.get 1
      i32.load
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4wasi7imports4wasi2io5error5Error15to_debug_string11wit_import117h9fe3cd77bbe1ce6bE
      local.get 0
      local.get 2
      i32.load offset=12
      local.tee 1
      i32.store offset=8
      local.get 0
      local.get 2
      i32.load offset=8
      i32.store offset=4
      local.get 0
      local.get 1
      i32.store
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush17hefeb5e876bcc0d5eE (;136;) (type 5) (param i32 i32 i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      local.get 1
      i32.load
      local.get 2
      local.get 3
      local.get 4
      i32.const 4
      i32.add
      call $_ZN4wasi7imports4wasi2io7streams12OutputStream24blocking_write_and_flush11wit_import217h3a0283ab92a3f070E
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i32.load8_u offset=4
          i32.const 1
          i32.and
          br_if 0 (;@2;)
          i32.const 2
          local.set 1
          br 1 (;@1;)
        end
        local.get 4
        i32.load8_u offset=8
        i32.const 0
        i32.ne
        local.set 1
        local.get 4
        i32.load offset=12
        local.set 3
      end
      local.get 0
      local.get 3
      i32.store offset=4
      local.get 0
      local.get 1
      i32.store
      local.get 4
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN4wasi7imports4wasi3cli6stderr10get_stderr17h7c2dde8461585e97E (;137;) (type 6) (result i32)
      call $_ZN4wasi7imports4wasi3cli6stderr10get_stderr11wit_import017h85391993be43e9ecE
    )
    (func $_ZN4wasi7imports4wasi3cli6stdout10get_stdout17h651418575672c601E (;138;) (type 6) (result i32)
      call $_ZN4wasi7imports4wasi3cli6stdout10get_stdout11wit_import017h6cdcabf9277da265E
    )
    (func $malloc (;139;) (type 9) (param i32) (result i32)
      local.get 0
      call $dlmalloc
    )
    (func $dlmalloc (;140;) (type 9) (param i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          block ;; label = @11
                            block ;; label = @12
                              block ;; label = @13
                                i32.const 0
                                i32.load offset=1058792
                                local.tee 2
                                br_if 0 (;@13;)
                                block ;; label = @14
                                  i32.const 0
                                  i32.load offset=1059240
                                  local.tee 3
                                  br_if 0 (;@14;)
                                  i32.const 0
                                  i64.const -1
                                  i64.store offset=1059252 align=4
                                  i32.const 0
                                  i64.const 281474976776192
                                  i64.store offset=1059244 align=4
                                  i32.const 0
                                  local.get 1
                                  i32.const 8
                                  i32.add
                                  i32.const -16
                                  i32.and
                                  i32.const 1431655768
                                  i32.xor
                                  local.tee 3
                                  i32.store offset=1059240
                                  i32.const 0
                                  i32.const 0
                                  i32.store offset=1059260
                                  i32.const 0
                                  i32.const 0
                                  i32.store offset=1059212
                                end
                                i32.const 1114112
                                i32.const 1059312
                                i32.lt_u
                                br_if 1 (;@12;)
                                i32.const 0
                                local.set 2
                                i32.const 1114112
                                i32.const 1059312
                                i32.sub
                                i32.const 89
                                i32.lt_u
                                br_if 0 (;@13;)
                                i32.const 0
                                local.set 4
                                i32.const 0
                                i32.const 1059312
                                i32.store offset=1059216
                                i32.const 0
                                i32.const 1059312
                                i32.store offset=1058784
                                i32.const 0
                                local.get 3
                                i32.store offset=1058804
                                i32.const 0
                                i32.const -1
                                i32.store offset=1058800
                                i32.const 0
                                i32.const 1114112
                                i32.const 1059312
                                i32.sub
                                local.tee 3
                                i32.store offset=1059220
                                i32.const 0
                                local.get 3
                                i32.store offset=1059204
                                i32.const 0
                                local.get 3
                                i32.store offset=1059200
                                loop ;; label = @14
                                  local.get 4
                                  i32.const 1058828
                                  i32.add
                                  local.get 4
                                  i32.const 1058816
                                  i32.add
                                  local.tee 3
                                  i32.store
                                  local.get 3
                                  local.get 4
                                  i32.const 1058808
                                  i32.add
                                  local.tee 5
                                  i32.store
                                  local.get 4
                                  i32.const 1058820
                                  i32.add
                                  local.get 5
                                  i32.store
                                  local.get 4
                                  i32.const 1058836
                                  i32.add
                                  local.get 4
                                  i32.const 1058824
                                  i32.add
                                  local.tee 5
                                  i32.store
                                  local.get 5
                                  local.get 3
                                  i32.store
                                  local.get 4
                                  i32.const 1058844
                                  i32.add
                                  local.get 4
                                  i32.const 1058832
                                  i32.add
                                  local.tee 3
                                  i32.store
                                  local.get 3
                                  local.get 5
                                  i32.store
                                  local.get 4
                                  i32.const 1058840
                                  i32.add
                                  local.get 3
                                  i32.store
                                  local.get 4
                                  i32.const 32
                                  i32.add
                                  local.tee 4
                                  i32.const 256
                                  i32.ne
                                  br_if 0 (;@14;)
                                end
                                i32.const 1114112
                                i32.const -52
                                i32.add
                                i32.const 56
                                i32.store
                                i32.const 0
                                i32.const 0
                                i32.load offset=1059256
                                i32.store offset=1058796
                                i32.const 0
                                i32.const 1059312
                                i32.const -8
                                i32.const 1059312
                                i32.sub
                                i32.const 15
                                i32.and
                                local.tee 4
                                i32.add
                                local.tee 2
                                i32.store offset=1058792
                                i32.const 0
                                i32.const 1114112
                                i32.const 1059312
                                i32.sub
                                local.get 4
                                i32.sub
                                i32.const -56
                                i32.add
                                local.tee 4
                                i32.store offset=1058780
                                local.get 2
                                local.get 4
                                i32.const 1
                                i32.or
                                i32.store offset=4
                              end
                              block ;; label = @13
                                block ;; label = @14
                                  local.get 0
                                  i32.const 236
                                  i32.gt_u
                                  br_if 0 (;@14;)
                                  block ;; label = @15
                                    i32.const 0
                                    i32.load offset=1058768
                                    local.tee 6
                                    i32.const 16
                                    local.get 0
                                    i32.const 19
                                    i32.add
                                    i32.const 496
                                    i32.and
                                    local.get 0
                                    i32.const 11
                                    i32.lt_u
                                    select
                                    local.tee 5
                                    i32.const 3
                                    i32.shr_u
                                    local.tee 3
                                    i32.shr_u
                                    local.tee 4
                                    i32.const 3
                                    i32.and
                                    i32.eqz
                                    br_if 0 (;@15;)
                                    block ;; label = @16
                                      block ;; label = @17
                                        local.get 4
                                        i32.const 1
                                        i32.and
                                        local.get 3
                                        i32.or
                                        i32.const 1
                                        i32.xor
                                        local.tee 5
                                        i32.const 3
                                        i32.shl
                                        local.tee 3
                                        i32.const 1058808
                                        i32.add
                                        local.tee 4
                                        local.get 3
                                        i32.const 1058816
                                        i32.add
                                        i32.load
                                        local.tee 3
                                        i32.load offset=8
                                        local.tee 0
                                        i32.ne
                                        br_if 0 (;@17;)
                                        i32.const 0
                                        local.get 6
                                        i32.const -2
                                        local.get 5
                                        i32.rotl
                                        i32.and
                                        i32.store offset=1058768
                                        br 1 (;@16;)
                                      end
                                      local.get 4
                                      local.get 0
                                      i32.store offset=8
                                      local.get 0
                                      local.get 4
                                      i32.store offset=12
                                    end
                                    local.get 3
                                    i32.const 8
                                    i32.add
                                    local.set 4
                                    local.get 3
                                    local.get 5
                                    i32.const 3
                                    i32.shl
                                    local.tee 5
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    local.get 3
                                    local.get 5
                                    i32.add
                                    local.tee 3
                                    local.get 3
                                    i32.load offset=4
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    br 14 (;@1;)
                                  end
                                  local.get 5
                                  i32.const 0
                                  i32.load offset=1058776
                                  local.tee 7
                                  i32.le_u
                                  br_if 1 (;@13;)
                                  block ;; label = @15
                                    local.get 4
                                    i32.eqz
                                    br_if 0 (;@15;)
                                    block ;; label = @16
                                      block ;; label = @17
                                        local.get 4
                                        local.get 3
                                        i32.shl
                                        i32.const 2
                                        local.get 3
                                        i32.shl
                                        local.tee 4
                                        i32.const 0
                                        local.get 4
                                        i32.sub
                                        i32.or
                                        i32.and
                                        i32.ctz
                                        local.tee 3
                                        i32.const 3
                                        i32.shl
                                        local.tee 4
                                        i32.const 1058808
                                        i32.add
                                        local.tee 0
                                        local.get 4
                                        i32.const 1058816
                                        i32.add
                                        i32.load
                                        local.tee 4
                                        i32.load offset=8
                                        local.tee 8
                                        i32.ne
                                        br_if 0 (;@17;)
                                        i32.const 0
                                        local.get 6
                                        i32.const -2
                                        local.get 3
                                        i32.rotl
                                        i32.and
                                        local.tee 6
                                        i32.store offset=1058768
                                        br 1 (;@16;)
                                      end
                                      local.get 0
                                      local.get 8
                                      i32.store offset=8
                                      local.get 8
                                      local.get 0
                                      i32.store offset=12
                                    end
                                    local.get 4
                                    local.get 5
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    local.get 4
                                    local.get 3
                                    i32.const 3
                                    i32.shl
                                    local.tee 3
                                    i32.add
                                    local.get 3
                                    local.get 5
                                    i32.sub
                                    local.tee 0
                                    i32.store
                                    local.get 4
                                    local.get 5
                                    i32.add
                                    local.tee 8
                                    local.get 0
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    block ;; label = @16
                                      local.get 7
                                      i32.eqz
                                      br_if 0 (;@16;)
                                      local.get 7
                                      i32.const -8
                                      i32.and
                                      i32.const 1058808
                                      i32.add
                                      local.set 5
                                      i32.const 0
                                      i32.load offset=1058788
                                      local.set 3
                                      block ;; label = @17
                                        block ;; label = @18
                                          local.get 6
                                          i32.const 1
                                          local.get 7
                                          i32.const 3
                                          i32.shr_u
                                          i32.shl
                                          local.tee 9
                                          i32.and
                                          br_if 0 (;@18;)
                                          i32.const 0
                                          local.get 6
                                          local.get 9
                                          i32.or
                                          i32.store offset=1058768
                                          local.get 5
                                          local.set 9
                                          br 1 (;@17;)
                                        end
                                        local.get 5
                                        i32.load offset=8
                                        local.set 9
                                      end
                                      local.get 9
                                      local.get 3
                                      i32.store offset=12
                                      local.get 5
                                      local.get 3
                                      i32.store offset=8
                                      local.get 3
                                      local.get 5
                                      i32.store offset=12
                                      local.get 3
                                      local.get 9
                                      i32.store offset=8
                                    end
                                    local.get 4
                                    i32.const 8
                                    i32.add
                                    local.set 4
                                    i32.const 0
                                    local.get 8
                                    i32.store offset=1058788
                                    i32.const 0
                                    local.get 0
                                    i32.store offset=1058776
                                    br 14 (;@1;)
                                  end
                                  i32.const 0
                                  i32.load offset=1058772
                                  local.tee 10
                                  i32.eqz
                                  br_if 1 (;@13;)
                                  local.get 10
                                  i32.ctz
                                  i32.const 2
                                  i32.shl
                                  i32.const 1059072
                                  i32.add
                                  i32.load
                                  local.tee 8
                                  i32.load offset=4
                                  i32.const -8
                                  i32.and
                                  local.get 5
                                  i32.sub
                                  local.set 3
                                  local.get 8
                                  local.set 0
                                  block ;; label = @15
                                    loop ;; label = @16
                                      block ;; label = @17
                                        local.get 0
                                        i32.load offset=16
                                        local.tee 4
                                        br_if 0 (;@17;)
                                        local.get 0
                                        i32.load offset=20
                                        local.tee 4
                                        i32.eqz
                                        br_if 2 (;@15;)
                                      end
                                      local.get 4
                                      i32.load offset=4
                                      i32.const -8
                                      i32.and
                                      local.get 5
                                      i32.sub
                                      local.tee 0
                                      local.get 3
                                      local.get 0
                                      local.get 3
                                      i32.lt_u
                                      local.tee 0
                                      select
                                      local.set 3
                                      local.get 4
                                      local.get 8
                                      local.get 0
                                      select
                                      local.set 8
                                      local.get 4
                                      local.set 0
                                      br 0 (;@16;)
                                    end
                                  end
                                  local.get 8
                                  i32.load offset=24
                                  local.set 2
                                  block ;; label = @15
                                    local.get 8
                                    i32.load offset=12
                                    local.tee 4
                                    local.get 8
                                    i32.eq
                                    br_if 0 (;@15;)
                                    local.get 8
                                    i32.load offset=8
                                    local.tee 0
                                    local.get 4
                                    i32.store offset=12
                                    local.get 4
                                    local.get 0
                                    i32.store offset=8
                                    br 13 (;@2;)
                                  end
                                  block ;; label = @15
                                    block ;; label = @16
                                      local.get 8
                                      i32.load offset=20
                                      local.tee 0
                                      i32.eqz
                                      br_if 0 (;@16;)
                                      local.get 8
                                      i32.const 20
                                      i32.add
                                      local.set 9
                                      br 1 (;@15;)
                                    end
                                    local.get 8
                                    i32.load offset=16
                                    local.tee 0
                                    i32.eqz
                                    br_if 4 (;@11;)
                                    local.get 8
                                    i32.const 16
                                    i32.add
                                    local.set 9
                                  end
                                  loop ;; label = @15
                                    local.get 9
                                    local.set 11
                                    local.get 0
                                    local.tee 4
                                    i32.const 20
                                    i32.add
                                    local.set 9
                                    local.get 4
                                    i32.load offset=20
                                    local.tee 0
                                    br_if 0 (;@15;)
                                    local.get 4
                                    i32.const 16
                                    i32.add
                                    local.set 9
                                    local.get 4
                                    i32.load offset=16
                                    local.tee 0
                                    br_if 0 (;@15;)
                                  end
                                  local.get 11
                                  i32.const 0
                                  i32.store
                                  br 12 (;@2;)
                                end
                                i32.const -1
                                local.set 5
                                local.get 0
                                i32.const -65
                                i32.gt_u
                                br_if 0 (;@13;)
                                local.get 0
                                i32.const 19
                                i32.add
                                local.tee 4
                                i32.const -16
                                i32.and
                                local.set 5
                                i32.const 0
                                i32.load offset=1058772
                                local.tee 10
                                i32.eqz
                                br_if 0 (;@13;)
                                i32.const 31
                                local.set 7
                                block ;; label = @14
                                  local.get 0
                                  i32.const 16777196
                                  i32.gt_u
                                  br_if 0 (;@14;)
                                  local.get 5
                                  i32.const 38
                                  local.get 4
                                  i32.const 8
                                  i32.shr_u
                                  i32.clz
                                  local.tee 4
                                  i32.sub
                                  i32.shr_u
                                  i32.const 1
                                  i32.and
                                  local.get 4
                                  i32.const 1
                                  i32.shl
                                  i32.sub
                                  i32.const 62
                                  i32.add
                                  local.set 7
                                end
                                i32.const 0
                                local.get 5
                                i32.sub
                                local.set 3
                                block ;; label = @14
                                  block ;; label = @15
                                    block ;; label = @16
                                      block ;; label = @17
                                        local.get 7
                                        i32.const 2
                                        i32.shl
                                        i32.const 1059072
                                        i32.add
                                        i32.load
                                        local.tee 0
                                        br_if 0 (;@17;)
                                        i32.const 0
                                        local.set 4
                                        i32.const 0
                                        local.set 9
                                        br 1 (;@16;)
                                      end
                                      i32.const 0
                                      local.set 4
                                      local.get 5
                                      i32.const 0
                                      i32.const 25
                                      local.get 7
                                      i32.const 1
                                      i32.shr_u
                                      i32.sub
                                      local.get 7
                                      i32.const 31
                                      i32.eq
                                      select
                                      i32.shl
                                      local.set 8
                                      i32.const 0
                                      local.set 9
                                      loop ;; label = @17
                                        block ;; label = @18
                                          local.get 0
                                          i32.load offset=4
                                          i32.const -8
                                          i32.and
                                          local.get 5
                                          i32.sub
                                          local.tee 6
                                          local.get 3
                                          i32.ge_u
                                          br_if 0 (;@18;)
                                          local.get 6
                                          local.set 3
                                          local.get 0
                                          local.set 9
                                          local.get 6
                                          br_if 0 (;@18;)
                                          i32.const 0
                                          local.set 3
                                          local.get 0
                                          local.set 9
                                          local.get 0
                                          local.set 4
                                          br 3 (;@15;)
                                        end
                                        local.get 4
                                        local.get 0
                                        i32.load offset=20
                                        local.tee 6
                                        local.get 6
                                        local.get 0
                                        local.get 8
                                        i32.const 29
                                        i32.shr_u
                                        i32.const 4
                                        i32.and
                                        i32.add
                                        i32.load offset=16
                                        local.tee 11
                                        i32.eq
                                        select
                                        local.get 4
                                        local.get 6
                                        select
                                        local.set 4
                                        local.get 8
                                        i32.const 1
                                        i32.shl
                                        local.set 8
                                        local.get 11
                                        local.set 0
                                        local.get 11
                                        br_if 0 (;@17;)
                                      end
                                    end
                                    block ;; label = @16
                                      local.get 4
                                      local.get 9
                                      i32.or
                                      br_if 0 (;@16;)
                                      i32.const 0
                                      local.set 9
                                      i32.const 2
                                      local.get 7
                                      i32.shl
                                      local.tee 4
                                      i32.const 0
                                      local.get 4
                                      i32.sub
                                      i32.or
                                      local.get 10
                                      i32.and
                                      local.tee 4
                                      i32.eqz
                                      br_if 3 (;@13;)
                                      local.get 4
                                      i32.ctz
                                      i32.const 2
                                      i32.shl
                                      i32.const 1059072
                                      i32.add
                                      i32.load
                                      local.set 4
                                    end
                                    local.get 4
                                    i32.eqz
                                    br_if 1 (;@14;)
                                  end
                                  loop ;; label = @15
                                    local.get 4
                                    i32.load offset=4
                                    i32.const -8
                                    i32.and
                                    local.get 5
                                    i32.sub
                                    local.tee 6
                                    local.get 3
                                    i32.lt_u
                                    local.set 8
                                    block ;; label = @16
                                      local.get 4
                                      i32.load offset=16
                                      local.tee 0
                                      br_if 0 (;@16;)
                                      local.get 4
                                      i32.load offset=20
                                      local.set 0
                                    end
                                    local.get 6
                                    local.get 3
                                    local.get 8
                                    select
                                    local.set 3
                                    local.get 4
                                    local.get 9
                                    local.get 8
                                    select
                                    local.set 9
                                    local.get 0
                                    local.set 4
                                    local.get 0
                                    br_if 0 (;@15;)
                                  end
                                end
                                local.get 9
                                i32.eqz
                                br_if 0 (;@13;)
                                local.get 3
                                i32.const 0
                                i32.load offset=1058776
                                local.get 5
                                i32.sub
                                i32.ge_u
                                br_if 0 (;@13;)
                                local.get 9
                                i32.load offset=24
                                local.set 11
                                block ;; label = @14
                                  local.get 9
                                  i32.load offset=12
                                  local.tee 4
                                  local.get 9
                                  i32.eq
                                  br_if 0 (;@14;)
                                  local.get 9
                                  i32.load offset=8
                                  local.tee 0
                                  local.get 4
                                  i32.store offset=12
                                  local.get 4
                                  local.get 0
                                  i32.store offset=8
                                  br 11 (;@3;)
                                end
                                block ;; label = @14
                                  block ;; label = @15
                                    local.get 9
                                    i32.load offset=20
                                    local.tee 0
                                    i32.eqz
                                    br_if 0 (;@15;)
                                    local.get 9
                                    i32.const 20
                                    i32.add
                                    local.set 8
                                    br 1 (;@14;)
                                  end
                                  local.get 9
                                  i32.load offset=16
                                  local.tee 0
                                  i32.eqz
                                  br_if 4 (;@10;)
                                  local.get 9
                                  i32.const 16
                                  i32.add
                                  local.set 8
                                end
                                loop ;; label = @14
                                  local.get 8
                                  local.set 6
                                  local.get 0
                                  local.tee 4
                                  i32.const 20
                                  i32.add
                                  local.set 8
                                  local.get 4
                                  i32.load offset=20
                                  local.tee 0
                                  br_if 0 (;@14;)
                                  local.get 4
                                  i32.const 16
                                  i32.add
                                  local.set 8
                                  local.get 4
                                  i32.load offset=16
                                  local.tee 0
                                  br_if 0 (;@14;)
                                end
                                local.get 6
                                i32.const 0
                                i32.store
                                br 10 (;@3;)
                              end
                              block ;; label = @13
                                i32.const 0
                                i32.load offset=1058776
                                local.tee 4
                                local.get 5
                                i32.lt_u
                                br_if 0 (;@13;)
                                i32.const 0
                                i32.load offset=1058788
                                local.set 3
                                block ;; label = @14
                                  block ;; label = @15
                                    local.get 4
                                    local.get 5
                                    i32.sub
                                    local.tee 0
                                    i32.const 16
                                    i32.lt_u
                                    br_if 0 (;@15;)
                                    local.get 3
                                    local.get 5
                                    i32.add
                                    local.tee 8
                                    local.get 0
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    local.get 3
                                    local.get 4
                                    i32.add
                                    local.get 0
                                    i32.store
                                    local.get 3
                                    local.get 5
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    br 1 (;@14;)
                                  end
                                  local.get 3
                                  local.get 4
                                  i32.const 3
                                  i32.or
                                  i32.store offset=4
                                  local.get 3
                                  local.get 4
                                  i32.add
                                  local.tee 4
                                  local.get 4
                                  i32.load offset=4
                                  i32.const 1
                                  i32.or
                                  i32.store offset=4
                                  i32.const 0
                                  local.set 8
                                  i32.const 0
                                  local.set 0
                                end
                                i32.const 0
                                local.get 0
                                i32.store offset=1058776
                                i32.const 0
                                local.get 8
                                i32.store offset=1058788
                                local.get 3
                                i32.const 8
                                i32.add
                                local.set 4
                                br 12 (;@1;)
                              end
                              block ;; label = @13
                                i32.const 0
                                i32.load offset=1058780
                                local.tee 0
                                local.get 5
                                i32.le_u
                                br_if 0 (;@13;)
                                local.get 2
                                local.get 5
                                i32.add
                                local.tee 4
                                local.get 0
                                local.get 5
                                i32.sub
                                local.tee 3
                                i32.const 1
                                i32.or
                                i32.store offset=4
                                i32.const 0
                                local.get 4
                                i32.store offset=1058792
                                i32.const 0
                                local.get 3
                                i32.store offset=1058780
                                local.get 2
                                local.get 5
                                i32.const 3
                                i32.or
                                i32.store offset=4
                                local.get 2
                                i32.const 8
                                i32.add
                                local.set 4
                                br 12 (;@1;)
                              end
                              block ;; label = @13
                                block ;; label = @14
                                  i32.const 0
                                  i32.load offset=1059240
                                  i32.eqz
                                  br_if 0 (;@14;)
                                  i32.const 0
                                  i32.load offset=1059248
                                  local.set 3
                                  br 1 (;@13;)
                                end
                                i32.const 0
                                i64.const -1
                                i64.store offset=1059252 align=4
                                i32.const 0
                                i64.const 281474976776192
                                i64.store offset=1059244 align=4
                                i32.const 0
                                local.get 1
                                i32.const 12
                                i32.add
                                i32.const -16
                                i32.and
                                i32.const 1431655768
                                i32.xor
                                i32.store offset=1059240
                                i32.const 0
                                i32.const 0
                                i32.store offset=1059260
                                i32.const 0
                                i32.const 0
                                i32.store offset=1059212
                                i32.const 65536
                                local.set 3
                              end
                              i32.const 0
                              local.set 4
                              block ;; label = @13
                                local.get 3
                                local.get 5
                                i32.const 71
                                i32.add
                                local.tee 11
                                i32.add
                                local.tee 8
                                i32.const 0
                                local.get 3
                                i32.sub
                                local.tee 6
                                i32.and
                                local.tee 9
                                local.get 5
                                i32.gt_u
                                br_if 0 (;@13;)
                                i32.const 0
                                i32.const 48
                                i32.store offset=1059264
                                br 12 (;@1;)
                              end
                              block ;; label = @13
                                i32.const 0
                                i32.load offset=1059208
                                local.tee 4
                                i32.eqz
                                br_if 0 (;@13;)
                                block ;; label = @14
                                  i32.const 0
                                  i32.load offset=1059200
                                  local.tee 3
                                  local.get 9
                                  i32.add
                                  local.tee 7
                                  local.get 3
                                  i32.le_u
                                  br_if 0 (;@14;)
                                  local.get 7
                                  local.get 4
                                  i32.le_u
                                  br_if 1 (;@13;)
                                end
                                i32.const 0
                                local.set 4
                                i32.const 0
                                i32.const 48
                                i32.store offset=1059264
                                br 12 (;@1;)
                              end
                              i32.const 0
                              i32.load8_u offset=1059212
                              i32.const 4
                              i32.and
                              br_if 5 (;@7;)
                              block ;; label = @13
                                block ;; label = @14
                                  block ;; label = @15
                                    local.get 2
                                    i32.eqz
                                    br_if 0 (;@15;)
                                    i32.const 1059216
                                    local.set 4
                                    loop ;; label = @16
                                      block ;; label = @17
                                        local.get 2
                                        local.get 4
                                        i32.load
                                        local.tee 3
                                        i32.lt_u
                                        br_if 0 (;@17;)
                                        local.get 2
                                        local.get 3
                                        local.get 4
                                        i32.load offset=4
                                        i32.add
                                        i32.lt_u
                                        br_if 3 (;@14;)
                                      end
                                      local.get 4
                                      i32.load offset=8
                                      local.tee 4
                                      br_if 0 (;@16;)
                                    end
                                  end
                                  i32.const 0
                                  call $sbrk
                                  local.tee 8
                                  i32.const -1
                                  i32.eq
                                  br_if 6 (;@8;)
                                  local.get 9
                                  local.set 6
                                  block ;; label = @15
                                    i32.const 0
                                    i32.load offset=1059244
                                    local.tee 4
                                    i32.const -1
                                    i32.add
                                    local.tee 3
                                    local.get 8
                                    i32.and
                                    i32.eqz
                                    br_if 0 (;@15;)
                                    local.get 9
                                    local.get 8
                                    i32.sub
                                    local.get 3
                                    local.get 8
                                    i32.add
                                    i32.const 0
                                    local.get 4
                                    i32.sub
                                    i32.and
                                    i32.add
                                    local.set 6
                                  end
                                  local.get 6
                                  local.get 5
                                  i32.le_u
                                  br_if 6 (;@8;)
                                  local.get 6
                                  i32.const 2147483646
                                  i32.gt_u
                                  br_if 6 (;@8;)
                                  block ;; label = @15
                                    i32.const 0
                                    i32.load offset=1059208
                                    local.tee 4
                                    i32.eqz
                                    br_if 0 (;@15;)
                                    i32.const 0
                                    i32.load offset=1059200
                                    local.tee 3
                                    local.get 6
                                    i32.add
                                    local.tee 0
                                    local.get 3
                                    i32.le_u
                                    br_if 7 (;@8;)
                                    local.get 0
                                    local.get 4
                                    i32.gt_u
                                    br_if 7 (;@8;)
                                  end
                                  local.get 6
                                  call $sbrk
                                  local.tee 4
                                  local.get 8
                                  i32.ne
                                  br_if 1 (;@13;)
                                  br 8 (;@6;)
                                end
                                local.get 8
                                local.get 0
                                i32.sub
                                local.get 6
                                i32.and
                                local.tee 6
                                i32.const 2147483646
                                i32.gt_u
                                br_if 5 (;@8;)
                                local.get 6
                                call $sbrk
                                local.tee 8
                                local.get 4
                                i32.load
                                local.get 4
                                i32.load offset=4
                                i32.add
                                i32.eq
                                br_if 4 (;@9;)
                                local.get 8
                                local.set 4
                              end
                              block ;; label = @13
                                local.get 6
                                local.get 5
                                i32.const 72
                                i32.add
                                i32.ge_u
                                br_if 0 (;@13;)
                                local.get 4
                                i32.const -1
                                i32.eq
                                br_if 0 (;@13;)
                                block ;; label = @14
                                  local.get 11
                                  local.get 6
                                  i32.sub
                                  i32.const 0
                                  i32.load offset=1059248
                                  local.tee 3
                                  i32.add
                                  i32.const 0
                                  local.get 3
                                  i32.sub
                                  i32.and
                                  local.tee 3
                                  i32.const 2147483646
                                  i32.le_u
                                  br_if 0 (;@14;)
                                  local.get 4
                                  local.set 8
                                  br 8 (;@6;)
                                end
                                block ;; label = @14
                                  local.get 3
                                  call $sbrk
                                  i32.const -1
                                  i32.eq
                                  br_if 0 (;@14;)
                                  local.get 3
                                  local.get 6
                                  i32.add
                                  local.set 6
                                  local.get 4
                                  local.set 8
                                  br 8 (;@6;)
                                end
                                i32.const 0
                                local.get 6
                                i32.sub
                                call $sbrk
                                drop
                                br 5 (;@8;)
                              end
                              local.get 4
                              local.set 8
                              local.get 4
                              i32.const -1
                              i32.ne
                              br_if 6 (;@6;)
                              br 4 (;@8;)
                            end
                            unreachable
                          end
                          i32.const 0
                          local.set 4
                          br 8 (;@2;)
                        end
                        i32.const 0
                        local.set 4
                        br 6 (;@3;)
                      end
                      local.get 8
                      i32.const -1
                      i32.ne
                      br_if 2 (;@6;)
                    end
                    i32.const 0
                    i32.const 0
                    i32.load offset=1059212
                    i32.const 4
                    i32.or
                    i32.store offset=1059212
                  end
                  local.get 9
                  i32.const 2147483646
                  i32.gt_u
                  br_if 1 (;@5;)
                  local.get 9
                  call $sbrk
                  local.set 8
                  i32.const 0
                  call $sbrk
                  local.set 4
                  local.get 8
                  i32.const -1
                  i32.eq
                  br_if 1 (;@5;)
                  local.get 4
                  i32.const -1
                  i32.eq
                  br_if 1 (;@5;)
                  local.get 8
                  local.get 4
                  i32.ge_u
                  br_if 1 (;@5;)
                  local.get 4
                  local.get 8
                  i32.sub
                  local.tee 6
                  local.get 5
                  i32.const 56
                  i32.add
                  i32.le_u
                  br_if 1 (;@5;)
                end
                i32.const 0
                i32.const 0
                i32.load offset=1059200
                local.get 6
                i32.add
                local.tee 4
                i32.store offset=1059200
                block ;; label = @6
                  local.get 4
                  i32.const 0
                  i32.load offset=1059204
                  i32.le_u
                  br_if 0 (;@6;)
                  i32.const 0
                  local.get 4
                  i32.store offset=1059204
                end
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        i32.const 0
                        i32.load offset=1058792
                        local.tee 3
                        i32.eqz
                        br_if 0 (;@9;)
                        i32.const 1059216
                        local.set 4
                        loop ;; label = @10
                          local.get 8
                          local.get 4
                          i32.load
                          local.tee 0
                          local.get 4
                          i32.load offset=4
                          local.tee 9
                          i32.add
                          i32.eq
                          br_if 2 (;@8;)
                          local.get 4
                          i32.load offset=8
                          local.tee 4
                          br_if 0 (;@10;)
                          br 3 (;@7;)
                        end
                      end
                      block ;; label = @9
                        block ;; label = @10
                          i32.const 0
                          i32.load offset=1058784
                          local.tee 4
                          i32.eqz
                          br_if 0 (;@10;)
                          local.get 8
                          local.get 4
                          i32.ge_u
                          br_if 1 (;@9;)
                        end
                        i32.const 0
                        local.get 8
                        i32.store offset=1058784
                      end
                      i32.const 0
                      local.set 4
                      i32.const 0
                      local.get 6
                      i32.store offset=1059220
                      i32.const 0
                      local.get 8
                      i32.store offset=1059216
                      i32.const 0
                      i32.const -1
                      i32.store offset=1058800
                      i32.const 0
                      i32.const 0
                      i32.load offset=1059240
                      i32.store offset=1058804
                      i32.const 0
                      i32.const 0
                      i32.store offset=1059228
                      loop ;; label = @9
                        local.get 4
                        i32.const 1058828
                        i32.add
                        local.get 4
                        i32.const 1058816
                        i32.add
                        local.tee 3
                        i32.store
                        local.get 3
                        local.get 4
                        i32.const 1058808
                        i32.add
                        local.tee 0
                        i32.store
                        local.get 4
                        i32.const 1058820
                        i32.add
                        local.get 0
                        i32.store
                        local.get 4
                        i32.const 1058836
                        i32.add
                        local.get 4
                        i32.const 1058824
                        i32.add
                        local.tee 0
                        i32.store
                        local.get 0
                        local.get 3
                        i32.store
                        local.get 4
                        i32.const 1058844
                        i32.add
                        local.get 4
                        i32.const 1058832
                        i32.add
                        local.tee 3
                        i32.store
                        local.get 3
                        local.get 0
                        i32.store
                        local.get 4
                        i32.const 1058840
                        i32.add
                        local.get 3
                        i32.store
                        local.get 4
                        i32.const 32
                        i32.add
                        local.tee 4
                        i32.const 256
                        i32.ne
                        br_if 0 (;@9;)
                      end
                      local.get 8
                      i32.const -8
                      local.get 8
                      i32.sub
                      i32.const 15
                      i32.and
                      local.tee 4
                      i32.add
                      local.tee 3
                      local.get 6
                      i32.const -56
                      i32.add
                      local.tee 0
                      local.get 4
                      i32.sub
                      local.tee 4
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      i32.const 0
                      i32.const 0
                      i32.load offset=1059256
                      i32.store offset=1058796
                      i32.const 0
                      local.get 4
                      i32.store offset=1058780
                      i32.const 0
                      local.get 3
                      i32.store offset=1058792
                      local.get 8
                      local.get 0
                      i32.add
                      i32.const 56
                      i32.store offset=4
                      br 2 (;@6;)
                    end
                    local.get 3
                    local.get 8
                    i32.ge_u
                    br_if 0 (;@7;)
                    local.get 3
                    local.get 0
                    i32.lt_u
                    br_if 0 (;@7;)
                    local.get 4
                    i32.load offset=12
                    i32.const 8
                    i32.and
                    br_if 0 (;@7;)
                    local.get 3
                    i32.const -8
                    local.get 3
                    i32.sub
                    i32.const 15
                    i32.and
                    local.tee 0
                    i32.add
                    local.tee 8
                    i32.const 0
                    i32.load offset=1058780
                    local.get 6
                    i32.add
                    local.tee 11
                    local.get 0
                    i32.sub
                    local.tee 0
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 4
                    local.get 9
                    local.get 6
                    i32.add
                    i32.store offset=4
                    i32.const 0
                    i32.const 0
                    i32.load offset=1059256
                    i32.store offset=1058796
                    i32.const 0
                    local.get 0
                    i32.store offset=1058780
                    i32.const 0
                    local.get 8
                    i32.store offset=1058792
                    local.get 3
                    local.get 11
                    i32.add
                    i32.const 56
                    i32.store offset=4
                    br 1 (;@6;)
                  end
                  block ;; label = @7
                    local.get 8
                    i32.const 0
                    i32.load offset=1058784
                    i32.ge_u
                    br_if 0 (;@7;)
                    i32.const 0
                    local.get 8
                    i32.store offset=1058784
                  end
                  local.get 8
                  local.get 6
                  i32.add
                  local.set 0
                  i32.const 1059216
                  local.set 4
                  block ;; label = @7
                    block ;; label = @8
                      loop ;; label = @9
                        local.get 4
                        i32.load
                        local.tee 9
                        local.get 0
                        i32.eq
                        br_if 1 (;@8;)
                        local.get 4
                        i32.load offset=8
                        local.tee 4
                        br_if 0 (;@9;)
                        br 2 (;@7;)
                      end
                    end
                    local.get 4
                    i32.load8_u offset=12
                    i32.const 8
                    i32.and
                    i32.eqz
                    br_if 3 (;@4;)
                  end
                  i32.const 1059216
                  local.set 4
                  block ;; label = @7
                    loop ;; label = @8
                      block ;; label = @9
                        local.get 3
                        local.get 4
                        i32.load
                        local.tee 0
                        i32.lt_u
                        br_if 0 (;@9;)
                        local.get 3
                        local.get 0
                        local.get 4
                        i32.load offset=4
                        i32.add
                        local.tee 0
                        i32.lt_u
                        br_if 2 (;@7;)
                      end
                      local.get 4
                      i32.load offset=8
                      local.set 4
                      br 0 (;@8;)
                    end
                  end
                  local.get 8
                  i32.const -8
                  local.get 8
                  i32.sub
                  i32.const 15
                  i32.and
                  local.tee 4
                  i32.add
                  local.tee 11
                  local.get 6
                  i32.const -56
                  i32.add
                  local.tee 9
                  local.get 4
                  i32.sub
                  local.tee 4
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 8
                  local.get 9
                  i32.add
                  i32.const 56
                  i32.store offset=4
                  local.get 3
                  local.get 0
                  i32.const 55
                  local.get 0
                  i32.sub
                  i32.const 15
                  i32.and
                  i32.add
                  i32.const -63
                  i32.add
                  local.tee 9
                  local.get 9
                  local.get 3
                  i32.const 16
                  i32.add
                  i32.lt_u
                  select
                  local.tee 9
                  i32.const 35
                  i32.store offset=4
                  i32.const 0
                  i32.const 0
                  i32.load offset=1059256
                  i32.store offset=1058796
                  i32.const 0
                  local.get 4
                  i32.store offset=1058780
                  i32.const 0
                  local.get 11
                  i32.store offset=1058792
                  local.get 9
                  i32.const 16
                  i32.add
                  i32.const 0
                  i64.load offset=1059224 align=4
                  i64.store align=4
                  local.get 9
                  i32.const 0
                  i64.load offset=1059216 align=4
                  i64.store offset=8 align=4
                  i32.const 0
                  local.get 9
                  i32.const 8
                  i32.add
                  i32.store offset=1059224
                  i32.const 0
                  local.get 6
                  i32.store offset=1059220
                  i32.const 0
                  local.get 8
                  i32.store offset=1059216
                  i32.const 0
                  i32.const 0
                  i32.store offset=1059228
                  local.get 9
                  i32.const 36
                  i32.add
                  local.set 4
                  loop ;; label = @7
                    local.get 4
                    i32.const 7
                    i32.store
                    local.get 4
                    i32.const 4
                    i32.add
                    local.tee 4
                    local.get 0
                    i32.lt_u
                    br_if 0 (;@7;)
                  end
                  local.get 9
                  local.get 3
                  i32.eq
                  br_if 0 (;@6;)
                  local.get 9
                  local.get 9
                  i32.load offset=4
                  i32.const -2
                  i32.and
                  i32.store offset=4
                  local.get 9
                  local.get 9
                  local.get 3
                  i32.sub
                  local.tee 8
                  i32.store
                  local.get 3
                  local.get 8
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  block ;; label = @7
                    block ;; label = @8
                      local.get 8
                      i32.const 255
                      i32.gt_u
                      br_if 0 (;@8;)
                      local.get 8
                      i32.const -8
                      i32.and
                      i32.const 1058808
                      i32.add
                      local.set 4
                      block ;; label = @9
                        block ;; label = @10
                          i32.const 0
                          i32.load offset=1058768
                          local.tee 0
                          i32.const 1
                          local.get 8
                          i32.const 3
                          i32.shr_u
                          i32.shl
                          local.tee 8
                          i32.and
                          br_if 0 (;@10;)
                          i32.const 0
                          local.get 0
                          local.get 8
                          i32.or
                          i32.store offset=1058768
                          local.get 4
                          local.set 0
                          br 1 (;@9;)
                        end
                        local.get 4
                        i32.load offset=8
                        local.set 0
                      end
                      local.get 0
                      local.get 3
                      i32.store offset=12
                      local.get 4
                      local.get 3
                      i32.store offset=8
                      i32.const 12
                      local.set 8
                      i32.const 8
                      local.set 9
                      br 1 (;@7;)
                    end
                    i32.const 31
                    local.set 4
                    block ;; label = @8
                      local.get 8
                      i32.const 16777215
                      i32.gt_u
                      br_if 0 (;@8;)
                      local.get 8
                      i32.const 38
                      local.get 8
                      i32.const 8
                      i32.shr_u
                      i32.clz
                      local.tee 4
                      i32.sub
                      i32.shr_u
                      i32.const 1
                      i32.and
                      local.get 4
                      i32.const 1
                      i32.shl
                      i32.sub
                      i32.const 62
                      i32.add
                      local.set 4
                    end
                    local.get 3
                    local.get 4
                    i32.store offset=28
                    local.get 3
                    i64.const 0
                    i64.store offset=16 align=4
                    local.get 4
                    i32.const 2
                    i32.shl
                    i32.const 1059072
                    i32.add
                    local.set 0
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          i32.const 0
                          i32.load offset=1058772
                          local.tee 9
                          i32.const 1
                          local.get 4
                          i32.shl
                          local.tee 6
                          i32.and
                          br_if 0 (;@10;)
                          local.get 0
                          local.get 3
                          i32.store
                          i32.const 0
                          local.get 9
                          local.get 6
                          i32.or
                          i32.store offset=1058772
                          local.get 3
                          local.get 0
                          i32.store offset=24
                          br 1 (;@9;)
                        end
                        local.get 8
                        i32.const 0
                        i32.const 25
                        local.get 4
                        i32.const 1
                        i32.shr_u
                        i32.sub
                        local.get 4
                        i32.const 31
                        i32.eq
                        select
                        i32.shl
                        local.set 4
                        local.get 0
                        i32.load
                        local.set 9
                        loop ;; label = @10
                          local.get 9
                          local.tee 0
                          i32.load offset=4
                          i32.const -8
                          i32.and
                          local.get 8
                          i32.eq
                          br_if 2 (;@8;)
                          local.get 4
                          i32.const 29
                          i32.shr_u
                          local.set 9
                          local.get 4
                          i32.const 1
                          i32.shl
                          local.set 4
                          local.get 0
                          local.get 9
                          i32.const 4
                          i32.and
                          i32.add
                          local.tee 6
                          i32.load offset=16
                          local.tee 9
                          br_if 0 (;@10;)
                        end
                        local.get 6
                        i32.const 16
                        i32.add
                        local.get 3
                        i32.store
                        local.get 3
                        local.get 0
                        i32.store offset=24
                      end
                      i32.const 8
                      local.set 8
                      i32.const 12
                      local.set 9
                      local.get 3
                      local.set 0
                      local.get 3
                      local.set 4
                      br 1 (;@7;)
                    end
                    local.get 0
                    i32.load offset=8
                    local.set 4
                    local.get 0
                    local.get 3
                    i32.store offset=8
                    local.get 4
                    local.get 3
                    i32.store offset=12
                    local.get 3
                    local.get 4
                    i32.store offset=8
                    i32.const 0
                    local.set 4
                    i32.const 24
                    local.set 8
                    i32.const 12
                    local.set 9
                  end
                  local.get 3
                  local.get 9
                  i32.add
                  local.get 0
                  i32.store
                  local.get 3
                  local.get 8
                  i32.add
                  local.get 4
                  i32.store
                end
                i32.const 0
                i32.load offset=1058780
                local.tee 4
                local.get 5
                i32.le_u
                br_if 0 (;@5;)
                i32.const 0
                i32.load offset=1058792
                local.tee 3
                local.get 5
                i32.add
                local.tee 0
                local.get 4
                local.get 5
                i32.sub
                local.tee 4
                i32.const 1
                i32.or
                i32.store offset=4
                i32.const 0
                local.get 4
                i32.store offset=1058780
                i32.const 0
                local.get 0
                i32.store offset=1058792
                local.get 3
                local.get 5
                i32.const 3
                i32.or
                i32.store offset=4
                local.get 3
                i32.const 8
                i32.add
                local.set 4
                br 4 (;@1;)
              end
              i32.const 0
              local.set 4
              i32.const 0
              i32.const 48
              i32.store offset=1059264
              br 3 (;@1;)
            end
            local.get 4
            local.get 8
            i32.store
            local.get 4
            local.get 4
            i32.load offset=4
            local.get 6
            i32.add
            i32.store offset=4
            local.get 8
            local.get 9
            local.get 5
            call $prepend_alloc
            local.set 4
            br 2 (;@1;)
          end
          block ;; label = @3
            local.get 11
            i32.eqz
            br_if 0 (;@3;)
            block ;; label = @4
              block ;; label = @5
                local.get 9
                local.get 9
                i32.load offset=28
                local.tee 8
                i32.const 2
                i32.shl
                i32.const 1059072
                i32.add
                local.tee 0
                i32.load
                i32.ne
                br_if 0 (;@5;)
                local.get 0
                local.get 4
                i32.store
                local.get 4
                br_if 1 (;@4;)
                i32.const 0
                local.get 10
                i32.const -2
                local.get 8
                i32.rotl
                i32.and
                local.tee 10
                i32.store offset=1058772
                br 2 (;@3;)
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 11
                  i32.load offset=16
                  local.get 9
                  i32.ne
                  br_if 0 (;@6;)
                  local.get 11
                  local.get 4
                  i32.store offset=16
                  br 1 (;@5;)
                end
                local.get 11
                local.get 4
                i32.store offset=20
              end
              local.get 4
              i32.eqz
              br_if 1 (;@3;)
            end
            local.get 4
            local.get 11
            i32.store offset=24
            block ;; label = @4
              local.get 9
              i32.load offset=16
              local.tee 0
              i32.eqz
              br_if 0 (;@4;)
              local.get 4
              local.get 0
              i32.store offset=16
              local.get 0
              local.get 4
              i32.store offset=24
            end
            local.get 9
            i32.load offset=20
            local.tee 0
            i32.eqz
            br_if 0 (;@3;)
            local.get 4
            local.get 0
            i32.store offset=20
            local.get 0
            local.get 4
            i32.store offset=24
          end
          block ;; label = @3
            block ;; label = @4
              local.get 3
              i32.const 15
              i32.gt_u
              br_if 0 (;@4;)
              local.get 9
              local.get 3
              local.get 5
              i32.or
              local.tee 4
              i32.const 3
              i32.or
              i32.store offset=4
              local.get 9
              local.get 4
              i32.add
              local.tee 4
              local.get 4
              i32.load offset=4
              i32.const 1
              i32.or
              i32.store offset=4
              br 1 (;@3;)
            end
            local.get 9
            local.get 5
            i32.add
            local.tee 8
            local.get 3
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 9
            local.get 5
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 8
            local.get 3
            i32.add
            local.get 3
            i32.store
            block ;; label = @4
              local.get 3
              i32.const 255
              i32.gt_u
              br_if 0 (;@4;)
              local.get 3
              i32.const -8
              i32.and
              i32.const 1058808
              i32.add
              local.set 4
              block ;; label = @5
                block ;; label = @6
                  i32.const 0
                  i32.load offset=1058768
                  local.tee 5
                  i32.const 1
                  local.get 3
                  i32.const 3
                  i32.shr_u
                  i32.shl
                  local.tee 3
                  i32.and
                  br_if 0 (;@6;)
                  i32.const 0
                  local.get 5
                  local.get 3
                  i32.or
                  i32.store offset=1058768
                  local.get 4
                  local.set 3
                  br 1 (;@5;)
                end
                local.get 4
                i32.load offset=8
                local.set 3
              end
              local.get 3
              local.get 8
              i32.store offset=12
              local.get 4
              local.get 8
              i32.store offset=8
              local.get 8
              local.get 4
              i32.store offset=12
              local.get 8
              local.get 3
              i32.store offset=8
              br 1 (;@3;)
            end
            i32.const 31
            local.set 4
            block ;; label = @4
              local.get 3
              i32.const 16777215
              i32.gt_u
              br_if 0 (;@4;)
              local.get 3
              i32.const 38
              local.get 3
              i32.const 8
              i32.shr_u
              i32.clz
              local.tee 4
              i32.sub
              i32.shr_u
              i32.const 1
              i32.and
              local.get 4
              i32.const 1
              i32.shl
              i32.sub
              i32.const 62
              i32.add
              local.set 4
            end
            local.get 8
            local.get 4
            i32.store offset=28
            local.get 8
            i64.const 0
            i64.store offset=16 align=4
            local.get 4
            i32.const 2
            i32.shl
            i32.const 1059072
            i32.add
            local.set 5
            block ;; label = @4
              local.get 10
              i32.const 1
              local.get 4
              i32.shl
              local.tee 0
              i32.and
              br_if 0 (;@4;)
              local.get 5
              local.get 8
              i32.store
              i32.const 0
              local.get 10
              local.get 0
              i32.or
              i32.store offset=1058772
              local.get 8
              local.get 5
              i32.store offset=24
              local.get 8
              local.get 8
              i32.store offset=8
              local.get 8
              local.get 8
              i32.store offset=12
              br 1 (;@3;)
            end
            local.get 3
            i32.const 0
            i32.const 25
            local.get 4
            i32.const 1
            i32.shr_u
            i32.sub
            local.get 4
            i32.const 31
            i32.eq
            select
            i32.shl
            local.set 4
            local.get 5
            i32.load
            local.set 0
            block ;; label = @4
              loop ;; label = @5
                local.get 0
                local.tee 5
                i32.load offset=4
                i32.const -8
                i32.and
                local.get 3
                i32.eq
                br_if 1 (;@4;)
                local.get 4
                i32.const 29
                i32.shr_u
                local.set 0
                local.get 4
                i32.const 1
                i32.shl
                local.set 4
                local.get 5
                local.get 0
                i32.const 4
                i32.and
                i32.add
                local.tee 6
                i32.load offset=16
                local.tee 0
                br_if 0 (;@5;)
              end
              local.get 6
              i32.const 16
              i32.add
              local.get 8
              i32.store
              local.get 8
              local.get 5
              i32.store offset=24
              local.get 8
              local.get 8
              i32.store offset=12
              local.get 8
              local.get 8
              i32.store offset=8
              br 1 (;@3;)
            end
            local.get 5
            i32.load offset=8
            local.tee 4
            local.get 8
            i32.store offset=12
            local.get 5
            local.get 8
            i32.store offset=8
            local.get 8
            i32.const 0
            i32.store offset=24
            local.get 8
            local.get 5
            i32.store offset=12
            local.get 8
            local.get 4
            i32.store offset=8
          end
          local.get 9
          i32.const 8
          i32.add
          local.set 4
          br 1 (;@1;)
        end
        block ;; label = @2
          local.get 2
          i32.eqz
          br_if 0 (;@2;)
          block ;; label = @3
            block ;; label = @4
              local.get 8
              local.get 8
              i32.load offset=28
              local.tee 9
              i32.const 2
              i32.shl
              i32.const 1059072
              i32.add
              local.tee 0
              i32.load
              i32.ne
              br_if 0 (;@4;)
              local.get 0
              local.get 4
              i32.store
              local.get 4
              br_if 1 (;@3;)
              i32.const 0
              local.get 10
              i32.const -2
              local.get 9
              i32.rotl
              i32.and
              i32.store offset=1058772
              br 2 (;@2;)
            end
            block ;; label = @4
              block ;; label = @5
                local.get 2
                i32.load offset=16
                local.get 8
                i32.ne
                br_if 0 (;@5;)
                local.get 2
                local.get 4
                i32.store offset=16
                br 1 (;@4;)
              end
              local.get 2
              local.get 4
              i32.store offset=20
            end
            local.get 4
            i32.eqz
            br_if 1 (;@2;)
          end
          local.get 4
          local.get 2
          i32.store offset=24
          block ;; label = @3
            local.get 8
            i32.load offset=16
            local.tee 0
            i32.eqz
            br_if 0 (;@3;)
            local.get 4
            local.get 0
            i32.store offset=16
            local.get 0
            local.get 4
            i32.store offset=24
          end
          local.get 8
          i32.load offset=20
          local.tee 0
          i32.eqz
          br_if 0 (;@2;)
          local.get 4
          local.get 0
          i32.store offset=20
          local.get 0
          local.get 4
          i32.store offset=24
        end
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 15
            i32.gt_u
            br_if 0 (;@3;)
            local.get 8
            local.get 3
            local.get 5
            i32.or
            local.tee 4
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 8
            local.get 4
            i32.add
            local.tee 4
            local.get 4
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            br 1 (;@2;)
          end
          local.get 8
          local.get 5
          i32.add
          local.tee 0
          local.get 3
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 8
          local.get 5
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 0
          local.get 3
          i32.add
          local.get 3
          i32.store
          block ;; label = @3
            local.get 7
            i32.eqz
            br_if 0 (;@3;)
            local.get 7
            i32.const -8
            i32.and
            i32.const 1058808
            i32.add
            local.set 5
            i32.const 0
            i32.load offset=1058788
            local.set 4
            block ;; label = @4
              block ;; label = @5
                i32.const 1
                local.get 7
                i32.const 3
                i32.shr_u
                i32.shl
                local.tee 9
                local.get 6
                i32.and
                br_if 0 (;@5;)
                i32.const 0
                local.get 9
                local.get 6
                i32.or
                i32.store offset=1058768
                local.get 5
                local.set 9
                br 1 (;@4;)
              end
              local.get 5
              i32.load offset=8
              local.set 9
            end
            local.get 9
            local.get 4
            i32.store offset=12
            local.get 5
            local.get 4
            i32.store offset=8
            local.get 4
            local.get 5
            i32.store offset=12
            local.get 4
            local.get 9
            i32.store offset=8
          end
          i32.const 0
          local.get 0
          i32.store offset=1058788
          i32.const 0
          local.get 3
          i32.store offset=1058776
        end
        local.get 8
        i32.const 8
        i32.add
        local.set 4
      end
      local.get 1
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 4
    )
    (func $prepend_alloc (;141;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32)
      local.get 0
      i32.const -8
      local.get 0
      i32.sub
      i32.const 15
      i32.and
      i32.add
      local.tee 3
      local.get 2
      i32.const 3
      i32.or
      i32.store offset=4
      local.get 1
      i32.const -8
      local.get 1
      i32.sub
      i32.const 15
      i32.and
      i32.add
      local.tee 4
      local.get 3
      local.get 2
      i32.add
      local.tee 5
      i32.sub
      local.set 0
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i32.const 0
          i32.load offset=1058792
          i32.ne
          br_if 0 (;@2;)
          i32.const 0
          local.get 5
          i32.store offset=1058792
          i32.const 0
          i32.const 0
          i32.load offset=1058780
          local.get 0
          i32.add
          local.tee 2
          i32.store offset=1058780
          local.get 5
          local.get 2
          i32.const 1
          i32.or
          i32.store offset=4
          br 1 (;@1;)
        end
        block ;; label = @2
          local.get 4
          i32.const 0
          i32.load offset=1058788
          i32.ne
          br_if 0 (;@2;)
          i32.const 0
          local.get 5
          i32.store offset=1058788
          i32.const 0
          i32.const 0
          i32.load offset=1058776
          local.get 0
          i32.add
          local.tee 2
          i32.store offset=1058776
          local.get 5
          local.get 2
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 5
          local.get 2
          i32.add
          local.get 2
          i32.store
          br 1 (;@1;)
        end
        block ;; label = @2
          local.get 4
          i32.load offset=4
          local.tee 1
          i32.const 3
          i32.and
          i32.const 1
          i32.ne
          br_if 0 (;@2;)
          local.get 1
          i32.const -8
          i32.and
          local.set 6
          local.get 4
          i32.load offset=12
          local.set 2
          block ;; label = @3
            block ;; label = @4
              local.get 1
              i32.const 255
              i32.gt_u
              br_if 0 (;@4;)
              block ;; label = @5
                local.get 2
                local.get 4
                i32.load offset=8
                local.tee 7
                i32.ne
                br_if 0 (;@5;)
                i32.const 0
                i32.const 0
                i32.load offset=1058768
                i32.const -2
                local.get 1
                i32.const 3
                i32.shr_u
                i32.rotl
                i32.and
                i32.store offset=1058768
                br 2 (;@3;)
              end
              local.get 2
              local.get 7
              i32.store offset=8
              local.get 7
              local.get 2
              i32.store offset=12
              br 1 (;@3;)
            end
            local.get 4
            i32.load offset=24
            local.set 8
            block ;; label = @4
              block ;; label = @5
                local.get 2
                local.get 4
                i32.eq
                br_if 0 (;@5;)
                local.get 4
                i32.load offset=8
                local.tee 1
                local.get 2
                i32.store offset=12
                local.get 2
                local.get 1
                i32.store offset=8
                br 1 (;@4;)
              end
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 4
                    i32.load offset=20
                    local.tee 1
                    i32.eqz
                    br_if 0 (;@7;)
                    local.get 4
                    i32.const 20
                    i32.add
                    local.set 7
                    br 1 (;@6;)
                  end
                  local.get 4
                  i32.load offset=16
                  local.tee 1
                  i32.eqz
                  br_if 1 (;@5;)
                  local.get 4
                  i32.const 16
                  i32.add
                  local.set 7
                end
                loop ;; label = @6
                  local.get 7
                  local.set 9
                  local.get 1
                  local.tee 2
                  i32.const 20
                  i32.add
                  local.set 7
                  local.get 2
                  i32.load offset=20
                  local.tee 1
                  br_if 0 (;@6;)
                  local.get 2
                  i32.const 16
                  i32.add
                  local.set 7
                  local.get 2
                  i32.load offset=16
                  local.tee 1
                  br_if 0 (;@6;)
                end
                local.get 9
                i32.const 0
                i32.store
                br 1 (;@4;)
              end
              i32.const 0
              local.set 2
            end
            local.get 8
            i32.eqz
            br_if 0 (;@3;)
            block ;; label = @4
              block ;; label = @5
                local.get 4
                local.get 4
                i32.load offset=28
                local.tee 7
                i32.const 2
                i32.shl
                i32.const 1059072
                i32.add
                local.tee 1
                i32.load
                i32.ne
                br_if 0 (;@5;)
                local.get 1
                local.get 2
                i32.store
                local.get 2
                br_if 1 (;@4;)
                i32.const 0
                i32.const 0
                i32.load offset=1058772
                i32.const -2
                local.get 7
                i32.rotl
                i32.and
                i32.store offset=1058772
                br 2 (;@3;)
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 8
                  i32.load offset=16
                  local.get 4
                  i32.ne
                  br_if 0 (;@6;)
                  local.get 8
                  local.get 2
                  i32.store offset=16
                  br 1 (;@5;)
                end
                local.get 8
                local.get 2
                i32.store offset=20
              end
              local.get 2
              i32.eqz
              br_if 1 (;@3;)
            end
            local.get 2
            local.get 8
            i32.store offset=24
            block ;; label = @4
              local.get 4
              i32.load offset=16
              local.tee 1
              i32.eqz
              br_if 0 (;@4;)
              local.get 2
              local.get 1
              i32.store offset=16
              local.get 1
              local.get 2
              i32.store offset=24
            end
            local.get 4
            i32.load offset=20
            local.tee 1
            i32.eqz
            br_if 0 (;@3;)
            local.get 2
            local.get 1
            i32.store offset=20
            local.get 1
            local.get 2
            i32.store offset=24
          end
          local.get 6
          local.get 0
          i32.add
          local.set 0
          local.get 4
          local.get 6
          i32.add
          local.tee 4
          i32.load offset=4
          local.set 1
        end
        local.get 4
        local.get 1
        i32.const -2
        i32.and
        i32.store offset=4
        local.get 5
        local.get 0
        i32.add
        local.get 0
        i32.store
        local.get 5
        local.get 0
        i32.const 1
        i32.or
        i32.store offset=4
        block ;; label = @2
          local.get 0
          i32.const 255
          i32.gt_u
          br_if 0 (;@2;)
          local.get 0
          i32.const -8
          i32.and
          i32.const 1058808
          i32.add
          local.set 2
          block ;; label = @3
            block ;; label = @4
              i32.const 0
              i32.load offset=1058768
              local.tee 1
              i32.const 1
              local.get 0
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 0
              i32.and
              br_if 0 (;@4;)
              i32.const 0
              local.get 1
              local.get 0
              i32.or
              i32.store offset=1058768
              local.get 2
              local.set 0
              br 1 (;@3;)
            end
            local.get 2
            i32.load offset=8
            local.set 0
          end
          local.get 0
          local.get 5
          i32.store offset=12
          local.get 2
          local.get 5
          i32.store offset=8
          local.get 5
          local.get 2
          i32.store offset=12
          local.get 5
          local.get 0
          i32.store offset=8
          br 1 (;@1;)
        end
        i32.const 31
        local.set 2
        block ;; label = @2
          local.get 0
          i32.const 16777215
          i32.gt_u
          br_if 0 (;@2;)
          local.get 0
          i32.const 38
          local.get 0
          i32.const 8
          i32.shr_u
          i32.clz
          local.tee 2
          i32.sub
          i32.shr_u
          i32.const 1
          i32.and
          local.get 2
          i32.const 1
          i32.shl
          i32.sub
          i32.const 62
          i32.add
          local.set 2
        end
        local.get 5
        local.get 2
        i32.store offset=28
        local.get 5
        i64.const 0
        i64.store offset=16 align=4
        local.get 2
        i32.const 2
        i32.shl
        i32.const 1059072
        i32.add
        local.set 1
        block ;; label = @2
          i32.const 0
          i32.load offset=1058772
          local.tee 7
          i32.const 1
          local.get 2
          i32.shl
          local.tee 4
          i32.and
          br_if 0 (;@2;)
          local.get 1
          local.get 5
          i32.store
          i32.const 0
          local.get 7
          local.get 4
          i32.or
          i32.store offset=1058772
          local.get 5
          local.get 1
          i32.store offset=24
          local.get 5
          local.get 5
          i32.store offset=8
          local.get 5
          local.get 5
          i32.store offset=12
          br 1 (;@1;)
        end
        local.get 0
        i32.const 0
        i32.const 25
        local.get 2
        i32.const 1
        i32.shr_u
        i32.sub
        local.get 2
        i32.const 31
        i32.eq
        select
        i32.shl
        local.set 2
        local.get 1
        i32.load
        local.set 7
        block ;; label = @2
          loop ;; label = @3
            local.get 7
            local.tee 1
            i32.load offset=4
            i32.const -8
            i32.and
            local.get 0
            i32.eq
            br_if 1 (;@2;)
            local.get 2
            i32.const 29
            i32.shr_u
            local.set 7
            local.get 2
            i32.const 1
            i32.shl
            local.set 2
            local.get 1
            local.get 7
            i32.const 4
            i32.and
            i32.add
            local.tee 4
            i32.load offset=16
            local.tee 7
            br_if 0 (;@3;)
          end
          local.get 4
          i32.const 16
          i32.add
          local.get 5
          i32.store
          local.get 5
          local.get 1
          i32.store offset=24
          local.get 5
          local.get 5
          i32.store offset=12
          local.get 5
          local.get 5
          i32.store offset=8
          br 1 (;@1;)
        end
        local.get 1
        i32.load offset=8
        local.tee 2
        local.get 5
        i32.store offset=12
        local.get 1
        local.get 5
        i32.store offset=8
        local.get 5
        i32.const 0
        i32.store offset=24
        local.get 5
        local.get 1
        i32.store offset=12
        local.get 5
        local.get 2
        i32.store offset=8
      end
      local.get 3
      i32.const 8
      i32.add
    )
    (func $free (;142;) (type 0) (param i32)
      local.get 0
      call $dlfree
    )
    (func $dlfree (;143;) (type 0) (param i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32)
      block ;; label = @1
        local.get 0
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.const -8
        i32.add
        local.tee 1
        local.get 0
        i32.const -4
        i32.add
        i32.load
        local.tee 2
        i32.const -8
        i32.and
        local.tee 0
        i32.add
        local.set 3
        block ;; label = @2
          local.get 2
          i32.const 1
          i32.and
          br_if 0 (;@2;)
          local.get 2
          i32.const 2
          i32.and
          i32.eqz
          br_if 1 (;@1;)
          local.get 1
          local.get 1
          i32.load
          local.tee 4
          i32.sub
          local.tee 1
          i32.const 0
          i32.load offset=1058784
          i32.lt_u
          br_if 1 (;@1;)
          local.get 4
          local.get 0
          i32.add
          local.set 0
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  local.get 1
                  i32.const 0
                  i32.load offset=1058788
                  i32.eq
                  br_if 0 (;@6;)
                  local.get 1
                  i32.load offset=12
                  local.set 2
                  block ;; label = @7
                    local.get 4
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@7;)
                    local.get 2
                    local.get 1
                    i32.load offset=8
                    local.tee 5
                    i32.ne
                    br_if 2 (;@5;)
                    i32.const 0
                    i32.const 0
                    i32.load offset=1058768
                    i32.const -2
                    local.get 4
                    i32.const 3
                    i32.shr_u
                    i32.rotl
                    i32.and
                    i32.store offset=1058768
                    br 5 (;@2;)
                  end
                  local.get 1
                  i32.load offset=24
                  local.set 6
                  block ;; label = @7
                    local.get 2
                    local.get 1
                    i32.eq
                    br_if 0 (;@7;)
                    local.get 1
                    i32.load offset=8
                    local.tee 4
                    local.get 2
                    i32.store offset=12
                    local.get 2
                    local.get 4
                    i32.store offset=8
                    br 4 (;@3;)
                  end
                  block ;; label = @7
                    block ;; label = @8
                      local.get 1
                      i32.load offset=20
                      local.tee 4
                      i32.eqz
                      br_if 0 (;@8;)
                      local.get 1
                      i32.const 20
                      i32.add
                      local.set 5
                      br 1 (;@7;)
                    end
                    local.get 1
                    i32.load offset=16
                    local.tee 4
                    i32.eqz
                    br_if 3 (;@4;)
                    local.get 1
                    i32.const 16
                    i32.add
                    local.set 5
                  end
                  loop ;; label = @7
                    local.get 5
                    local.set 7
                    local.get 4
                    local.tee 2
                    i32.const 20
                    i32.add
                    local.set 5
                    local.get 2
                    i32.load offset=20
                    local.tee 4
                    br_if 0 (;@7;)
                    local.get 2
                    i32.const 16
                    i32.add
                    local.set 5
                    local.get 2
                    i32.load offset=16
                    local.tee 4
                    br_if 0 (;@7;)
                  end
                  local.get 7
                  i32.const 0
                  i32.store
                  br 3 (;@3;)
                end
                local.get 3
                i32.load offset=4
                local.tee 2
                i32.const 3
                i32.and
                i32.const 3
                i32.ne
                br_if 3 (;@2;)
                local.get 3
                local.get 2
                i32.const -2
                i32.and
                i32.store offset=4
                i32.const 0
                local.get 0
                i32.store offset=1058776
                local.get 3
                local.get 0
                i32.store
                local.get 1
                local.get 0
                i32.const 1
                i32.or
                i32.store offset=4
                return
              end
              local.get 2
              local.get 5
              i32.store offset=8
              local.get 5
              local.get 2
              i32.store offset=12
              br 2 (;@2;)
            end
            i32.const 0
            local.set 2
          end
          local.get 6
          i32.eqz
          br_if 0 (;@2;)
          block ;; label = @3
            block ;; label = @4
              local.get 1
              local.get 1
              i32.load offset=28
              local.tee 5
              i32.const 2
              i32.shl
              i32.const 1059072
              i32.add
              local.tee 4
              i32.load
              i32.ne
              br_if 0 (;@4;)
              local.get 4
              local.get 2
              i32.store
              local.get 2
              br_if 1 (;@3;)
              i32.const 0
              i32.const 0
              i32.load offset=1058772
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=1058772
              br 2 (;@2;)
            end
            block ;; label = @4
              block ;; label = @5
                local.get 6
                i32.load offset=16
                local.get 1
                i32.ne
                br_if 0 (;@5;)
                local.get 6
                local.get 2
                i32.store offset=16
                br 1 (;@4;)
              end
              local.get 6
              local.get 2
              i32.store offset=20
            end
            local.get 2
            i32.eqz
            br_if 1 (;@2;)
          end
          local.get 2
          local.get 6
          i32.store offset=24
          block ;; label = @3
            local.get 1
            i32.load offset=16
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 2
            local.get 4
            i32.store offset=16
            local.get 4
            local.get 2
            i32.store offset=24
          end
          local.get 1
          i32.load offset=20
          local.tee 4
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 4
          i32.store offset=20
          local.get 4
          local.get 2
          i32.store offset=24
        end
        local.get 1
        local.get 3
        i32.ge_u
        br_if 0 (;@1;)
        local.get 3
        i32.load offset=4
        local.tee 4
        i32.const 1
        i32.and
        i32.eqz
        br_if 0 (;@1;)
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  local.get 4
                  i32.const 2
                  i32.and
                  br_if 0 (;@6;)
                  block ;; label = @7
                    local.get 3
                    i32.const 0
                    i32.load offset=1058792
                    i32.ne
                    br_if 0 (;@7;)
                    i32.const 0
                    local.get 1
                    i32.store offset=1058792
                    i32.const 0
                    i32.const 0
                    i32.load offset=1058780
                    local.get 0
                    i32.add
                    local.tee 0
                    i32.store offset=1058780
                    local.get 1
                    local.get 0
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 1
                    i32.const 0
                    i32.load offset=1058788
                    i32.ne
                    br_if 6 (;@1;)
                    i32.const 0
                    i32.const 0
                    i32.store offset=1058776
                    i32.const 0
                    i32.const 0
                    i32.store offset=1058788
                    return
                  end
                  block ;; label = @7
                    local.get 3
                    i32.const 0
                    i32.load offset=1058788
                    local.tee 6
                    i32.ne
                    br_if 0 (;@7;)
                    i32.const 0
                    local.get 1
                    i32.store offset=1058788
                    i32.const 0
                    i32.const 0
                    i32.load offset=1058776
                    local.get 0
                    i32.add
                    local.tee 0
                    i32.store offset=1058776
                    local.get 1
                    local.get 0
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 1
                    local.get 0
                    i32.add
                    local.get 0
                    i32.store
                    return
                  end
                  local.get 4
                  i32.const -8
                  i32.and
                  local.get 0
                  i32.add
                  local.set 0
                  local.get 3
                  i32.load offset=12
                  local.set 2
                  block ;; label = @7
                    local.get 4
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@7;)
                    block ;; label = @8
                      local.get 2
                      local.get 3
                      i32.load offset=8
                      local.tee 5
                      i32.ne
                      br_if 0 (;@8;)
                      i32.const 0
                      i32.const 0
                      i32.load offset=1058768
                      i32.const -2
                      local.get 4
                      i32.const 3
                      i32.shr_u
                      i32.rotl
                      i32.and
                      i32.store offset=1058768
                      br 5 (;@3;)
                    end
                    local.get 2
                    local.get 5
                    i32.store offset=8
                    local.get 5
                    local.get 2
                    i32.store offset=12
                    br 4 (;@3;)
                  end
                  local.get 3
                  i32.load offset=24
                  local.set 8
                  block ;; label = @7
                    local.get 2
                    local.get 3
                    i32.eq
                    br_if 0 (;@7;)
                    local.get 3
                    i32.load offset=8
                    local.tee 4
                    local.get 2
                    i32.store offset=12
                    local.get 2
                    local.get 4
                    i32.store offset=8
                    br 3 (;@4;)
                  end
                  block ;; label = @7
                    block ;; label = @8
                      local.get 3
                      i32.load offset=20
                      local.tee 4
                      i32.eqz
                      br_if 0 (;@8;)
                      local.get 3
                      i32.const 20
                      i32.add
                      local.set 5
                      br 1 (;@7;)
                    end
                    local.get 3
                    i32.load offset=16
                    local.tee 4
                    i32.eqz
                    br_if 2 (;@5;)
                    local.get 3
                    i32.const 16
                    i32.add
                    local.set 5
                  end
                  loop ;; label = @7
                    local.get 5
                    local.set 7
                    local.get 4
                    local.tee 2
                    i32.const 20
                    i32.add
                    local.set 5
                    local.get 2
                    i32.load offset=20
                    local.tee 4
                    br_if 0 (;@7;)
                    local.get 2
                    i32.const 16
                    i32.add
                    local.set 5
                    local.get 2
                    i32.load offset=16
                    local.tee 4
                    br_if 0 (;@7;)
                  end
                  local.get 7
                  i32.const 0
                  i32.store
                  br 2 (;@4;)
                end
                local.get 3
                local.get 4
                i32.const -2
                i32.and
                i32.store offset=4
                local.get 1
                local.get 0
                i32.add
                local.get 0
                i32.store
                local.get 1
                local.get 0
                i32.const 1
                i32.or
                i32.store offset=4
                br 3 (;@2;)
              end
              i32.const 0
              local.set 2
            end
            local.get 8
            i32.eqz
            br_if 0 (;@3;)
            block ;; label = @4
              block ;; label = @5
                local.get 3
                local.get 3
                i32.load offset=28
                local.tee 5
                i32.const 2
                i32.shl
                i32.const 1059072
                i32.add
                local.tee 4
                i32.load
                i32.ne
                br_if 0 (;@5;)
                local.get 4
                local.get 2
                i32.store
                local.get 2
                br_if 1 (;@4;)
                i32.const 0
                i32.const 0
                i32.load offset=1058772
                i32.const -2
                local.get 5
                i32.rotl
                i32.and
                i32.store offset=1058772
                br 2 (;@3;)
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 8
                  i32.load offset=16
                  local.get 3
                  i32.ne
                  br_if 0 (;@6;)
                  local.get 8
                  local.get 2
                  i32.store offset=16
                  br 1 (;@5;)
                end
                local.get 8
                local.get 2
                i32.store offset=20
              end
              local.get 2
              i32.eqz
              br_if 1 (;@3;)
            end
            local.get 2
            local.get 8
            i32.store offset=24
            block ;; label = @4
              local.get 3
              i32.load offset=16
              local.tee 4
              i32.eqz
              br_if 0 (;@4;)
              local.get 2
              local.get 4
              i32.store offset=16
              local.get 4
              local.get 2
              i32.store offset=24
            end
            local.get 3
            i32.load offset=20
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 2
            local.get 4
            i32.store offset=20
            local.get 4
            local.get 2
            i32.store offset=24
          end
          local.get 1
          local.get 0
          i32.add
          local.get 0
          i32.store
          local.get 1
          local.get 0
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 1
          local.get 6
          i32.ne
          br_if 0 (;@2;)
          i32.const 0
          local.get 0
          i32.store offset=1058776
          return
        end
        block ;; label = @2
          local.get 0
          i32.const 255
          i32.gt_u
          br_if 0 (;@2;)
          local.get 0
          i32.const -8
          i32.and
          i32.const 1058808
          i32.add
          local.set 2
          block ;; label = @3
            block ;; label = @4
              i32.const 0
              i32.load offset=1058768
              local.tee 4
              i32.const 1
              local.get 0
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 0
              i32.and
              br_if 0 (;@4;)
              i32.const 0
              local.get 4
              local.get 0
              i32.or
              i32.store offset=1058768
              local.get 2
              local.set 0
              br 1 (;@3;)
            end
            local.get 2
            i32.load offset=8
            local.set 0
          end
          local.get 0
          local.get 1
          i32.store offset=12
          local.get 2
          local.get 1
          i32.store offset=8
          local.get 1
          local.get 2
          i32.store offset=12
          local.get 1
          local.get 0
          i32.store offset=8
          return
        end
        i32.const 31
        local.set 2
        block ;; label = @2
          local.get 0
          i32.const 16777215
          i32.gt_u
          br_if 0 (;@2;)
          local.get 0
          i32.const 38
          local.get 0
          i32.const 8
          i32.shr_u
          i32.clz
          local.tee 2
          i32.sub
          i32.shr_u
          i32.const 1
          i32.and
          local.get 2
          i32.const 1
          i32.shl
          i32.sub
          i32.const 62
          i32.add
          local.set 2
        end
        local.get 1
        local.get 2
        i32.store offset=28
        local.get 1
        i64.const 0
        i64.store offset=16 align=4
        local.get 2
        i32.const 2
        i32.shl
        i32.const 1059072
        i32.add
        local.set 5
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                i32.const 0
                i32.load offset=1058772
                local.tee 4
                i32.const 1
                local.get 2
                i32.shl
                local.tee 3
                i32.and
                br_if 0 (;@5;)
                local.get 5
                local.get 1
                i32.store
                i32.const 0
                local.get 4
                local.get 3
                i32.or
                i32.store offset=1058772
                i32.const 8
                local.set 0
                i32.const 24
                local.set 2
                br 1 (;@4;)
              end
              local.get 0
              i32.const 0
              i32.const 25
              local.get 2
              i32.const 1
              i32.shr_u
              i32.sub
              local.get 2
              i32.const 31
              i32.eq
              select
              i32.shl
              local.set 2
              local.get 5
              i32.load
              local.set 5
              loop ;; label = @5
                local.get 5
                local.tee 4
                i32.load offset=4
                i32.const -8
                i32.and
                local.get 0
                i32.eq
                br_if 2 (;@3;)
                local.get 2
                i32.const 29
                i32.shr_u
                local.set 5
                local.get 2
                i32.const 1
                i32.shl
                local.set 2
                local.get 4
                local.get 5
                i32.const 4
                i32.and
                i32.add
                local.tee 3
                i32.load offset=16
                local.tee 5
                br_if 0 (;@5;)
              end
              local.get 3
              i32.const 16
              i32.add
              local.get 1
              i32.store
              i32.const 8
              local.set 0
              i32.const 24
              local.set 2
              local.get 4
              local.set 5
            end
            local.get 1
            local.set 4
            local.get 1
            local.set 3
            br 1 (;@2;)
          end
          local.get 4
          i32.load offset=8
          local.tee 5
          local.get 1
          i32.store offset=12
          local.get 4
          local.get 1
          i32.store offset=8
          i32.const 0
          local.set 3
          i32.const 24
          local.set 0
          i32.const 8
          local.set 2
        end
        local.get 1
        local.get 2
        i32.add
        local.get 5
        i32.store
        local.get 1
        local.get 4
        i32.store offset=12
        local.get 1
        local.get 0
        i32.add
        local.get 3
        i32.store
        i32.const 0
        i32.const 0
        i32.load offset=1058800
        i32.const -1
        i32.add
        local.tee 1
        i32.const -1
        local.get 1
        select
        i32.store offset=1058800
      end
    )
    (func $calloc (;144;) (type 2) (param i32 i32) (result i32)
      (local i32 i64)
      block ;; label = @1
        block ;; label = @2
          local.get 0
          br_if 0 (;@2;)
          i32.const 0
          local.set 2
          br 1 (;@1;)
        end
        local.get 0
        i64.extend_i32_u
        local.get 1
        i64.extend_i32_u
        i64.mul
        local.tee 3
        i32.wrap_i64
        local.set 2
        local.get 1
        local.get 0
        i32.or
        i32.const 65536
        i32.lt_u
        br_if 0 (;@1;)
        i32.const -1
        local.get 2
        local.get 3
        i64.const 32
        i64.shr_u
        i32.wrap_i64
        i32.const 0
        i32.ne
        select
        local.set 2
      end
      block ;; label = @1
        local.get 2
        call $dlmalloc
        local.tee 0
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.const -4
        i32.add
        i32.load8_u
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@1;)
        local.get 2
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.const 0
        local.get 2
        memory.fill
      end
      local.get 0
    )
    (func $realloc (;145;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
      block ;; label = @1
        local.get 0
        br_if 0 (;@1;)
        local.get 1
        call $dlmalloc
        return
      end
      block ;; label = @1
        local.get 1
        i32.const -64
        i32.lt_u
        br_if 0 (;@1;)
        i32.const 0
        i32.const 48
        i32.store offset=1059264
        i32.const 0
        return
      end
      i32.const 16
      local.get 1
      i32.const 19
      i32.add
      i32.const -16
      i32.and
      local.get 1
      i32.const 11
      i32.lt_u
      select
      local.set 2
      local.get 0
      i32.const -4
      i32.add
      local.tee 3
      i32.load
      local.tee 4
      i32.const -8
      i32.and
      local.set 5
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 4
            i32.const 3
            i32.and
            br_if 0 (;@3;)
            local.get 2
            i32.const 256
            i32.lt_u
            br_if 1 (;@2;)
            local.get 5
            local.get 2
            i32.const 4
            i32.or
            i32.lt_u
            br_if 1 (;@2;)
            local.get 5
            local.get 2
            i32.sub
            i32.const 0
            i32.load offset=1059248
            i32.const 1
            i32.shl
            i32.le_u
            br_if 2 (;@1;)
            br 1 (;@2;)
          end
          local.get 0
          i32.const -8
          i32.add
          local.tee 6
          local.get 5
          i32.add
          local.set 7
          block ;; label = @3
            local.get 5
            local.get 2
            i32.lt_u
            br_if 0 (;@3;)
            local.get 5
            local.get 2
            i32.sub
            local.tee 1
            i32.const 16
            i32.lt_u
            br_if 2 (;@1;)
            local.get 3
            local.get 2
            local.get 4
            i32.const 1
            i32.and
            i32.or
            i32.const 2
            i32.or
            i32.store
            local.get 6
            local.get 2
            i32.add
            local.tee 2
            local.get 1
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 7
            local.get 7
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 2
            local.get 1
            call $dispose_chunk
            local.get 0
            return
          end
          block ;; label = @3
            local.get 7
            i32.const 0
            i32.load offset=1058792
            i32.ne
            br_if 0 (;@3;)
            i32.const 0
            i32.load offset=1058780
            local.get 5
            i32.add
            local.tee 5
            local.get 2
            i32.le_u
            br_if 1 (;@2;)
            local.get 3
            local.get 2
            local.get 4
            i32.const 1
            i32.and
            i32.or
            i32.const 2
            i32.or
            i32.store
            i32.const 0
            local.get 6
            local.get 2
            i32.add
            local.tee 1
            i32.store offset=1058792
            i32.const 0
            local.get 5
            local.get 2
            i32.sub
            local.tee 2
            i32.store offset=1058780
            local.get 1
            local.get 2
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 0
            return
          end
          block ;; label = @3
            local.get 7
            i32.const 0
            i32.load offset=1058788
            i32.ne
            br_if 0 (;@3;)
            i32.const 0
            i32.load offset=1058776
            local.get 5
            i32.add
            local.tee 5
            local.get 2
            i32.lt_u
            br_if 1 (;@2;)
            block ;; label = @4
              block ;; label = @5
                local.get 5
                local.get 2
                i32.sub
                local.tee 1
                i32.const 16
                i32.lt_u
                br_if 0 (;@5;)
                local.get 3
                local.get 2
                local.get 4
                i32.const 1
                i32.and
                i32.or
                i32.const 2
                i32.or
                i32.store
                local.get 6
                local.get 2
                i32.add
                local.tee 2
                local.get 1
                i32.const 1
                i32.or
                i32.store offset=4
                local.get 6
                local.get 5
                i32.add
                local.tee 5
                local.get 1
                i32.store
                local.get 5
                local.get 5
                i32.load offset=4
                i32.const -2
                i32.and
                i32.store offset=4
                br 1 (;@4;)
              end
              local.get 3
              local.get 4
              i32.const 1
              i32.and
              local.get 5
              i32.or
              i32.const 2
              i32.or
              i32.store
              local.get 6
              local.get 5
              i32.add
              local.tee 1
              local.get 1
              i32.load offset=4
              i32.const 1
              i32.or
              i32.store offset=4
              i32.const 0
              local.set 1
              i32.const 0
              local.set 2
            end
            i32.const 0
            local.get 2
            i32.store offset=1058788
            i32.const 0
            local.get 1
            i32.store offset=1058776
            local.get 0
            return
          end
          local.get 7
          i32.load offset=4
          local.tee 8
          i32.const 2
          i32.and
          br_if 0 (;@2;)
          local.get 8
          i32.const -8
          i32.and
          local.get 5
          i32.add
          local.tee 9
          local.get 2
          i32.lt_u
          br_if 0 (;@2;)
          local.get 9
          local.get 2
          i32.sub
          local.set 10
          local.get 7
          i32.load offset=12
          local.set 1
          block ;; label = @3
            block ;; label = @4
              local.get 8
              i32.const 255
              i32.gt_u
              br_if 0 (;@4;)
              block ;; label = @5
                local.get 1
                local.get 7
                i32.load offset=8
                local.tee 5
                i32.ne
                br_if 0 (;@5;)
                i32.const 0
                i32.const 0
                i32.load offset=1058768
                i32.const -2
                local.get 8
                i32.const 3
                i32.shr_u
                i32.rotl
                i32.and
                i32.store offset=1058768
                br 2 (;@3;)
              end
              local.get 1
              local.get 5
              i32.store offset=8
              local.get 5
              local.get 1
              i32.store offset=12
              br 1 (;@3;)
            end
            local.get 7
            i32.load offset=24
            local.set 11
            block ;; label = @4
              block ;; label = @5
                local.get 1
                local.get 7
                i32.eq
                br_if 0 (;@5;)
                local.get 7
                i32.load offset=8
                local.tee 5
                local.get 1
                i32.store offset=12
                local.get 1
                local.get 5
                i32.store offset=8
                br 1 (;@4;)
              end
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 7
                    i32.load offset=20
                    local.tee 5
                    i32.eqz
                    br_if 0 (;@7;)
                    local.get 7
                    i32.const 20
                    i32.add
                    local.set 8
                    br 1 (;@6;)
                  end
                  local.get 7
                  i32.load offset=16
                  local.tee 5
                  i32.eqz
                  br_if 1 (;@5;)
                  local.get 7
                  i32.const 16
                  i32.add
                  local.set 8
                end
                loop ;; label = @6
                  local.get 8
                  local.set 12
                  local.get 5
                  local.tee 1
                  i32.const 20
                  i32.add
                  local.set 8
                  local.get 1
                  i32.load offset=20
                  local.tee 5
                  br_if 0 (;@6;)
                  local.get 1
                  i32.const 16
                  i32.add
                  local.set 8
                  local.get 1
                  i32.load offset=16
                  local.tee 5
                  br_if 0 (;@6;)
                end
                local.get 12
                i32.const 0
                i32.store
                br 1 (;@4;)
              end
              i32.const 0
              local.set 1
            end
            local.get 11
            i32.eqz
            br_if 0 (;@3;)
            block ;; label = @4
              block ;; label = @5
                local.get 7
                local.get 7
                i32.load offset=28
                local.tee 8
                i32.const 2
                i32.shl
                i32.const 1059072
                i32.add
                local.tee 5
                i32.load
                i32.ne
                br_if 0 (;@5;)
                local.get 5
                local.get 1
                i32.store
                local.get 1
                br_if 1 (;@4;)
                i32.const 0
                i32.const 0
                i32.load offset=1058772
                i32.const -2
                local.get 8
                i32.rotl
                i32.and
                i32.store offset=1058772
                br 2 (;@3;)
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 11
                  i32.load offset=16
                  local.get 7
                  i32.ne
                  br_if 0 (;@6;)
                  local.get 11
                  local.get 1
                  i32.store offset=16
                  br 1 (;@5;)
                end
                local.get 11
                local.get 1
                i32.store offset=20
              end
              local.get 1
              i32.eqz
              br_if 1 (;@3;)
            end
            local.get 1
            local.get 11
            i32.store offset=24
            block ;; label = @4
              local.get 7
              i32.load offset=16
              local.tee 5
              i32.eqz
              br_if 0 (;@4;)
              local.get 1
              local.get 5
              i32.store offset=16
              local.get 5
              local.get 1
              i32.store offset=24
            end
            local.get 7
            i32.load offset=20
            local.tee 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            local.get 5
            i32.store offset=20
            local.get 5
            local.get 1
            i32.store offset=24
          end
          block ;; label = @3
            local.get 10
            i32.const 15
            i32.gt_u
            br_if 0 (;@3;)
            local.get 3
            local.get 4
            i32.const 1
            i32.and
            local.get 9
            i32.or
            i32.const 2
            i32.or
            i32.store
            local.get 6
            local.get 9
            i32.add
            local.tee 1
            local.get 1
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 0
            return
          end
          local.get 3
          local.get 2
          local.get 4
          i32.const 1
          i32.and
          i32.or
          i32.const 2
          i32.or
          i32.store
          local.get 6
          local.get 2
          i32.add
          local.tee 1
          local.get 10
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 6
          local.get 9
          i32.add
          local.tee 2
          local.get 2
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 1
          local.get 10
          call $dispose_chunk
          local.get 0
          return
        end
        block ;; label = @2
          local.get 1
          call $dlmalloc
          local.tee 2
          br_if 0 (;@2;)
          i32.const 0
          return
        end
        block ;; label = @2
          i32.const -4
          i32.const -8
          local.get 3
          i32.load
          local.tee 5
          i32.const 3
          i32.and
          select
          local.get 5
          i32.const -8
          i32.and
          i32.add
          local.tee 5
          local.get 1
          local.get 5
          local.get 1
          i32.lt_u
          select
          local.tee 1
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 0
          local.get 1
          memory.copy
        end
        local.get 0
        call $dlfree
        local.get 2
        local.set 0
      end
      local.get 0
    )
    (func $dispose_chunk (;146;) (type 1) (param i32 i32)
      (local i32 i32 i32 i32 i32 i32 i32)
      local.get 0
      local.get 1
      i32.add
      local.set 2
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.load offset=4
          local.tee 3
          i32.const 1
          i32.and
          br_if 0 (;@2;)
          local.get 3
          i32.const 2
          i32.and
          i32.eqz
          br_if 1 (;@1;)
          local.get 0
          i32.load
          local.tee 4
          local.get 1
          i32.add
          local.set 1
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  local.get 0
                  local.get 4
                  i32.sub
                  local.tee 0
                  i32.const 0
                  i32.load offset=1058788
                  i32.eq
                  br_if 0 (;@6;)
                  local.get 0
                  i32.load offset=12
                  local.set 3
                  block ;; label = @7
                    local.get 4
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@7;)
                    local.get 3
                    local.get 0
                    i32.load offset=8
                    local.tee 5
                    i32.ne
                    br_if 2 (;@5;)
                    i32.const 0
                    i32.const 0
                    i32.load offset=1058768
                    i32.const -2
                    local.get 4
                    i32.const 3
                    i32.shr_u
                    i32.rotl
                    i32.and
                    i32.store offset=1058768
                    br 5 (;@2;)
                  end
                  local.get 0
                  i32.load offset=24
                  local.set 6
                  block ;; label = @7
                    local.get 3
                    local.get 0
                    i32.eq
                    br_if 0 (;@7;)
                    local.get 0
                    i32.load offset=8
                    local.tee 4
                    local.get 3
                    i32.store offset=12
                    local.get 3
                    local.get 4
                    i32.store offset=8
                    br 4 (;@3;)
                  end
                  block ;; label = @7
                    block ;; label = @8
                      local.get 0
                      i32.load offset=20
                      local.tee 4
                      i32.eqz
                      br_if 0 (;@8;)
                      local.get 0
                      i32.const 20
                      i32.add
                      local.set 5
                      br 1 (;@7;)
                    end
                    local.get 0
                    i32.load offset=16
                    local.tee 4
                    i32.eqz
                    br_if 3 (;@4;)
                    local.get 0
                    i32.const 16
                    i32.add
                    local.set 5
                  end
                  loop ;; label = @7
                    local.get 5
                    local.set 7
                    local.get 4
                    local.tee 3
                    i32.const 20
                    i32.add
                    local.set 5
                    local.get 3
                    i32.load offset=20
                    local.tee 4
                    br_if 0 (;@7;)
                    local.get 3
                    i32.const 16
                    i32.add
                    local.set 5
                    local.get 3
                    i32.load offset=16
                    local.tee 4
                    br_if 0 (;@7;)
                  end
                  local.get 7
                  i32.const 0
                  i32.store
                  br 3 (;@3;)
                end
                local.get 2
                i32.load offset=4
                local.tee 3
                i32.const 3
                i32.and
                i32.const 3
                i32.ne
                br_if 3 (;@2;)
                local.get 2
                local.get 3
                i32.const -2
                i32.and
                i32.store offset=4
                i32.const 0
                local.get 1
                i32.store offset=1058776
                local.get 2
                local.get 1
                i32.store
                local.get 0
                local.get 1
                i32.const 1
                i32.or
                i32.store offset=4
                return
              end
              local.get 3
              local.get 5
              i32.store offset=8
              local.get 5
              local.get 3
              i32.store offset=12
              br 2 (;@2;)
            end
            i32.const 0
            local.set 3
          end
          local.get 6
          i32.eqz
          br_if 0 (;@2;)
          block ;; label = @3
            block ;; label = @4
              local.get 0
              local.get 0
              i32.load offset=28
              local.tee 5
              i32.const 2
              i32.shl
              i32.const 1059072
              i32.add
              local.tee 4
              i32.load
              i32.ne
              br_if 0 (;@4;)
              local.get 4
              local.get 3
              i32.store
              local.get 3
              br_if 1 (;@3;)
              i32.const 0
              i32.const 0
              i32.load offset=1058772
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=1058772
              br 2 (;@2;)
            end
            block ;; label = @4
              block ;; label = @5
                local.get 6
                i32.load offset=16
                local.get 0
                i32.ne
                br_if 0 (;@5;)
                local.get 6
                local.get 3
                i32.store offset=16
                br 1 (;@4;)
              end
              local.get 6
              local.get 3
              i32.store offset=20
            end
            local.get 3
            i32.eqz
            br_if 1 (;@2;)
          end
          local.get 3
          local.get 6
          i32.store offset=24
          block ;; label = @3
            local.get 0
            i32.load offset=16
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 3
            local.get 4
            i32.store offset=16
            local.get 4
            local.get 3
            i32.store offset=24
          end
          local.get 0
          i32.load offset=20
          local.tee 4
          i32.eqz
          br_if 0 (;@2;)
          local.get 3
          local.get 4
          i32.store offset=20
          local.get 4
          local.get 3
          i32.store offset=24
        end
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  local.get 2
                  i32.load offset=4
                  local.tee 4
                  i32.const 2
                  i32.and
                  br_if 0 (;@6;)
                  block ;; label = @7
                    local.get 2
                    i32.const 0
                    i32.load offset=1058792
                    i32.ne
                    br_if 0 (;@7;)
                    i32.const 0
                    local.get 0
                    i32.store offset=1058792
                    i32.const 0
                    i32.const 0
                    i32.load offset=1058780
                    local.get 1
                    i32.add
                    local.tee 1
                    i32.store offset=1058780
                    local.get 0
                    local.get 1
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 0
                    i32.const 0
                    i32.load offset=1058788
                    i32.ne
                    br_if 6 (;@1;)
                    i32.const 0
                    i32.const 0
                    i32.store offset=1058776
                    i32.const 0
                    i32.const 0
                    i32.store offset=1058788
                    return
                  end
                  block ;; label = @7
                    local.get 2
                    i32.const 0
                    i32.load offset=1058788
                    local.tee 6
                    i32.ne
                    br_if 0 (;@7;)
                    i32.const 0
                    local.get 0
                    i32.store offset=1058788
                    i32.const 0
                    i32.const 0
                    i32.load offset=1058776
                    local.get 1
                    i32.add
                    local.tee 1
                    i32.store offset=1058776
                    local.get 0
                    local.get 1
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    local.get 0
                    local.get 1
                    i32.add
                    local.get 1
                    i32.store
                    return
                  end
                  local.get 4
                  i32.const -8
                  i32.and
                  local.get 1
                  i32.add
                  local.set 1
                  local.get 2
                  i32.load offset=12
                  local.set 3
                  block ;; label = @7
                    local.get 4
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@7;)
                    block ;; label = @8
                      local.get 3
                      local.get 2
                      i32.load offset=8
                      local.tee 5
                      i32.ne
                      br_if 0 (;@8;)
                      i32.const 0
                      i32.const 0
                      i32.load offset=1058768
                      i32.const -2
                      local.get 4
                      i32.const 3
                      i32.shr_u
                      i32.rotl
                      i32.and
                      i32.store offset=1058768
                      br 5 (;@3;)
                    end
                    local.get 3
                    local.get 5
                    i32.store offset=8
                    local.get 5
                    local.get 3
                    i32.store offset=12
                    br 4 (;@3;)
                  end
                  local.get 2
                  i32.load offset=24
                  local.set 8
                  block ;; label = @7
                    local.get 3
                    local.get 2
                    i32.eq
                    br_if 0 (;@7;)
                    local.get 2
                    i32.load offset=8
                    local.tee 4
                    local.get 3
                    i32.store offset=12
                    local.get 3
                    local.get 4
                    i32.store offset=8
                    br 3 (;@4;)
                  end
                  block ;; label = @7
                    block ;; label = @8
                      local.get 2
                      i32.load offset=20
                      local.tee 4
                      i32.eqz
                      br_if 0 (;@8;)
                      local.get 2
                      i32.const 20
                      i32.add
                      local.set 5
                      br 1 (;@7;)
                    end
                    local.get 2
                    i32.load offset=16
                    local.tee 4
                    i32.eqz
                    br_if 2 (;@5;)
                    local.get 2
                    i32.const 16
                    i32.add
                    local.set 5
                  end
                  loop ;; label = @7
                    local.get 5
                    local.set 7
                    local.get 4
                    local.tee 3
                    i32.const 20
                    i32.add
                    local.set 5
                    local.get 3
                    i32.load offset=20
                    local.tee 4
                    br_if 0 (;@7;)
                    local.get 3
                    i32.const 16
                    i32.add
                    local.set 5
                    local.get 3
                    i32.load offset=16
                    local.tee 4
                    br_if 0 (;@7;)
                  end
                  local.get 7
                  i32.const 0
                  i32.store
                  br 2 (;@4;)
                end
                local.get 2
                local.get 4
                i32.const -2
                i32.and
                i32.store offset=4
                local.get 0
                local.get 1
                i32.add
                local.get 1
                i32.store
                local.get 0
                local.get 1
                i32.const 1
                i32.or
                i32.store offset=4
                br 3 (;@2;)
              end
              i32.const 0
              local.set 3
            end
            local.get 8
            i32.eqz
            br_if 0 (;@3;)
            block ;; label = @4
              block ;; label = @5
                local.get 2
                local.get 2
                i32.load offset=28
                local.tee 5
                i32.const 2
                i32.shl
                i32.const 1059072
                i32.add
                local.tee 4
                i32.load
                i32.ne
                br_if 0 (;@5;)
                local.get 4
                local.get 3
                i32.store
                local.get 3
                br_if 1 (;@4;)
                i32.const 0
                i32.const 0
                i32.load offset=1058772
                i32.const -2
                local.get 5
                i32.rotl
                i32.and
                i32.store offset=1058772
                br 2 (;@3;)
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 8
                  i32.load offset=16
                  local.get 2
                  i32.ne
                  br_if 0 (;@6;)
                  local.get 8
                  local.get 3
                  i32.store offset=16
                  br 1 (;@5;)
                end
                local.get 8
                local.get 3
                i32.store offset=20
              end
              local.get 3
              i32.eqz
              br_if 1 (;@3;)
            end
            local.get 3
            local.get 8
            i32.store offset=24
            block ;; label = @4
              local.get 2
              i32.load offset=16
              local.tee 4
              i32.eqz
              br_if 0 (;@4;)
              local.get 3
              local.get 4
              i32.store offset=16
              local.get 4
              local.get 3
              i32.store offset=24
            end
            local.get 2
            i32.load offset=20
            local.tee 4
            i32.eqz
            br_if 0 (;@3;)
            local.get 3
            local.get 4
            i32.store offset=20
            local.get 4
            local.get 3
            i32.store offset=24
          end
          local.get 0
          local.get 1
          i32.add
          local.get 1
          i32.store
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          local.get 6
          i32.ne
          br_if 0 (;@2;)
          i32.const 0
          local.get 1
          i32.store offset=1058776
          return
        end
        block ;; label = @2
          local.get 1
          i32.const 255
          i32.gt_u
          br_if 0 (;@2;)
          local.get 1
          i32.const -8
          i32.and
          i32.const 1058808
          i32.add
          local.set 3
          block ;; label = @3
            block ;; label = @4
              i32.const 0
              i32.load offset=1058768
              local.tee 4
              i32.const 1
              local.get 1
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 1
              i32.and
              br_if 0 (;@4;)
              i32.const 0
              local.get 4
              local.get 1
              i32.or
              i32.store offset=1058768
              local.get 3
              local.set 1
              br 1 (;@3;)
            end
            local.get 3
            i32.load offset=8
            local.set 1
          end
          local.get 1
          local.get 0
          i32.store offset=12
          local.get 3
          local.get 0
          i32.store offset=8
          local.get 0
          local.get 3
          i32.store offset=12
          local.get 0
          local.get 1
          i32.store offset=8
          return
        end
        i32.const 31
        local.set 3
        block ;; label = @2
          local.get 1
          i32.const 16777215
          i32.gt_u
          br_if 0 (;@2;)
          local.get 1
          i32.const 38
          local.get 1
          i32.const 8
          i32.shr_u
          i32.clz
          local.tee 3
          i32.sub
          i32.shr_u
          i32.const 1
          i32.and
          local.get 3
          i32.const 1
          i32.shl
          i32.sub
          i32.const 62
          i32.add
          local.set 3
        end
        local.get 0
        local.get 3
        i32.store offset=28
        local.get 0
        i64.const 0
        i64.store offset=16 align=4
        local.get 3
        i32.const 2
        i32.shl
        i32.const 1059072
        i32.add
        local.set 4
        block ;; label = @2
          i32.const 0
          i32.load offset=1058772
          local.tee 5
          i32.const 1
          local.get 3
          i32.shl
          local.tee 2
          i32.and
          br_if 0 (;@2;)
          local.get 4
          local.get 0
          i32.store
          i32.const 0
          local.get 5
          local.get 2
          i32.or
          i32.store offset=1058772
          local.get 0
          local.get 4
          i32.store offset=24
          local.get 0
          local.get 0
          i32.store offset=8
          local.get 0
          local.get 0
          i32.store offset=12
          return
        end
        local.get 1
        i32.const 0
        i32.const 25
        local.get 3
        i32.const 1
        i32.shr_u
        i32.sub
        local.get 3
        i32.const 31
        i32.eq
        select
        i32.shl
        local.set 3
        local.get 4
        i32.load
        local.set 5
        block ;; label = @2
          loop ;; label = @3
            local.get 5
            local.tee 4
            i32.load offset=4
            i32.const -8
            i32.and
            local.get 1
            i32.eq
            br_if 1 (;@2;)
            local.get 3
            i32.const 29
            i32.shr_u
            local.set 5
            local.get 3
            i32.const 1
            i32.shl
            local.set 3
            local.get 4
            local.get 5
            i32.const 4
            i32.and
            i32.add
            local.tee 2
            i32.load offset=16
            local.tee 5
            br_if 0 (;@3;)
          end
          local.get 2
          i32.const 16
          i32.add
          local.get 0
          i32.store
          local.get 0
          local.get 4
          i32.store offset=24
          local.get 0
          local.get 0
          i32.store offset=12
          local.get 0
          local.get 0
          i32.store offset=8
          return
        end
        local.get 4
        i32.load offset=8
        local.tee 1
        local.get 0
        i32.store offset=12
        local.get 4
        local.get 0
        i32.store offset=8
        local.get 0
        i32.const 0
        i32.store offset=24
        local.get 0
        local.get 4
        i32.store offset=12
        local.get 0
        local.get 1
        i32.store offset=8
      end
    )
    (func $posix_memalign (;147;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.const 16
            i32.ne
            br_if 0 (;@3;)
            local.get 2
            call $dlmalloc
            local.set 1
            br 1 (;@2;)
          end
          i32.const 28
          local.set 3
          local.get 1
          i32.const 4
          i32.lt_u
          br_if 1 (;@1;)
          local.get 1
          i32.const 3
          i32.and
          br_if 1 (;@1;)
          local.get 1
          i32.const 2
          i32.shr_u
          local.tee 4
          local.get 4
          i32.const -1
          i32.add
          i32.and
          br_if 1 (;@1;)
          block ;; label = @3
            local.get 2
            i32.const -64
            local.get 1
            i32.sub
            i32.le_u
            br_if 0 (;@3;)
            i32.const 48
            return
          end
          local.get 1
          i32.const 16
          local.get 1
          i32.const 16
          i32.gt_u
          select
          local.get 2
          call $internal_memalign
          local.set 1
        end
        block ;; label = @2
          local.get 1
          br_if 0 (;@2;)
          i32.const 48
          return
        end
        local.get 0
        local.get 1
        i32.store
        i32.const 0
        local.set 3
      end
      local.get 3
    )
    (func $internal_memalign (;148;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.const 16
          local.get 0
          i32.const 16
          i32.gt_u
          select
          local.tee 2
          local.get 2
          i32.const -1
          i32.add
          i32.and
          br_if 0 (;@2;)
          local.get 2
          local.set 0
          br 1 (;@1;)
        end
        i32.const 32
        local.set 3
        loop ;; label = @2
          local.get 3
          local.tee 0
          i32.const 1
          i32.shl
          local.set 3
          local.get 0
          local.get 2
          i32.lt_u
          br_if 0 (;@2;)
        end
      end
      block ;; label = @1
        local.get 1
        i32.const -64
        local.get 0
        i32.sub
        i32.lt_u
        br_if 0 (;@1;)
        i32.const 0
        i32.const 48
        i32.store offset=1059264
        i32.const 0
        return
      end
      block ;; label = @1
        local.get 0
        i32.const 16
        local.get 1
        i32.const 19
        i32.add
        i32.const -16
        i32.and
        local.get 1
        i32.const 11
        i32.lt_u
        select
        local.tee 1
        i32.add
        i32.const 12
        i32.add
        call $dlmalloc
        local.tee 3
        br_if 0 (;@1;)
        i32.const 0
        return
      end
      local.get 3
      i32.const -8
      i32.add
      local.set 2
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.const -1
          i32.add
          local.get 3
          i32.and
          br_if 0 (;@2;)
          local.get 2
          local.set 0
          br 1 (;@1;)
        end
        local.get 3
        i32.const -4
        i32.add
        local.tee 4
        i32.load
        local.tee 5
        i32.const -8
        i32.and
        local.get 3
        local.get 0
        i32.add
        i32.const -1
        i32.add
        i32.const 0
        local.get 0
        i32.sub
        i32.and
        i32.const -8
        i32.add
        local.tee 3
        i32.const 0
        local.get 0
        local.get 3
        local.get 2
        i32.sub
        i32.const 15
        i32.gt_u
        select
        i32.add
        local.tee 0
        local.get 2
        i32.sub
        local.tee 3
        i32.sub
        local.set 6
        block ;; label = @2
          local.get 5
          i32.const 3
          i32.and
          br_if 0 (;@2;)
          local.get 0
          local.get 6
          i32.store offset=4
          local.get 0
          local.get 2
          i32.load
          local.get 3
          i32.add
          i32.store
          br 1 (;@1;)
        end
        local.get 0
        local.get 6
        local.get 0
        i32.load offset=4
        i32.const 1
        i32.and
        i32.or
        i32.const 2
        i32.or
        i32.store offset=4
        local.get 0
        local.get 6
        i32.add
        local.tee 6
        local.get 6
        i32.load offset=4
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 4
        local.get 3
        local.get 4
        i32.load
        i32.const 1
        i32.and
        i32.or
        i32.const 2
        i32.or
        i32.store
        local.get 2
        local.get 3
        i32.add
        local.tee 6
        local.get 6
        i32.load offset=4
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 2
        local.get 3
        call $dispose_chunk
      end
      block ;; label = @1
        local.get 0
        i32.load offset=4
        local.tee 3
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@1;)
        local.get 3
        i32.const -8
        i32.and
        local.tee 2
        local.get 1
        i32.const 16
        i32.add
        i32.le_u
        br_if 0 (;@1;)
        local.get 0
        local.get 1
        local.get 3
        i32.const 1
        i32.and
        i32.or
        i32.const 2
        i32.or
        i32.store offset=4
        local.get 0
        local.get 1
        i32.add
        local.tee 3
        local.get 2
        local.get 1
        i32.sub
        local.tee 1
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 0
        local.get 2
        i32.add
        local.tee 2
        local.get 2
        i32.load offset=4
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 3
        local.get 1
        call $dispose_chunk
      end
      local.get 0
      i32.const 8
      i32.add
    )
    (func $_Exit (;149;) (type 0) (param i32)
      local.get 0
      call $__wasi_proc_exit
      unreachable
    )
    (func $__wasilibc_ensure_environ (;150;) (type 7)
      block ;; label = @1
        i32.const 0
        i32.load offset=1058212
        i32.const -1
        i32.ne
        br_if 0 (;@1;)
        call $__wasilibc_initialize_environ
      end
    )
    (func $__wasilibc_initialize_environ (;151;) (type 7)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 0
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.const 12
          i32.add
          local.get 0
          i32.const 8
          i32.add
          call $__wasi_environ_sizes_get
          br_if 0 (;@2;)
          block ;; label = @3
            local.get 0
            i32.load offset=12
            local.tee 1
            br_if 0 (;@3;)
            i32.const 1059268
            local.set 1
            br 2 (;@1;)
          end
          block ;; label = @3
            block ;; label = @4
              local.get 1
              i32.const 1
              i32.add
              local.tee 1
              i32.eqz
              br_if 0 (;@4;)
              local.get 0
              i32.load offset=8
              call $malloc
              local.tee 2
              i32.eqz
              br_if 0 (;@4;)
              local.get 1
              i32.const 4
              call $calloc
              local.tee 1
              br_if 1 (;@3;)
              local.get 2
              call $free
            end
            i32.const 70
            call $_Exit
            unreachable
          end
          local.get 1
          local.get 2
          call $__wasi_environ_get
          i32.eqz
          br_if 1 (;@1;)
          local.get 2
          call $free
          local.get 1
          call $free
        end
        i32.const 71
        call $_Exit
        unreachable
      end
      i32.const 0
      local.get 1
      i32.store offset=1058212
      local.get 0
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $__wasi_environ_get (;152;) (type 2) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      call $__imported_wasi_snapshot_preview1_environ_get
      i32.const 65535
      i32.and
    )
    (func $__wasi_environ_sizes_get (;153;) (type 2) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      call $__imported_wasi_snapshot_preview1_environ_sizes_get
      i32.const 65535
      i32.and
    )
    (func $__wasi_proc_exit (;154;) (type 0) (param i32)
      local.get 0
      call $__imported_wasi_snapshot_preview1_proc_exit
      unreachable
    )
    (func $abort (;155;) (type 7)
      unreachable
    )
    (func $getcwd (;156;) (type 2) (param i32 i32) (result i32)
      (local i32)
      i32.const 0
      i32.load offset=1058216
      local.set 2
      block ;; label = @1
        block ;; label = @2
          local.get 0
          br_if 0 (;@2;)
          local.get 2
          call $strdup
          local.tee 0
          br_if 1 (;@1;)
          i32.const 0
          i32.const 48
          i32.store offset=1059264
          i32.const 0
          return
        end
        block ;; label = @2
          local.get 1
          local.get 2
          call $strlen
          i32.const 1
          i32.add
          i32.ge_u
          br_if 0 (;@2;)
          i32.const 0
          i32.const 68
          i32.store offset=1059264
          i32.const 0
          return
        end
        local.get 0
        local.get 2
        call $strcpy
        local.set 0
      end
      local.get 0
    )
    (func $sbrk (;157;) (type 9) (param i32) (result i32)
      block ;; label = @1
        local.get 0
        br_if 0 (;@1;)
        memory.size
        i32.const 16
        i32.shl
        return
      end
      block ;; label = @1
        local.get 0
        i32.const 65535
        i32.and
        br_if 0 (;@1;)
        local.get 0
        i32.const -1
        i32.le_s
        br_if 0 (;@1;)
        block ;; label = @2
          local.get 0
          i32.const 16
          i32.shr_u
          memory.grow
          local.tee 0
          i32.const -1
          i32.ne
          br_if 0 (;@2;)
          i32.const 0
          i32.const 48
          i32.store offset=1059264
          i32.const -1
          return
        end
        local.get 0
        i32.const 16
        i32.shl
        return
      end
      call $abort
      unreachable
    )
    (func $getenv (;158;) (type 9) (param i32) (result i32)
      (local i32 i32 i32 i32)
      call $__wasilibc_ensure_environ
      block ;; label = @1
        local.get 0
        i32.const 61
        call $__strchrnul
        local.tee 1
        local.get 0
        i32.ne
        br_if 0 (;@1;)
        i32.const 0
        return
      end
      i32.const 0
      local.set 2
      block ;; label = @1
        local.get 0
        local.get 1
        local.get 0
        i32.sub
        local.tee 3
        i32.add
        i32.load8_u
        br_if 0 (;@1;)
        i32.const 0
        i32.load offset=1058212
        local.tee 4
        i32.eqz
        br_if 0 (;@1;)
        local.get 4
        i32.load
        local.tee 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 4
        i32.const 4
        i32.add
        local.set 4
        block ;; label = @2
          loop ;; label = @3
            block ;; label = @4
              local.get 0
              local.get 1
              local.get 3
              call $strncmp
              br_if 0 (;@4;)
              local.get 1
              local.get 3
              i32.add
              local.tee 1
              i32.load8_u
              i32.const 61
              i32.eq
              br_if 2 (;@2;)
            end
            local.get 4
            i32.load
            local.set 1
            local.get 4
            i32.const 4
            i32.add
            local.set 4
            local.get 1
            br_if 0 (;@3;)
            br 2 (;@1;)
          end
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 2
      end
      local.get 2
    )
    (func $dummy (;159;) (type 2) (param i32 i32) (result i32)
      local.get 0
    )
    (func $__lctrans (;160;) (type 2) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      call $dummy
    )
    (func $__strchrnul (;161;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 1
              i32.const 255
              i32.and
              local.tee 2
              i32.eqz
              br_if 0 (;@4;)
              local.get 0
              i32.const 3
              i32.and
              i32.eqz
              br_if 2 (;@2;)
              block ;; label = @5
                local.get 0
                i32.load8_u
                local.tee 3
                br_if 0 (;@5;)
                local.get 0
                return
              end
              local.get 3
              local.get 1
              i32.const 255
              i32.and
              i32.ne
              br_if 1 (;@3;)
              local.get 0
              return
            end
            local.get 0
            local.get 0
            call $strlen
            i32.add
            return
          end
          block ;; label = @3
            local.get 0
            i32.const 1
            i32.add
            local.tee 3
            i32.const 3
            i32.and
            br_if 0 (;@3;)
            local.get 3
            local.set 0
            br 1 (;@2;)
          end
          local.get 3
          i32.load8_u
          local.tee 4
          i32.eqz
          br_if 1 (;@1;)
          local.get 4
          local.get 1
          i32.const 255
          i32.and
          i32.eq
          br_if 1 (;@1;)
          block ;; label = @3
            local.get 0
            i32.const 2
            i32.add
            local.tee 3
            i32.const 3
            i32.and
            br_if 0 (;@3;)
            local.get 3
            local.set 0
            br 1 (;@2;)
          end
          local.get 3
          i32.load8_u
          local.tee 4
          i32.eqz
          br_if 1 (;@1;)
          local.get 4
          local.get 1
          i32.const 255
          i32.and
          i32.eq
          br_if 1 (;@1;)
          block ;; label = @3
            local.get 0
            i32.const 3
            i32.add
            local.tee 3
            i32.const 3
            i32.and
            br_if 0 (;@3;)
            local.get 3
            local.set 0
            br 1 (;@2;)
          end
          local.get 3
          i32.load8_u
          local.tee 4
          i32.eqz
          br_if 1 (;@1;)
          local.get 4
          local.get 1
          i32.const 255
          i32.and
          i32.eq
          br_if 1 (;@1;)
          local.get 0
          i32.const 4
          i32.add
          local.set 0
        end
        block ;; label = @2
          i32.const 16843008
          local.get 0
          i32.load
          local.tee 3
          i32.sub
          local.get 3
          i32.or
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.ne
          br_if 0 (;@2;)
          local.get 2
          i32.const 16843009
          i32.mul
          local.set 2
          loop ;; label = @3
            i32.const 16843008
            local.get 3
            local.get 2
            i32.xor
            local.tee 3
            i32.sub
            local.get 3
            i32.or
            i32.const -2139062144
            i32.and
            i32.const -2139062144
            i32.ne
            br_if 1 (;@2;)
            i32.const 16843008
            local.get 0
            i32.const 4
            i32.add
            local.tee 0
            i32.load
            local.tee 3
            i32.sub
            local.get 3
            i32.or
            i32.const -2139062144
            i32.and
            i32.const -2139062144
            i32.eq
            br_if 0 (;@3;)
          end
        end
        local.get 0
        i32.const -1
        i32.add
        local.set 3
        loop ;; label = @2
          local.get 3
          i32.const 1
          i32.add
          local.tee 3
          i32.load8_u
          local.tee 0
          i32.eqz
          br_if 1 (;@1;)
          local.get 0
          local.get 1
          i32.const 255
          i32.and
          i32.ne
          br_if 0 (;@2;)
        end
      end
      local.get 3
    )
    (func $__stpcpy (;162;) (type 2) (param i32 i32) (result i32)
      (local i32 i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            local.get 0
            i32.xor
            i32.const 3
            i32.and
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            i32.load8_u
            local.set 2
            br 1 (;@2;)
          end
          block ;; label = @3
            local.get 1
            i32.const 3
            i32.and
            i32.eqz
            br_if 0 (;@3;)
            local.get 0
            local.get 1
            i32.load8_u
            local.tee 2
            i32.store8
            block ;; label = @4
              local.get 2
              br_if 0 (;@4;)
              local.get 0
              return
            end
            local.get 0
            i32.const 1
            i32.add
            local.set 3
            block ;; label = @4
              local.get 1
              i32.const 1
              i32.add
              local.tee 2
              i32.const 3
              i32.and
              br_if 0 (;@4;)
              local.get 3
              local.set 0
              local.get 2
              local.set 1
              br 1 (;@3;)
            end
            local.get 3
            local.get 2
            i32.load8_u
            local.tee 2
            i32.store8
            local.get 2
            i32.eqz
            br_if 2 (;@1;)
            local.get 0
            i32.const 2
            i32.add
            local.set 3
            block ;; label = @4
              local.get 1
              i32.const 2
              i32.add
              local.tee 2
              i32.const 3
              i32.and
              br_if 0 (;@4;)
              local.get 3
              local.set 0
              local.get 2
              local.set 1
              br 1 (;@3;)
            end
            local.get 3
            local.get 2
            i32.load8_u
            local.tee 2
            i32.store8
            local.get 2
            i32.eqz
            br_if 2 (;@1;)
            local.get 0
            i32.const 3
            i32.add
            local.set 3
            block ;; label = @4
              local.get 1
              i32.const 3
              i32.add
              local.tee 2
              i32.const 3
              i32.and
              br_if 0 (;@4;)
              local.get 3
              local.set 0
              local.get 2
              local.set 1
              br 1 (;@3;)
            end
            local.get 3
            local.get 2
            i32.load8_u
            local.tee 2
            i32.store8
            local.get 2
            i32.eqz
            br_if 2 (;@1;)
            local.get 0
            i32.const 4
            i32.add
            local.set 0
            local.get 1
            i32.const 4
            i32.add
            local.set 1
          end
          i32.const 16843008
          local.get 1
          i32.load
          local.tee 2
          i32.sub
          local.get 2
          i32.or
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.ne
          br_if 0 (;@2;)
          loop ;; label = @3
            local.get 0
            local.get 2
            i32.store
            local.get 0
            i32.const 4
            i32.add
            local.set 0
            i32.const 16843008
            local.get 1
            i32.const 4
            i32.add
            local.tee 1
            i32.load
            local.tee 2
            i32.sub
            local.get 2
            i32.or
            i32.const -2139062144
            i32.and
            i32.const -2139062144
            i32.eq
            br_if 0 (;@3;)
          end
        end
        local.get 0
        local.get 2
        i32.store8
        block ;; label = @2
          local.get 2
          i32.const 255
          i32.and
          br_if 0 (;@2;)
          local.get 0
          return
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 2
        local.get 0
        local.set 3
        loop ;; label = @2
          local.get 3
          i32.const 1
          i32.add
          local.tee 3
          local.get 2
          i32.load8_u
          local.tee 0
          i32.store8
          local.get 2
          i32.const 1
          i32.add
          local.set 2
          local.get 0
          br_if 0 (;@2;)
        end
      end
      local.get 3
    )
    (func $strcpy (;163;) (type 2) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      call $__stpcpy
      drop
      local.get 0
    )
    (func $strdup (;164;) (type 9) (param i32) (result i32)
      (local i32 i32)
      block ;; label = @1
        local.get 0
        call $strlen
        i32.const 1
        i32.add
        local.tee 1
        call $malloc
        local.tee 2
        i32.eqz
        br_if 0 (;@1;)
        local.get 1
        i32.eqz
        br_if 0 (;@1;)
        local.get 2
        local.get 0
        local.get 1
        memory.copy
      end
      local.get 2
    )
    (func $strerror (;165;) (type 9) (param i32) (result i32)
      (local i32)
      block ;; label = @1
        i32.const 0
        i32.load offset=1059296
        local.tee 1
        br_if 0 (;@1;)
        i32.const 1059272
        local.set 1
        i32.const 0
        i32.const 1059272
        i32.store offset=1059296
      end
      i32.const 0
      local.get 0
      local.get 0
      i32.const 76
      i32.gt_u
      select
      i32.const 1
      i32.shl
      i32.const 1053280
      i32.add
      i32.load16_u
      i32.const 1051720
      i32.add
      local.get 1
      i32.load offset=20
      call $__lctrans
    )
    (func $strerror_r (;166;) (type 4) (param i32 i32 i32) (result i32)
      (local i32)
      block ;; label = @1
        block ;; label = @2
          local.get 0
          call $strerror
          local.tee 3
          call $strlen
          local.tee 0
          local.get 2
          i32.lt_u
          br_if 0 (;@2;)
          i32.const 68
          local.set 0
          local.get 2
          i32.eqz
          br_if 1 (;@1;)
          block ;; label = @3
            local.get 2
            i32.const -1
            i32.add
            local.tee 2
            i32.eqz
            br_if 0 (;@3;)
            local.get 1
            local.get 3
            local.get 2
            memory.copy
          end
          local.get 1
          local.get 2
          i32.add
          i32.const 0
          i32.store8
          i32.const 68
          return
        end
        block ;; label = @2
          local.get 0
          i32.const 1
          i32.add
          local.tee 2
          i32.eqz
          br_if 0 (;@2;)
          local.get 1
          local.get 3
          local.get 2
          memory.copy
        end
        i32.const 0
        local.set 0
      end
      local.get 0
    )
    (func $strlen (;167;) (type 9) (param i32) (result i32)
      (local i32 i32 i32)
      local.get 0
      local.set 1
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@2;)
          block ;; label = @3
            local.get 0
            i32.load8_u
            br_if 0 (;@3;)
            local.get 0
            local.get 0
            i32.sub
            return
          end
          local.get 0
          i32.const 1
          i32.add
          local.tee 1
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@2;)
          local.get 1
          i32.load8_u
          i32.eqz
          br_if 1 (;@1;)
          local.get 0
          i32.const 2
          i32.add
          local.tee 1
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@2;)
          local.get 1
          i32.load8_u
          i32.eqz
          br_if 1 (;@1;)
          local.get 0
          i32.const 3
          i32.add
          local.tee 1
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@2;)
          local.get 1
          i32.load8_u
          i32.eqz
          br_if 1 (;@1;)
          local.get 0
          i32.const 4
          i32.add
          local.tee 1
          i32.const 3
          i32.and
          br_if 1 (;@1;)
        end
        local.get 1
        i32.const -4
        i32.add
        local.set 2
        local.get 1
        i32.const -5
        i32.add
        local.set 1
        loop ;; label = @2
          local.get 1
          i32.const 4
          i32.add
          local.set 1
          i32.const 16843008
          local.get 2
          i32.const 4
          i32.add
          local.tee 2
          i32.load
          local.tee 3
          i32.sub
          local.get 3
          i32.or
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.eq
          br_if 0 (;@2;)
        end
        loop ;; label = @2
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 2
          i32.load8_u
          local.set 3
          local.get 2
          i32.const 1
          i32.add
          local.set 2
          local.get 3
          br_if 0 (;@2;)
        end
      end
      local.get 1
      local.get 0
      i32.sub
    )
    (func $strncmp (;168;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32)
      block ;; label = @1
        local.get 2
        br_if 0 (;@1;)
        i32.const 0
        return
      end
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.load8_u
          local.tee 3
          br_if 0 (;@2;)
          i32.const 0
          local.set 3
          br 1 (;@1;)
        end
        local.get 0
        i32.const 1
        i32.add
        local.set 0
        local.get 2
        i32.const -1
        i32.add
        local.set 2
        block ;; label = @2
          loop ;; label = @3
            local.get 3
            i32.const 255
            i32.and
            local.get 1
            i32.load8_u
            local.tee 4
            i32.ne
            br_if 1 (;@2;)
            local.get 4
            i32.eqz
            br_if 1 (;@2;)
            local.get 2
            i32.const 0
            i32.eq
            br_if 1 (;@2;)
            local.get 2
            i32.const -1
            i32.add
            local.set 2
            local.get 1
            i32.const 1
            i32.add
            local.set 1
            local.get 0
            i32.load8_u
            local.set 3
            local.get 0
            i32.const 1
            i32.add
            local.set 0
            local.get 3
            br_if 0 (;@3;)
          end
          i32.const 0
          local.set 3
        end
        local.get 3
        i32.const 255
        i32.and
        local.set 3
      end
      local.get 3
      local.get 1
      i32.load8_u
      i32.sub
    )
    (func $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E (;169;) (type 3) (param i32 i32 i32)
      block ;; label = @1
        local.get 0
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        local.get 1
        call $_ZN5alloc5alloc18handle_alloc_error17h2e6feec2f4ff6c76E
        unreachable
      end
      local.get 2
      call $_ZN5alloc7raw_vec17capacity_overflow17hf680bd30c0059d32E
      unreachable
    )
    (func $_ZN254_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Debug$GT$3fmt17hb289d71b75f755f0E (;170;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.get 1
      call $_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17ha291052cff50cef2E
    )
    (func $_ZN256_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Display$GT$3fmt17h16c225a516a71df2E (;171;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.get 1
      call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h3b63b9c35892d81bE
    )
    (func $_ZN5alloc5alloc18handle_alloc_error17h2e6feec2f4ff6c76E (;172;) (type 1) (param i32 i32)
      local.get 1
      local.get 0
      call $_RNvCskdKJRKLKjqM_7___rustc26___rust_alloc_error_handler
      unreachable
    )
    (func $_ZN5alloc3ffi5c_str7CString19_from_vec_unchecked17h309a94a22f342856E (;173;) (type 1) (param i32 i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        local.get 1
        i32.load
        local.tee 3
        local.get 1
        i32.load offset=8
        local.tee 4
        i32.ne
        br_if 0 (;@1;)
        i32.const 0
        local.set 5
        block ;; label = @2
          block ;; label = @3
            local.get 4
            i32.const 1
            i32.add
            local.tee 3
            i32.const 0
            i32.lt_s
            br_if 0 (;@3;)
            i32.const 0
            local.set 5
            block ;; label = @4
              local.get 4
              i32.eqz
              br_if 0 (;@4;)
              local.get 2
              local.get 4
              i32.store offset=28
              local.get 2
              local.get 1
              i32.load offset=4
              i32.store offset=20
              i32.const 1
              local.set 5
            end
            local.get 2
            local.get 5
            i32.store offset=24
            local.get 2
            i32.const 8
            i32.add
            i32.const 1
            local.get 3
            local.get 2
            i32.const 20
            i32.add
            call $_ZN5alloc7raw_vec11finish_grow17hca543b9450cf484bE
            local.get 2
            i32.load offset=8
            i32.const 1
            i32.ne
            br_if 1 (;@2;)
            local.get 2
            i32.load offset=16
            local.set 6
            local.get 2
            i32.load offset=12
            local.set 5
          end
          local.get 5
          local.get 6
          global.get $GOT.data.internal.__memory_base
          i32.const 1058220
          i32.add
          call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
          unreachable
        end
        local.get 1
        local.get 2
        i32.load offset=12
        i32.store offset=4
      end
      local.get 1
      i32.load offset=4
      local.tee 5
      local.get 4
      i32.add
      i32.const 0
      i32.store8
      block ;; label = @1
        block ;; label = @2
          local.get 3
          local.get 4
          i32.const 1
          i32.add
          local.tee 1
          i32.gt_u
          br_if 0 (;@2;)
          local.get 5
          local.set 4
          br 1 (;@1;)
        end
        block ;; label = @2
          local.get 1
          br_if 0 (;@2;)
          i32.const 1
          local.set 4
          local.get 5
          local.get 3
          i32.const 1
          call $_RNvCskdKJRKLKjqM_7___rustc14___rust_dealloc
          br 1 (;@1;)
        end
        local.get 5
        local.get 3
        i32.const 1
        local.get 1
        call $_RNvCskdKJRKLKjqM_7___rustc14___rust_realloc
        local.tee 4
        br_if 0 (;@1;)
        i32.const 1
        local.get 1
        call $_ZN5alloc5alloc18handle_alloc_error17h2e6feec2f4ff6c76E
        unreachable
      end
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 0
      local.get 4
      i32.store
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN5alloc7raw_vec11finish_grow17hca543b9450cf484bE (;174;) (type 5) (param i32 i32 i32 i32)
      (local i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 3
              i32.load offset=4
              i32.eqz
              br_if 0 (;@4;)
              block ;; label = @5
                local.get 3
                i32.load offset=8
                local.tee 4
                br_if 0 (;@5;)
                local.get 2
                br_if 2 (;@3;)
                i32.const 0
                local.set 3
                br 4 (;@1;)
              end
              local.get 3
              i32.load
              local.get 4
              local.get 1
              local.get 2
              call $_RNvCskdKJRKLKjqM_7___rustc14___rust_realloc
              local.set 3
              br 2 (;@2;)
            end
            local.get 2
            br_if 0 (;@3;)
            i32.const 0
            local.set 3
            br 2 (;@1;)
          end
          call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
          local.get 2
          local.get 1
          call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
          local.set 3
        end
        local.get 3
        local.get 1
        local.get 3
        select
        local.set 1
        local.get 3
        i32.eqz
        local.set 3
      end
      local.get 0
      local.get 2
      i32.store offset=8
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 0
      local.get 3
      i32.store
    )
    (func $_ZN5alloc7raw_vec17capacity_overflow17hf680bd30c0059d32E (;175;) (type 0) (param i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 1
      i32.const 0
      i32.store offset=24
      local.get 1
      i32.const 1
      i32.store offset=12
      local.get 1
      i64.const 4
      i64.store offset=16 align=4
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1058268
      i32.add
      i32.store offset=8
      local.get 1
      i32.const 8
      i32.add
      local.get 0
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN72_$LT$$RF$str$u20$as$u20$alloc..ffi..c_str..CString..new..SpecNewImpl$GT$13spec_new_impl17h2a184a51d3df8b57E (;176;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 2
            i32.const -1
            i32.eq
            br_if 0 (;@3;)
            i32.const 0
            local.set 4
            block ;; label = @4
              local.get 2
              i32.const 1
              i32.add
              local.tee 5
              i32.const 0
              i32.lt_s
              br_if 0 (;@4;)
              call $_RNvCskdKJRKLKjqM_7___rustc35___rust_no_alloc_shim_is_unstable_v2
              i32.const 1
              local.set 4
              local.get 5
              i32.const 1
              call $_RNvCskdKJRKLKjqM_7___rustc12___rust_alloc
              local.tee 6
              i32.eqz
              br_if 0 (;@4;)
              block ;; label = @5
                local.get 2
                i32.eqz
                br_if 0 (;@5;)
                local.get 6
                local.get 1
                local.get 2
                memory.copy
              end
              block ;; label = @5
                block ;; label = @6
                  local.get 2
                  i32.const 7
                  i32.gt_u
                  br_if 0 (;@6;)
                  local.get 2
                  i32.eqz
                  br_if 4 (;@2;)
                  block ;; label = @7
                    local.get 1
                    i32.load8_u
                    br_if 0 (;@7;)
                    i32.const 0
                    local.set 4
                    br 2 (;@5;)
                  end
                  i32.const 1
                  local.set 4
                  local.get 2
                  i32.const 1
                  i32.eq
                  br_if 4 (;@2;)
                  local.get 1
                  i32.load8_u offset=1
                  i32.eqz
                  br_if 1 (;@5;)
                  i32.const 2
                  local.set 4
                  local.get 2
                  i32.const 2
                  i32.eq
                  br_if 4 (;@2;)
                  local.get 1
                  i32.load8_u offset=2
                  i32.eqz
                  br_if 1 (;@5;)
                  i32.const 3
                  local.set 4
                  local.get 2
                  i32.const 3
                  i32.eq
                  br_if 4 (;@2;)
                  local.get 1
                  i32.load8_u offset=3
                  i32.eqz
                  br_if 1 (;@5;)
                  i32.const 4
                  local.set 4
                  local.get 2
                  i32.const 4
                  i32.eq
                  br_if 4 (;@2;)
                  local.get 1
                  i32.load8_u offset=4
                  i32.eqz
                  br_if 1 (;@5;)
                  i32.const 5
                  local.set 4
                  local.get 2
                  i32.const 5
                  i32.eq
                  br_if 4 (;@2;)
                  local.get 1
                  i32.load8_u offset=5
                  i32.eqz
                  br_if 1 (;@5;)
                  i32.const 6
                  local.set 4
                  local.get 2
                  i32.const 6
                  i32.eq
                  br_if 4 (;@2;)
                  local.get 1
                  i32.load8_u offset=6
                  i32.eqz
                  br_if 1 (;@5;)
                  br 4 (;@2;)
                end
                local.get 3
                i32.const 8
                i32.add
                i32.const 0
                local.get 1
                local.get 2
                call $_ZN4core5slice6memchr14memchr_aligned17h53cfbfbcd60d9e5aE
                local.get 3
                i32.load offset=8
                i32.const 1
                i32.and
                i32.eqz
                br_if 3 (;@2;)
                local.get 3
                i32.load offset=12
                local.set 4
              end
              local.get 0
              local.get 4
              i32.store offset=12
              local.get 0
              local.get 2
              i32.store offset=8
              local.get 0
              local.get 6
              i32.store offset=4
              local.get 0
              local.get 5
              i32.store
              br 3 (;@1;)
            end
            local.get 4
            local.get 5
            global.get $GOT.data.internal.__memory_base
            i32.const 1058236
            i32.add
            call $_ZN5alloc7raw_vec12handle_error17hd24e7a9a570597e2E
            unreachable
          end
          global.get $GOT.data.internal.__memory_base
          i32.const 1058252
          i32.add
          call $_ZN4core6option13unwrap_failed17h37f20c15ca5e53d0E
          unreachable
        end
        local.get 3
        local.get 2
        i32.store offset=28
        local.get 3
        local.get 6
        i32.store offset=24
        local.get 3
        local.get 5
        i32.store offset=20
        local.get 3
        local.get 3
        i32.const 20
        i32.add
        call $_ZN5alloc3ffi5c_str7CString19_from_vec_unchecked17h309a94a22f342856E
        local.get 0
        local.get 3
        i64.load
        i64.store offset=4 align=4
        local.get 0
        i32.const -2147483648
        i32.store
      end
      local.get 3
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17ha291052cff50cef2E (;177;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      i32.const 1
      local.set 4
      block ;; label = @1
        local.get 2
        i32.load
        local.tee 5
        i32.const 34
        local.get 2
        i32.load offset=4
        local.tee 6
        i32.load offset=16
        local.tee 7
        call_indirect (type 2)
        br_if 0 (;@1;)
        block ;; label = @2
          block ;; label = @3
            local.get 1
            br_if 0 (;@3;)
            i32.const 0
            local.set 8
            i32.const 0
            local.set 2
            br 1 (;@2;)
          end
          i32.const 0
          local.set 9
          i32.const 0
          local.get 1
          i32.sub
          local.set 10
          i32.const 0
          local.set 8
          local.get 0
          local.set 11
          local.get 1
          local.set 12
          loop ;; label = @3
            local.get 11
            local.get 12
            i32.add
            local.set 13
            i32.const 0
            local.set 2
            block ;; label = @4
              block ;; label = @5
                loop ;; label = @6
                  local.get 11
                  local.get 2
                  i32.add
                  local.tee 14
                  i32.load8_u
                  local.tee 15
                  i32.const -127
                  i32.add
                  i32.const 255
                  i32.and
                  i32.const 161
                  i32.lt_u
                  br_if 1 (;@5;)
                  local.get 15
                  i32.const 34
                  i32.eq
                  br_if 1 (;@5;)
                  local.get 15
                  i32.const 92
                  i32.eq
                  br_if 1 (;@5;)
                  local.get 12
                  local.get 2
                  i32.const 1
                  i32.add
                  local.tee 2
                  i32.ne
                  br_if 0 (;@6;)
                end
                local.get 8
                local.get 12
                i32.add
                local.set 8
                br 1 (;@4;)
              end
              local.get 14
              i32.const 1
              i32.add
              local.set 11
              local.get 8
              local.get 2
              i32.add
              local.set 12
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 14
                    i32.load8_s
                    local.tee 15
                    i32.const -1
                    i32.le_s
                    br_if 0 (;@7;)
                    local.get 15
                    i32.const 255
                    i32.and
                    local.set 15
                    br 1 (;@6;)
                  end
                  local.get 11
                  i32.load8_u
                  i32.const 63
                  i32.and
                  local.set 16
                  local.get 15
                  i32.const 31
                  i32.and
                  local.set 17
                  local.get 14
                  i32.const 2
                  i32.add
                  local.set 11
                  block ;; label = @7
                    local.get 15
                    i32.const -33
                    i32.gt_u
                    br_if 0 (;@7;)
                    local.get 17
                    i32.const 6
                    i32.shl
                    local.get 16
                    i32.or
                    local.set 15
                    br 1 (;@6;)
                  end
                  local.get 16
                  i32.const 6
                  i32.shl
                  local.get 11
                  i32.load8_u
                  i32.const 63
                  i32.and
                  i32.or
                  local.set 16
                  local.get 14
                  i32.const 3
                  i32.add
                  local.set 11
                  block ;; label = @7
                    local.get 15
                    i32.const -16
                    i32.ge_u
                    br_if 0 (;@7;)
                    local.get 16
                    local.get 17
                    i32.const 12
                    i32.shl
                    i32.or
                    local.set 15
                    br 1 (;@6;)
                  end
                  local.get 11
                  i32.load8_u
                  local.set 15
                  local.get 14
                  i32.const 4
                  i32.add
                  local.set 11
                  local.get 16
                  i32.const 6
                  i32.shl
                  local.get 15
                  i32.const 63
                  i32.and
                  i32.or
                  local.get 17
                  i32.const 18
                  i32.shl
                  i32.const 1835008
                  i32.and
                  i32.or
                  local.tee 15
                  i32.const 1114112
                  i32.ne
                  br_if 0 (;@6;)
                  local.get 12
                  local.set 8
                  br 1 (;@5;)
                end
                local.get 3
                local.get 15
                i32.const 65537
                call $_ZN4core4char7methods22_$LT$impl$u20$char$GT$16escape_debug_ext17h8c36ef3b6a3dd4cbE
                block ;; label = @6
                  local.get 3
                  i32.load8_u offset=13
                  local.tee 14
                  local.get 3
                  i32.load8_u offset=12
                  local.tee 16
                  i32.sub
                  local.tee 17
                  i32.const 255
                  i32.and
                  i32.const 1
                  i32.eq
                  br_if 0 (;@6;)
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        local.get 9
                        local.get 12
                        i32.gt_u
                        br_if 0 (;@9;)
                        block ;; label = @10
                          local.get 9
                          i32.eqz
                          br_if 0 (;@10;)
                          block ;; label = @11
                            local.get 9
                            local.get 1
                            i32.lt_u
                            br_if 0 (;@11;)
                            local.get 9
                            local.get 1
                            i32.ne
                            br_if 2 (;@9;)
                            br 1 (;@10;)
                          end
                          local.get 0
                          local.get 9
                          i32.add
                          i32.load8_s
                          i32.const -65
                          i32.le_s
                          br_if 1 (;@9;)
                        end
                        block ;; label = @10
                          local.get 12
                          i32.eqz
                          br_if 0 (;@10;)
                          block ;; label = @11
                            local.get 12
                            local.get 1
                            i32.lt_u
                            br_if 0 (;@11;)
                            local.get 12
                            local.get 10
                            i32.add
                            i32.eqz
                            br_if 1 (;@10;)
                            br 2 (;@9;)
                          end
                          local.get 0
                          local.get 8
                          i32.add
                          local.get 2
                          i32.add
                          i32.load8_s
                          i32.const -65
                          i32.le_s
                          br_if 1 (;@9;)
                        end
                        local.get 5
                        local.get 0
                        local.get 9
                        i32.add
                        local.get 8
                        local.get 9
                        i32.sub
                        local.get 2
                        i32.add
                        local.get 6
                        i32.load offset=12
                        local.tee 12
                        call_indirect (type 4)
                        i32.eqz
                        br_if 1 (;@8;)
                        br 2 (;@7;)
                      end
                      local.get 0
                      local.get 1
                      local.get 9
                      local.get 8
                      local.get 2
                      i32.add
                      global.get $GOT.data.internal.__memory_base
                      i32.const 1058276
                      i32.add
                      call $_ZN4core3str16slice_error_fail17h3509675ddf930fa3E
                      unreachable
                    end
                    block ;; label = @8
                      block ;; label = @9
                        local.get 14
                        i32.const 129
                        i32.lt_u
                        br_if 0 (;@9;)
                        local.get 5
                        local.get 3
                        i32.load
                        local.get 7
                        call_indirect (type 2)
                        br_if 2 (;@7;)
                        br 1 (;@8;)
                      end
                      local.get 5
                      local.get 3
                      local.get 16
                      i32.add
                      local.get 17
                      local.get 12
                      call_indirect (type 4)
                      br_if 1 (;@7;)
                    end
                    block ;; label = @8
                      block ;; label = @9
                        local.get 15
                        i32.const 128
                        i32.ge_u
                        br_if 0 (;@9;)
                        i32.const 1
                        local.set 14
                        br 1 (;@8;)
                      end
                      block ;; label = @9
                        local.get 15
                        i32.const 2048
                        i32.ge_u
                        br_if 0 (;@9;)
                        i32.const 2
                        local.set 14
                        br 1 (;@8;)
                      end
                      i32.const 3
                      i32.const 4
                      local.get 15
                      i32.const 65536
                      i32.lt_u
                      select
                      local.set 14
                    end
                    local.get 14
                    local.get 8
                    i32.add
                    local.get 2
                    i32.add
                    local.set 9
                    br 1 (;@6;)
                  end
                  i32.const 1
                  local.set 4
                  br 5 (;@1;)
                end
                block ;; label = @6
                  block ;; label = @7
                    local.get 15
                    i32.const 128
                    i32.ge_u
                    br_if 0 (;@7;)
                    i32.const 1
                    local.set 15
                    br 1 (;@6;)
                  end
                  block ;; label = @7
                    local.get 15
                    i32.const 2048
                    i32.ge_u
                    br_if 0 (;@7;)
                    i32.const 2
                    local.set 15
                    br 1 (;@6;)
                  end
                  i32.const 3
                  i32.const 4
                  local.get 15
                  i32.const 65536
                  i32.lt_u
                  select
                  local.set 15
                end
                local.get 15
                local.get 8
                i32.add
                local.get 2
                i32.add
                local.set 8
              end
              local.get 13
              local.get 11
              i32.sub
              local.tee 12
              br_if 1 (;@3;)
            end
          end
          block ;; label = @3
            local.get 9
            local.get 8
            i32.gt_u
            br_if 0 (;@3;)
            i32.const 0
            local.set 2
            block ;; label = @4
              local.get 9
              i32.eqz
              br_if 0 (;@4;)
              block ;; label = @5
                local.get 9
                local.get 1
                i32.lt_u
                br_if 0 (;@5;)
                local.get 9
                local.set 2
                local.get 9
                local.get 1
                i32.ne
                br_if 2 (;@3;)
                br 1 (;@4;)
              end
              local.get 9
              local.set 2
              local.get 0
              local.get 9
              i32.add
              i32.load8_s
              i32.const -65
              i32.le_s
              br_if 1 (;@3;)
            end
            block ;; label = @4
              local.get 8
              br_if 0 (;@4;)
              i32.const 0
              local.set 8
              br 2 (;@2;)
            end
            block ;; label = @4
              local.get 8
              local.get 1
              i32.lt_u
              br_if 0 (;@4;)
              local.get 8
              local.get 1
              i32.eq
              br_if 2 (;@2;)
              local.get 2
              local.set 9
              br 1 (;@3;)
            end
            local.get 0
            local.get 8
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            br_if 1 (;@2;)
            local.get 2
            local.set 9
          end
          local.get 0
          local.get 1
          local.get 9
          local.get 8
          global.get $GOT.data.internal.__memory_base
          i32.const 1058292
          i32.add
          call $_ZN4core3str16slice_error_fail17h3509675ddf930fa3E
          unreachable
        end
        local.get 5
        local.get 0
        local.get 2
        i32.add
        local.get 8
        local.get 2
        i32.sub
        local.get 6
        i32.load offset=12
        call_indirect (type 4)
        br_if 0 (;@1;)
        local.get 5
        i32.const 34
        local.get 7
        call_indirect (type 2)
        local.set 4
      end
      local.get 3
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 4
    )
    (func $_ZN4core4char7methods22_$LT$impl$u20$char$GT$16escape_debug_ext17h8c36ef3b6a3dd4cbE (;178;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          block ;; label = @11
                            block ;; label = @12
                              block ;; label = @13
                                block ;; label = @14
                                  block ;; label = @15
                                    local.get 1
                                    br_table 2 (;@13;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 3 (;@12;) 5 (;@10;) 1 (;@14;) 1 (;@14;) 4 (;@11;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 8 (;@7;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 1 (;@14;) 7 (;@8;) 0 (;@15;)
                                  end
                                  local.get 1
                                  i32.const 92
                                  i32.eq
                                  br_if 5 (;@9;)
                                end
                                local.get 2
                                i32.const 1
                                i32.and
                                i32.eqz
                                br_if 7 (;@6;)
                                local.get 1
                                i32.const 767
                                i32.le_u
                                br_if 7 (;@6;)
                                local.get 1
                                call $_ZN4core7unicode12unicode_data15grapheme_extend11lookup_slow17hfa6fbe5f22d576d4E
                                i32.eqz
                                br_if 7 (;@6;)
                                local.get 3
                                i32.const 12
                                i32.add
                                i32.const 2
                                i32.add
                                i32.const 0
                                i32.store8
                                local.get 3
                                i32.const 0
                                i32.store16 offset=12
                                local.get 3
                                global.get $GOT.data.internal.__memory_base
                                i32.const 1054411
                                i32.add
                                local.tee 4
                                local.get 1
                                i32.const 20
                                i32.shr_u
                                i32.add
                                i32.load8_u
                                i32.store8 offset=15
                                local.get 3
                                local.get 4
                                local.get 1
                                i32.const 4
                                i32.shr_u
                                i32.const 15
                                i32.and
                                i32.add
                                i32.load8_u
                                i32.store8 offset=19
                                local.get 3
                                local.get 4
                                local.get 1
                                i32.const 8
                                i32.shr_u
                                i32.const 15
                                i32.and
                                i32.add
                                i32.load8_u
                                i32.store8 offset=18
                                local.get 3
                                local.get 4
                                local.get 1
                                i32.const 12
                                i32.shr_u
                                i32.const 15
                                i32.and
                                i32.add
                                i32.load8_u
                                i32.store8 offset=17
                                local.get 3
                                local.get 4
                                local.get 1
                                i32.const 16
                                i32.shr_u
                                i32.const 15
                                i32.and
                                i32.add
                                i32.load8_u
                                i32.store8 offset=16
                                local.get 3
                                i32.const 12
                                i32.add
                                local.get 1
                                i32.const 1
                                i32.or
                                i32.clz
                                i32.const 2
                                i32.shr_u
                                local.tee 2
                                i32.add
                                local.tee 5
                                i32.const 123
                                i32.store8
                                local.get 5
                                i32.const -1
                                i32.add
                                i32.const 117
                                i32.store8
                                local.get 3
                                i32.const 12
                                i32.add
                                local.get 2
                                i32.const -2
                                i32.add
                                local.tee 2
                                i32.add
                                i32.const 92
                                i32.store8
                                local.get 3
                                i32.const 12
                                i32.add
                                i32.const 8
                                i32.add
                                local.tee 5
                                local.get 4
                                local.get 1
                                i32.const 15
                                i32.and
                                i32.add
                                i32.load8_u
                                i32.store8
                                local.get 0
                                local.get 3
                                i64.load offset=12 align=2
                                i64.store align=1
                                local.get 3
                                i32.const 125
                                i32.store8 offset=21
                                local.get 0
                                i32.const 8
                                i32.add
                                local.get 5
                                i32.load16_u
                                i32.store16 align=1
                                br 8 (;@5;)
                              end
                              local.get 0
                              i64.const 0
                              i64.store offset=2 align=2
                              local.get 0
                              i32.const 12380
                              i32.store16
                              br 10 (;@2;)
                            end
                            local.get 0
                            i64.const 0
                            i64.store offset=2 align=2
                            local.get 0
                            i32.const 29788
                            i32.store16
                            br 9 (;@2;)
                          end
                          local.get 0
                          i64.const 0
                          i64.store offset=2 align=2
                          local.get 0
                          i32.const 29276
                          i32.store16
                          br 8 (;@2;)
                        end
                        local.get 0
                        i64.const 0
                        i64.store offset=2 align=2
                        local.get 0
                        i32.const 28252
                        i32.store16
                        br 7 (;@2;)
                      end
                      local.get 0
                      i64.const 0
                      i64.store offset=2 align=2
                      local.get 0
                      i32.const 23644
                      i32.store16
                      br 6 (;@2;)
                    end
                    local.get 2
                    i32.const 256
                    i32.and
                    i32.eqz
                    br_if 1 (;@6;)
                    local.get 0
                    i64.const 0
                    i64.store offset=2 align=2
                    local.get 0
                    i32.const 10076
                    i32.store16
                    br 5 (;@2;)
                  end
                  local.get 2
                  i32.const 16777215
                  i32.and
                  i32.const 65536
                  i32.ge_u
                  br_if 3 (;@3;)
                end
                local.get 1
                call $_ZN4core7unicode9printable12is_printable17h3c90da7a17fb35b6E
                br_if 1 (;@4;)
                local.get 3
                i32.const 22
                i32.add
                i32.const 2
                i32.add
                i32.const 0
                i32.store8
                local.get 3
                i32.const 0
                i32.store16 offset=22
                local.get 3
                global.get $GOT.data.internal.__memory_base
                i32.const 1054411
                i32.add
                local.tee 4
                local.get 1
                i32.const 20
                i32.shr_u
                i32.add
                i32.load8_u
                i32.store8 offset=25
                local.get 3
                local.get 4
                local.get 1
                i32.const 4
                i32.shr_u
                i32.const 15
                i32.and
                i32.add
                i32.load8_u
                i32.store8 offset=29
                local.get 3
                local.get 4
                local.get 1
                i32.const 8
                i32.shr_u
                i32.const 15
                i32.and
                i32.add
                i32.load8_u
                i32.store8 offset=28
                local.get 3
                local.get 4
                local.get 1
                i32.const 12
                i32.shr_u
                i32.const 15
                i32.and
                i32.add
                i32.load8_u
                i32.store8 offset=27
                local.get 3
                local.get 4
                local.get 1
                i32.const 16
                i32.shr_u
                i32.const 15
                i32.and
                i32.add
                i32.load8_u
                i32.store8 offset=26
                local.get 3
                i32.const 22
                i32.add
                local.get 1
                i32.const 1
                i32.or
                i32.clz
                i32.const 2
                i32.shr_u
                local.tee 2
                i32.add
                local.tee 5
                i32.const 123
                i32.store8
                local.get 5
                i32.const -1
                i32.add
                i32.const 117
                i32.store8
                local.get 3
                i32.const 22
                i32.add
                local.get 2
                i32.const -2
                i32.add
                local.tee 2
                i32.add
                i32.const 92
                i32.store8
                local.get 3
                i32.const 22
                i32.add
                i32.const 8
                i32.add
                local.tee 5
                local.get 4
                local.get 1
                i32.const 15
                i32.and
                i32.add
                i32.load8_u
                i32.store8
                local.get 0
                local.get 3
                i64.load offset=22 align=2
                i64.store align=1
                local.get 3
                i32.const 125
                i32.store8 offset=31
                local.get 0
                i32.const 8
                i32.add
                local.get 5
                i32.load16_u
                i32.store16 align=1
              end
              i32.const 10
              local.set 1
              br 3 (;@1;)
            end
            local.get 0
            local.get 1
            i32.store
            i32.const 129
            local.set 1
            i32.const 128
            local.set 2
            br 2 (;@1;)
          end
          local.get 0
          i64.const 0
          i64.store offset=2 align=2
          local.get 0
          i32.const 8796
          i32.store16
        end
        i32.const 2
        local.set 1
        i32.const 0
        local.set 2
      end
      local.get 0
      local.get 1
      i32.store8 offset=13
      local.get 0
      local.get 2
      i32.store8 offset=12
      local.get 3
      i32.const 32
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN4core3str16slice_error_fail17h3509675ddf930fa3E (;179;) (type 10) (param i32 i32 i32 i32 i32)
      local.get 0
      local.get 1
      local.get 2
      local.get 3
      local.get 4
      call $_ZN4core3str19slice_error_fail_rt17habd119a0c33c303eE
      unreachable
    )
    (func $_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17had6411be8545c4e2E (;180;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      i32.const 1
      local.set 3
      block ;; label = @1
        local.get 1
        i32.load
        local.tee 4
        i32.const 39
        local.get 1
        i32.load offset=4
        local.tee 5
        i32.load offset=16
        local.tee 1
        call_indirect (type 2)
        br_if 0 (;@1;)
        local.get 2
        local.get 0
        i32.load
        i32.const 257
        call $_ZN4core4char7methods22_$LT$impl$u20$char$GT$16escape_debug_ext17h8c36ef3b6a3dd4cbE
        block ;; label = @2
          block ;; label = @3
            local.get 2
            i32.load8_u offset=13
            local.tee 3
            i32.const 129
            i32.lt_u
            br_if 0 (;@3;)
            local.get 4
            local.get 2
            i32.load
            local.get 1
            call_indirect (type 2)
            i32.eqz
            br_if 1 (;@2;)
            i32.const 1
            local.set 3
            br 2 (;@1;)
          end
          local.get 4
          local.get 2
          local.get 2
          i32.load8_u offset=12
          local.tee 0
          i32.add
          local.get 3
          local.get 0
          i32.sub
          local.get 5
          i32.load offset=12
          call_indirect (type 4)
          i32.eqz
          br_if 0 (;@2;)
          i32.const 1
          local.set 3
          br 1 (;@1;)
        end
        local.get 4
        i32.const 39
        local.get 1
        call_indirect (type 2)
        local.set 3
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 3
    )
    (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h075952d02013a81eE (;181;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i64 i64 i64 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      i32.const 20
      local.set 3
      local.get 0
      i64.load
      local.tee 4
      local.set 5
      block ;; label = @1
        local.get 4
        i64.const 1000
        i64.lt_u
        br_if 0 (;@1;)
        i32.const 20
        local.set 3
        local.get 4
        local.set 6
        loop ;; label = @2
          local.get 2
          i32.const 12
          i32.add
          local.get 3
          i32.add
          local.tee 0
          i32.const -4
          i32.add
          global.get $GOT.data.internal.__memory_base
          i32.const 1054211
          i32.add
          local.tee 7
          local.get 6
          local.get 6
          i64.const 10000
          i64.div_u
          local.tee 5
          i64.const 10000
          i64.mul
          i64.sub
          i32.wrap_i64
          local.tee 8
          i32.const 65535
          i32.and
          i32.const 100
          i32.div_u
          local.tee 9
          i32.const 1
          i32.shl
          i32.add
          i32.load16_u align=1
          i32.store16 align=1
          local.get 0
          i32.const -2
          i32.add
          local.get 7
          local.get 8
          local.get 9
          i32.const 100
          i32.mul
          i32.sub
          i32.const 65535
          i32.and
          i32.const 1
          i32.shl
          i32.add
          i32.load16_u align=1
          i32.store16 align=1
          local.get 3
          i32.const -4
          i32.add
          local.set 3
          local.get 6
          i64.const 9999999
          i64.gt_u
          local.set 0
          local.get 5
          local.set 6
          local.get 0
          br_if 0 (;@2;)
        end
      end
      block ;; label = @1
        local.get 5
        i64.const 9
        i64.le_u
        br_if 0 (;@1;)
        local.get 2
        i32.const 12
        i32.add
        local.get 3
        i32.const -2
        i32.add
        local.tee 3
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 5
        i32.wrap_i64
        local.tee 0
        local.get 0
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 0
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 0
        i64.extend_i32_u
        local.set 5
      end
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i64.eqz
          br_if 0 (;@2;)
          local.get 5
          i64.eqz
          br_if 1 (;@1;)
        end
        local.get 2
        i32.const 12
        i32.add
        local.get 3
        i32.const -1
        i32.add
        local.tee 3
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 5
        i32.wrap_i64
        i32.const 1
        i32.shl
        i32.add
        i32.load8_u offset=1
        i32.store8
      end
      local.get 1
      i32.const 1
      i32.const 1
      i32.const 0
      local.get 2
      i32.const 12
      i32.add
      local.get 3
      i32.add
      i32.const 20
      local.get 3
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 3
      local.get 2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 3
    )
    (func $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E (;182;) (type 11) (param i32 i32 i32 i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32 i64)
      block ;; label = @1
        block ;; label = @2
          local.get 1
          br_if 0 (;@2;)
          local.get 5
          i32.const 1
          i32.add
          local.set 6
          local.get 0
          i32.load offset=8
          local.set 7
          i32.const 45
          local.set 8
          br 1 (;@1;)
        end
        i32.const 43
        i32.const 1114112
        local.get 0
        i32.load offset=8
        local.tee 7
        i32.const 2097152
        i32.and
        local.tee 1
        select
        local.set 8
        local.get 1
        i32.const 21
        i32.shr_u
        local.get 5
        i32.add
        local.set 6
      end
      block ;; label = @1
        block ;; label = @2
          local.get 7
          i32.const 8388608
          i32.and
          br_if 0 (;@2;)
          i32.const 0
          local.set 2
          br 1 (;@1;)
        end
        block ;; label = @2
          block ;; label = @3
            local.get 3
            i32.const 16
            i32.lt_u
            br_if 0 (;@3;)
            local.get 2
            local.get 3
            call $_ZN4core3str5count14do_count_chars17h51df80c571f91e4bE
            local.set 1
            br 1 (;@2;)
          end
          block ;; label = @3
            local.get 3
            br_if 0 (;@3;)
            i32.const 0
            local.set 1
            br 1 (;@2;)
          end
          local.get 3
          i32.const 3
          i32.and
          local.set 9
          block ;; label = @3
            block ;; label = @4
              local.get 3
              i32.const 4
              i32.ge_u
              br_if 0 (;@4;)
              i32.const 0
              local.set 1
              i32.const 0
              local.set 10
              br 1 (;@3;)
            end
            local.get 3
            i32.const 12
            i32.and
            local.set 11
            i32.const 0
            local.set 1
            i32.const 0
            local.set 10
            loop ;; label = @4
              local.get 1
              local.get 2
              local.get 10
              i32.add
              local.tee 12
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 12
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 12
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 12
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 11
              local.get 10
              i32.const 4
              i32.add
              local.tee 10
              i32.ne
              br_if 0 (;@4;)
            end
          end
          local.get 9
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 10
          i32.add
          local.set 12
          loop ;; label = @3
            local.get 1
            local.get 12
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 12
            i32.const 1
            i32.add
            local.set 12
            local.get 9
            i32.const -1
            i32.add
            local.tee 9
            br_if 0 (;@3;)
          end
        end
        local.get 1
        local.get 6
        i32.add
        local.set 6
      end
      block ;; label = @1
        block ;; label = @2
          local.get 6
          local.get 0
          i32.load16_u offset=12
          local.tee 11
          i32.ge_u
          br_if 0 (;@2;)
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                local.get 7
                i32.const 16777216
                i32.and
                br_if 0 (;@5;)
                local.get 11
                local.get 6
                i32.sub
                local.set 13
                i32.const 0
                local.set 1
                i32.const 0
                local.set 11
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      local.get 7
                      i32.const 29
                      i32.shr_u
                      i32.const 3
                      i32.and
                      br_table 2 (;@6;) 0 (;@8;) 1 (;@7;) 0 (;@8;) 2 (;@6;)
                    end
                    local.get 13
                    local.set 11
                    br 1 (;@6;)
                  end
                  local.get 13
                  i32.const 65534
                  i32.and
                  i32.const 1
                  i32.shr_u
                  local.set 11
                end
                local.get 7
                i32.const 2097151
                i32.and
                local.set 6
                local.get 0
                i32.load offset=4
                local.set 9
                local.get 0
                i32.load
                local.set 10
                loop ;; label = @6
                  local.get 1
                  i32.const 65535
                  i32.and
                  local.get 11
                  i32.const 65535
                  i32.and
                  i32.ge_u
                  br_if 2 (;@4;)
                  i32.const 1
                  local.set 12
                  local.get 1
                  i32.const 1
                  i32.add
                  local.set 1
                  local.get 10
                  local.get 6
                  local.get 9
                  i32.load offset=16
                  call_indirect (type 2)
                  i32.eqz
                  br_if 0 (;@6;)
                  br 5 (;@1;)
                end
              end
              local.get 0
              local.get 0
              i64.load offset=8 align=4
              local.tee 14
              i32.wrap_i64
              i32.const -1612709888
              i32.and
              i32.const 536870960
              i32.or
              i32.store offset=8
              i32.const 1
              local.set 12
              local.get 0
              i32.load
              local.tee 10
              local.get 0
              i32.load offset=4
              local.tee 9
              local.get 8
              local.get 2
              local.get 3
              call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h84bc924cb6b06b2aE
              br_if 3 (;@1;)
              i32.const 0
              local.set 1
              local.get 11
              local.get 6
              i32.sub
              i32.const 65535
              i32.and
              local.set 2
              loop ;; label = @5
                local.get 1
                i32.const 65535
                i32.and
                local.get 2
                i32.ge_u
                br_if 2 (;@3;)
                i32.const 1
                local.set 12
                local.get 1
                i32.const 1
                i32.add
                local.set 1
                local.get 10
                i32.const 48
                local.get 9
                i32.load offset=16
                call_indirect (type 2)
                i32.eqz
                br_if 0 (;@5;)
                br 4 (;@1;)
              end
            end
            i32.const 1
            local.set 12
            local.get 10
            local.get 9
            local.get 8
            local.get 2
            local.get 3
            call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h84bc924cb6b06b2aE
            br_if 2 (;@1;)
            local.get 10
            local.get 4
            local.get 5
            local.get 9
            i32.load offset=12
            call_indirect (type 4)
            br_if 2 (;@1;)
            i32.const 0
            local.set 1
            local.get 13
            local.get 11
            i32.sub
            i32.const 65535
            i32.and
            local.set 0
            loop ;; label = @4
              local.get 1
              i32.const 65535
              i32.and
              local.tee 2
              local.get 0
              i32.lt_u
              local.set 12
              local.get 2
              local.get 0
              i32.ge_u
              br_if 3 (;@1;)
              local.get 1
              i32.const 1
              i32.add
              local.set 1
              local.get 10
              local.get 6
              local.get 9
              i32.load offset=16
              call_indirect (type 2)
              i32.eqz
              br_if 0 (;@4;)
              br 3 (;@1;)
            end
          end
          i32.const 1
          local.set 12
          local.get 10
          local.get 4
          local.get 5
          local.get 9
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
          local.get 0
          local.get 14
          i64.store offset=8 align=4
          i32.const 0
          return
        end
        i32.const 1
        local.set 12
        local.get 0
        i32.load
        local.tee 1
        local.get 0
        i32.load offset=4
        local.tee 10
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h84bc924cb6b06b2aE
        br_if 0 (;@1;)
        local.get 1
        local.get 4
        local.get 5
        local.get 10
        i32.load offset=12
        call_indirect (type 4)
        local.set 12
      end
      local.get 12
    )
    (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE (;183;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      i32.const 10
      local.set 3
      local.get 0
      i32.load
      local.tee 4
      local.set 5
      block ;; label = @1
        local.get 4
        i32.const 1000
        i32.lt_u
        br_if 0 (;@1;)
        i32.const 10
        local.set 3
        local.get 4
        local.set 0
        loop ;; label = @2
          local.get 2
          i32.const 6
          i32.add
          local.get 3
          i32.add
          local.tee 6
          i32.const -4
          i32.add
          global.get $GOT.data.internal.__memory_base
          i32.const 1054211
          i32.add
          local.tee 7
          local.get 0
          local.get 0
          i32.const 10000
          i32.div_u
          local.tee 5
          i32.const 10000
          i32.mul
          i32.sub
          local.tee 8
          i32.const 65535
          i32.and
          i32.const 100
          i32.div_u
          local.tee 9
          i32.const 1
          i32.shl
          i32.add
          i32.load16_u align=1
          i32.store16 align=1
          local.get 6
          i32.const -2
          i32.add
          local.get 7
          local.get 8
          local.get 9
          i32.const 100
          i32.mul
          i32.sub
          i32.const 65535
          i32.and
          i32.const 1
          i32.shl
          i32.add
          i32.load16_u align=1
          i32.store16 align=1
          local.get 3
          i32.const -4
          i32.add
          local.set 3
          local.get 0
          i32.const 9999999
          i32.gt_u
          local.set 6
          local.get 5
          local.set 0
          local.get 6
          br_if 0 (;@2;)
        end
      end
      block ;; label = @1
        block ;; label = @2
          local.get 5
          i32.const 9
          i32.gt_u
          br_if 0 (;@2;)
          local.get 5
          local.set 0
          br 1 (;@1;)
        end
        local.get 2
        i32.const 6
        i32.add
        local.get 3
        i32.const -2
        i32.add
        local.tee 3
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 5
        local.get 5
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 0
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
      end
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i32.eqz
          br_if 0 (;@2;)
          local.get 0
          i32.eqz
          br_if 1 (;@1;)
        end
        local.get 2
        i32.const 6
        i32.add
        local.get 3
        i32.const -1
        i32.add
        local.tee 3
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 0
        i32.const 1
        i32.shl
        i32.add
        i32.load8_u offset=1
        i32.store8
      end
      local.get 1
      i32.const 1
      i32.const 1
      i32.const 0
      local.get 2
      i32.const 6
      i32.add
      local.get 3
      i32.add
      i32.const 10
      local.get 3
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 0
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h51f88e25e6e3e172E (;184;) (type 2) (param i32 i32) (result i32)
      local.get 0
      i32.load
      local.get 1
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 2)
    )
    (func $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h3b63b9c35892d81bE (;185;) (type 4) (param i32 i32 i32) (result i32)
      local.get 2
      local.get 0
      local.get 1
      call $_ZN4core3fmt9Formatter3pad17h218c4ce82702ca8dE
    )
    (func $_ZN4core3fmt9Formatter3pad17h218c4ce82702ca8dE (;186;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.load offset=8
          local.tee 3
          i32.const 402653184
          i32.and
          i32.eqz
          br_if 0 (;@2;)
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 3
                    i32.const 268435456
                    i32.and
                    i32.eqz
                    br_if 0 (;@7;)
                    local.get 0
                    i32.load16_u offset=14
                    local.tee 4
                    br_if 1 (;@6;)
                    i32.const 0
                    local.set 2
                    br 2 (;@5;)
                  end
                  block ;; label = @7
                    local.get 2
                    i32.const 16
                    i32.lt_u
                    br_if 0 (;@7;)
                    local.get 1
                    local.get 2
                    call $_ZN4core3str5count14do_count_chars17h51df80c571f91e4bE
                    local.set 5
                    br 4 (;@3;)
                  end
                  block ;; label = @7
                    local.get 2
                    br_if 0 (;@7;)
                    i32.const 0
                    local.set 2
                    i32.const 0
                    local.set 5
                    br 4 (;@3;)
                  end
                  local.get 2
                  i32.const 3
                  i32.and
                  local.set 6
                  block ;; label = @7
                    block ;; label = @8
                      local.get 2
                      i32.const 4
                      i32.ge_u
                      br_if 0 (;@8;)
                      i32.const 0
                      local.set 5
                      i32.const 0
                      local.set 7
                      br 1 (;@7;)
                    end
                    local.get 2
                    i32.const 12
                    i32.and
                    local.set 4
                    i32.const 0
                    local.set 5
                    i32.const 0
                    local.set 7
                    loop ;; label = @8
                      local.get 5
                      local.get 1
                      local.get 7
                      i32.add
                      local.tee 8
                      i32.load8_s
                      i32.const -65
                      i32.gt_s
                      i32.add
                      local.get 8
                      i32.const 1
                      i32.add
                      i32.load8_s
                      i32.const -65
                      i32.gt_s
                      i32.add
                      local.get 8
                      i32.const 2
                      i32.add
                      i32.load8_s
                      i32.const -65
                      i32.gt_s
                      i32.add
                      local.get 8
                      i32.const 3
                      i32.add
                      i32.load8_s
                      i32.const -65
                      i32.gt_s
                      i32.add
                      local.set 5
                      local.get 4
                      local.get 7
                      i32.const 4
                      i32.add
                      local.tee 7
                      i32.ne
                      br_if 0 (;@8;)
                    end
                  end
                  local.get 6
                  i32.eqz
                  br_if 3 (;@3;)
                  local.get 1
                  local.get 7
                  i32.add
                  local.set 8
                  loop ;; label = @7
                    local.get 5
                    local.get 8
                    i32.load8_s
                    i32.const -65
                    i32.gt_s
                    i32.add
                    local.set 5
                    local.get 8
                    i32.const 1
                    i32.add
                    local.set 8
                    local.get 6
                    i32.const -1
                    i32.add
                    local.tee 6
                    br_if 0 (;@7;)
                    br 4 (;@3;)
                  end
                end
                local.get 1
                local.get 2
                i32.add
                local.set 6
                i32.const 0
                local.set 2
                local.get 1
                local.set 8
                local.get 4
                local.set 7
                loop ;; label = @6
                  local.get 8
                  local.tee 5
                  local.get 6
                  i32.eq
                  br_if 2 (;@4;)
                  block ;; label = @7
                    block ;; label = @8
                      local.get 5
                      i32.load8_s
                      local.tee 8
                      i32.const -1
                      i32.le_s
                      br_if 0 (;@8;)
                      local.get 5
                      i32.const 1
                      i32.add
                      local.set 8
                      br 1 (;@7;)
                    end
                    block ;; label = @8
                      local.get 8
                      i32.const -32
                      i32.ge_u
                      br_if 0 (;@8;)
                      local.get 5
                      i32.const 2
                      i32.add
                      local.set 8
                      br 1 (;@7;)
                    end
                    block ;; label = @8
                      local.get 8
                      i32.const -16
                      i32.ge_u
                      br_if 0 (;@8;)
                      local.get 5
                      i32.const 3
                      i32.add
                      local.set 8
                      br 1 (;@7;)
                    end
                    local.get 5
                    i32.const 4
                    i32.add
                    local.set 8
                  end
                  local.get 8
                  local.get 5
                  i32.sub
                  local.get 2
                  i32.add
                  local.set 2
                  local.get 7
                  i32.const -1
                  i32.add
                  local.tee 7
                  br_if 0 (;@6;)
                end
              end
              i32.const 0
              local.set 7
            end
            local.get 4
            local.get 7
            i32.sub
            local.set 5
          end
          local.get 5
          local.get 0
          i32.load16_u offset=12
          local.tee 8
          i32.ge_u
          br_if 0 (;@2;)
          local.get 8
          local.get 5
          i32.sub
          local.set 9
          i32.const 0
          local.set 5
          i32.const 0
          local.set 4
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                local.get 3
                i32.const 29
                i32.shr_u
                i32.const 3
                i32.and
                br_table 2 (;@3;) 0 (;@5;) 1 (;@4;) 2 (;@3;) 2 (;@3;)
              end
              local.get 9
              local.set 4
              br 1 (;@3;)
            end
            local.get 9
            i32.const 65534
            i32.and
            i32.const 1
            i32.shr_u
            local.set 4
          end
          local.get 3
          i32.const 2097151
          i32.and
          local.set 6
          local.get 0
          i32.load offset=4
          local.set 7
          local.get 0
          i32.load
          local.set 0
          block ;; label = @3
            loop ;; label = @4
              local.get 5
              i32.const 65535
              i32.and
              local.get 4
              i32.const 65535
              i32.and
              i32.ge_u
              br_if 1 (;@3;)
              i32.const 1
              local.set 8
              local.get 5
              i32.const 1
              i32.add
              local.set 5
              local.get 0
              local.get 6
              local.get 7
              i32.load offset=16
              call_indirect (type 2)
              br_if 3 (;@1;)
              br 0 (;@4;)
            end
          end
          i32.const 1
          local.set 8
          local.get 0
          local.get 1
          local.get 2
          local.get 7
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
          i32.const 0
          local.set 5
          local.get 9
          local.get 4
          i32.sub
          i32.const 65535
          i32.and
          local.set 2
          loop ;; label = @3
            local.get 5
            i32.const 65535
            i32.and
            local.tee 4
            local.get 2
            i32.lt_u
            local.set 8
            local.get 4
            local.get 2
            i32.ge_u
            br_if 2 (;@1;)
            local.get 5
            i32.const 1
            i32.add
            local.set 5
            local.get 0
            local.get 6
            local.get 7
            i32.load offset=16
            call_indirect (type 2)
            br_if 2 (;@1;)
            br 0 (;@3;)
          end
        end
        local.get 0
        i32.load
        local.get 1
        local.get 2
        local.get 0
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 4)
        local.set 8
      end
      local.get 8
    )
    (func $_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17h20cb72827ef30f53E (;187;) (type 2) (param i32 i32) (result i32)
      block ;; label = @1
        local.get 0
        i32.load8_u
        br_if 0 (;@1;)
        local.get 1
        global.get $GOT.data.internal.__memory_base
        i32.const 1054202
        i32.add
        i32.const 5
        call $_ZN4core3fmt9Formatter3pad17h218c4ce82702ca8dE
        return
      end
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1054207
      i32.add
      i32.const 4
      call $_ZN4core3fmt9Formatter3pad17h218c4ce82702ca8dE
    )
    (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h60b46cfc83e304a4E (;188;) (type 2) (param i32 i32) (result i32)
      local.get 1
      local.get 0
      i32.load
      local.get 0
      i32.load offset=4
      call $_ZN4core3fmt9Formatter3pad17h218c4ce82702ca8dE
    )
    (func $_ZN4core9panicking9panic_fmt17he4af7122229aee01E (;189;) (type 1) (param i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      i32.const 1
      i32.store16 offset=12
      local.get 2
      local.get 1
      i32.store offset=8
      local.get 2
      local.get 0
      i32.store offset=4
      local.get 2
      i32.const 4
      i32.add
      call $_RNvCskdKJRKLKjqM_7___rustc17rust_begin_unwind
      unreachable
    )
    (func $_ZN4core3ffi5c_str4CStr19from_bytes_with_nul17hdcfbe38e78b1258eE (;190;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 2
                    i32.const 7
                    i32.gt_u
                    br_if 0 (;@7;)
                    local.get 2
                    i32.eqz
                    br_if 5 (;@2;)
                    local.get 1
                    i32.load8_u
                    br_if 1 (;@6;)
                    i32.const 0
                    local.set 3
                    br 6 (;@1;)
                  end
                  local.get 1
                  i32.const 3
                  i32.add
                  i32.const -4
                  i32.and
                  local.tee 4
                  local.get 1
                  i32.eq
                  br_if 1 (;@5;)
                  local.get 4
                  local.get 1
                  i32.sub
                  local.set 4
                  i32.const 0
                  local.set 3
                  loop ;; label = @7
                    local.get 1
                    local.get 3
                    i32.add
                    i32.load8_u
                    i32.eqz
                    br_if 6 (;@1;)
                    local.get 4
                    local.get 3
                    i32.const 1
                    i32.add
                    local.tee 3
                    i32.ne
                    br_if 0 (;@7;)
                  end
                  local.get 4
                  local.get 2
                  i32.const -8
                  i32.add
                  local.tee 5
                  i32.gt_u
                  br_if 3 (;@3;)
                  br 2 (;@4;)
                end
                i32.const 1
                local.set 3
                local.get 2
                i32.const 1
                i32.eq
                br_if 3 (;@2;)
                local.get 1
                i32.load8_u offset=1
                i32.eqz
                br_if 4 (;@1;)
                i32.const 2
                local.set 3
                local.get 2
                i32.const 2
                i32.eq
                br_if 3 (;@2;)
                local.get 1
                i32.load8_u offset=2
                i32.eqz
                br_if 4 (;@1;)
                i32.const 3
                local.set 3
                local.get 2
                i32.const 3
                i32.eq
                br_if 3 (;@2;)
                local.get 1
                i32.load8_u offset=3
                i32.eqz
                br_if 4 (;@1;)
                i32.const 4
                local.set 3
                local.get 2
                i32.const 4
                i32.eq
                br_if 3 (;@2;)
                local.get 1
                i32.load8_u offset=4
                i32.eqz
                br_if 4 (;@1;)
                i32.const 5
                local.set 3
                local.get 2
                i32.const 5
                i32.eq
                br_if 3 (;@2;)
                local.get 1
                i32.load8_u offset=5
                i32.eqz
                br_if 4 (;@1;)
                i32.const 6
                local.set 3
                local.get 2
                i32.const 6
                i32.eq
                br_if 3 (;@2;)
                local.get 1
                i32.load8_u offset=6
                br_if 3 (;@2;)
                br 4 (;@1;)
              end
              local.get 2
              i32.const -8
              i32.add
              local.set 5
              i32.const 0
              local.set 4
            end
            loop ;; label = @4
              i32.const 16843008
              local.get 1
              local.get 4
              i32.add
              local.tee 3
              i32.load
              local.tee 6
              i32.sub
              local.get 6
              i32.or
              i32.const 16843008
              local.get 3
              i32.const 4
              i32.add
              i32.load
              local.tee 3
              i32.sub
              local.get 3
              i32.or
              i32.and
              i32.const -2139062144
              i32.and
              i32.const -2139062144
              i32.ne
              br_if 1 (;@3;)
              local.get 4
              i32.const 8
              i32.add
              local.tee 4
              local.get 5
              i32.le_u
              br_if 0 (;@4;)
            end
          end
          local.get 2
          local.get 4
          i32.eq
          br_if 0 (;@2;)
          loop ;; label = @3
            block ;; label = @4
              local.get 1
              local.get 4
              i32.add
              i32.load8_u
              br_if 0 (;@4;)
              local.get 4
              local.set 3
              br 3 (;@1;)
            end
            local.get 2
            local.get 4
            i32.const 1
            i32.add
            local.tee 4
            i32.ne
            br_if 0 (;@3;)
          end
        end
        local.get 0
        i32.const 1
        i32.store offset=4
        local.get 0
        i32.const 1
        i32.store
        return
      end
      block ;; label = @1
        local.get 3
        i32.const 1
        i32.add
        local.get 2
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        local.get 3
        i32.store offset=8
        local.get 0
        i32.const 0
        i32.store offset=4
        local.get 0
        i32.const 1
        i32.store
        return
      end
      local.get 0
      local.get 2
      i32.store offset=8
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 0
      i32.const 0
      i32.store
    )
    (func $_ZN4core3str8converts9from_utf817h25f60ed39aa8d897E (;191;) (type 3) (param i32 i32 i32)
      (local i32 i32 i32 i32 i32 i64 i64 i32)
      block ;; label = @1
        local.get 2
        i32.eqz
        br_if 0 (;@1;)
        i32.const 0
        local.get 2
        i32.const -7
        i32.add
        local.tee 3
        local.get 3
        local.get 2
        i32.gt_u
        select
        local.set 4
        local.get 1
        i32.const 3
        i32.add
        i32.const -4
        i32.and
        local.get 1
        i32.sub
        local.set 5
        i32.const 0
        local.set 3
        loop ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  local.get 1
                  local.get 3
                  i32.add
                  i32.load8_u
                  local.tee 6
                  i32.extend8_s
                  local.tee 7
                  i32.const 0
                  i32.lt_s
                  br_if 0 (;@6;)
                  local.get 5
                  local.get 3
                  i32.sub
                  i32.const 3
                  i32.and
                  br_if 1 (;@5;)
                  local.get 3
                  local.get 4
                  i32.ge_u
                  br_if 2 (;@4;)
                  loop ;; label = @7
                    local.get 1
                    local.get 3
                    i32.add
                    local.tee 6
                    i32.const 4
                    i32.add
                    i32.load
                    local.get 6
                    i32.load
                    i32.or
                    i32.const -2139062144
                    i32.and
                    br_if 3 (;@4;)
                    local.get 3
                    i32.const 8
                    i32.add
                    local.tee 3
                    local.get 4
                    i32.lt_u
                    br_if 0 (;@7;)
                    br 3 (;@4;)
                  end
                end
                i64.const 1099511627776
                local.set 8
                i64.const 4294967296
                local.set 9
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          block ;; label = @11
                            block ;; label = @12
                              block ;; label = @13
                                block ;; label = @14
                                  block ;; label = @15
                                    block ;; label = @16
                                      block ;; label = @17
                                        global.get $GOT.data.internal.__memory_base
                                        i32.const 1054465
                                        i32.add
                                        local.get 6
                                        i32.add
                                        i32.load8_u
                                        i32.const -2
                                        i32.add
                                        br_table 0 (;@17;) 1 (;@16;) 2 (;@15;) 10 (;@7;)
                                      end
                                      local.get 3
                                      i32.const 1
                                      i32.add
                                      local.tee 6
                                      local.get 2
                                      i32.lt_u
                                      br_if 2 (;@14;)
                                      i64.const 0
                                      local.set 8
                                      i64.const 0
                                      local.set 9
                                      br 9 (;@7;)
                                    end
                                    i64.const 0
                                    local.set 8
                                    local.get 3
                                    i32.const 1
                                    i32.add
                                    local.tee 10
                                    local.get 2
                                    i32.lt_u
                                    br_if 2 (;@13;)
                                    i64.const 0
                                    local.set 9
                                    br 8 (;@7;)
                                  end
                                  i64.const 0
                                  local.set 8
                                  local.get 3
                                  i32.const 1
                                  i32.add
                                  local.tee 10
                                  local.get 2
                                  i32.lt_u
                                  br_if 2 (;@12;)
                                  i64.const 0
                                  local.set 9
                                  br 7 (;@7;)
                                end
                                i64.const 1099511627776
                                local.set 8
                                i64.const 4294967296
                                local.set 9
                                local.get 1
                                local.get 6
                                i32.add
                                i32.load8_s
                                i32.const -65
                                i32.gt_s
                                br_if 6 (;@7;)
                                br 7 (;@6;)
                              end
                              local.get 1
                              local.get 10
                              i32.add
                              i32.load8_s
                              local.set 10
                              block ;; label = @13
                                block ;; label = @14
                                  block ;; label = @15
                                    local.get 6
                                    i32.const -224
                                    i32.add
                                    br_table 0 (;@15;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 1 (;@14;) 2 (;@13;)
                                  end
                                  local.get 10
                                  i32.const -32
                                  i32.and
                                  i32.const -96
                                  i32.eq
                                  br_if 4 (;@10;)
                                  br 3 (;@11;)
                                end
                                local.get 10
                                i32.const -97
                                i32.gt_s
                                br_if 2 (;@11;)
                                br 3 (;@10;)
                              end
                              block ;; label = @13
                                local.get 7
                                i32.const 31
                                i32.add
                                i32.const 255
                                i32.and
                                i32.const 12
                                i32.lt_u
                                br_if 0 (;@13;)
                                local.get 7
                                i32.const -2
                                i32.and
                                i32.const -18
                                i32.ne
                                br_if 2 (;@11;)
                                local.get 10
                                i32.const -64
                                i32.lt_s
                                br_if 3 (;@10;)
                                br 2 (;@11;)
                              end
                              local.get 10
                              i32.const -64
                              i32.lt_s
                              br_if 2 (;@10;)
                              br 1 (;@11;)
                            end
                            local.get 1
                            local.get 10
                            i32.add
                            i32.load8_s
                            local.set 10
                            block ;; label = @12
                              block ;; label = @13
                                block ;; label = @14
                                  block ;; label = @15
                                    local.get 6
                                    i32.const -240
                                    i32.add
                                    br_table 1 (;@14;) 0 (;@15;) 0 (;@15;) 0 (;@15;) 2 (;@13;) 0 (;@15;)
                                  end
                                  local.get 7
                                  i32.const 15
                                  i32.add
                                  i32.const 255
                                  i32.and
                                  i32.const 2
                                  i32.gt_u
                                  br_if 3 (;@11;)
                                  local.get 10
                                  i32.const -64
                                  i32.ge_s
                                  br_if 3 (;@11;)
                                  br 2 (;@12;)
                                end
                                local.get 10
                                i32.const 112
                                i32.add
                                i32.const 255
                                i32.and
                                i32.const 48
                                i32.ge_u
                                br_if 2 (;@11;)
                                br 1 (;@12;)
                              end
                              local.get 10
                              i32.const -113
                              i32.gt_s
                              br_if 1 (;@11;)
                            end
                            block ;; label = @12
                              local.get 3
                              i32.const 2
                              i32.add
                              local.tee 6
                              local.get 2
                              i32.lt_u
                              br_if 0 (;@12;)
                              i64.const 0
                              local.set 9
                              br 5 (;@7;)
                            end
                            local.get 1
                            local.get 6
                            i32.add
                            i32.load8_s
                            i32.const -65
                            i32.gt_s
                            br_if 2 (;@9;)
                            i64.const 0
                            local.set 9
                            local.get 3
                            i32.const 3
                            i32.add
                            local.tee 6
                            local.get 2
                            i32.ge_u
                            br_if 4 (;@7;)
                            local.get 1
                            local.get 6
                            i32.add
                            i32.load8_s
                            i32.const -64
                            i32.lt_s
                            br_if 5 (;@6;)
                            i64.const 3298534883328
                            local.set 8
                            br 3 (;@8;)
                          end
                          i64.const 1099511627776
                          local.set 8
                          br 2 (;@8;)
                        end
                        i64.const 0
                        local.set 9
                        local.get 3
                        i32.const 2
                        i32.add
                        local.tee 6
                        local.get 2
                        i32.ge_u
                        br_if 2 (;@7;)
                        local.get 1
                        local.get 6
                        i32.add
                        i32.load8_s
                        i32.const -65
                        i32.le_s
                        br_if 3 (;@6;)
                      end
                      i64.const 2199023255552
                      local.set 8
                    end
                    i64.const 4294967296
                    local.set 9
                  end
                  local.get 0
                  local.get 8
                  local.get 3
                  i64.extend_i32_u
                  i64.or
                  local.get 9
                  i64.or
                  i64.store offset=4 align=4
                  local.get 0
                  i32.const 1
                  i32.store
                  return
                end
                local.get 6
                i32.const 1
                i32.add
                local.set 3
                br 2 (;@3;)
              end
              local.get 3
              i32.const 1
              i32.add
              local.set 3
              br 1 (;@3;)
            end
            local.get 3
            local.get 2
            i32.ge_u
            br_if 0 (;@3;)
            loop ;; label = @4
              local.get 1
              local.get 3
              i32.add
              i32.load8_s
              i32.const 0
              i32.lt_s
              br_if 1 (;@3;)
              local.get 2
              local.get 3
              i32.const 1
              i32.add
              local.tee 3
              i32.ne
              br_if 0 (;@4;)
              br 3 (;@1;)
            end
          end
          local.get 3
          local.get 2
          i32.lt_u
          br_if 0 (;@2;)
        end
      end
      local.get 0
      local.get 2
      i32.store offset=8
      local.get 0
      local.get 1
      i32.store offset=4
      local.get 0
      i32.const 0
      i32.store
    )
    (func $_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17hf9cdf4ac9c5498a7E (;192;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      i32.const 3
      local.set 3
      local.get 0
      i32.load8_u
      local.tee 0
      local.set 4
      block ;; label = @1
        local.get 0
        i32.const 10
        i32.lt_u
        br_if 0 (;@1;)
        i32.const 1
        local.set 3
        local.get 2
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 0
        local.get 0
        i32.const 100
        i32.div_u
        local.tee 4
        i32.const 100
        i32.mul
        i32.sub
        i32.const 255
        i32.and
        i32.const 1
        i32.shl
        i32.add
        i32.load16_u align=1
        i32.store16 offset=14 align=1
      end
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.eqz
          br_if 0 (;@2;)
          local.get 4
          i32.eqz
          br_if 1 (;@1;)
        end
        local.get 2
        i32.const 13
        i32.add
        local.get 3
        i32.const -1
        i32.add
        local.tee 3
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 4
        i32.const 1
        i32.shl
        i32.add
        i32.load8_u offset=1
        i32.store8
      end
      local.get 1
      i32.const 1
      i32.const 1
      i32.const 0
      local.get 2
      i32.const 13
      i32.add
      local.get 3
      i32.add
      i32.const 3
      local.get 3
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 3
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 3
    )
    (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17hc286a2587fb896f9E (;193;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      i32.const 10
      local.set 3
      block ;; label = @1
        block ;; label = @2
          local.get 0
          i32.load
          local.tee 4
          local.get 4
          i32.const 31
          i32.shr_s
          local.tee 0
          i32.xor
          local.get 0
          i32.sub
          local.tee 0
          i32.const 1000
          i32.ge_u
          br_if 0 (;@2;)
          local.get 0
          local.set 5
          br 1 (;@1;)
        end
        i32.const 10
        local.set 3
        loop ;; label = @2
          local.get 2
          i32.const 6
          i32.add
          local.get 3
          i32.add
          local.tee 6
          i32.const -4
          i32.add
          global.get $GOT.data.internal.__memory_base
          i32.const 1054211
          i32.add
          local.tee 7
          local.get 0
          local.get 0
          i32.const 10000
          i32.div_u
          local.tee 5
          i32.const 10000
          i32.mul
          i32.sub
          local.tee 8
          i32.const 65535
          i32.and
          i32.const 100
          i32.div_u
          local.tee 9
          i32.const 1
          i32.shl
          i32.add
          i32.load16_u align=1
          i32.store16 align=1
          local.get 6
          i32.const -2
          i32.add
          local.get 7
          local.get 8
          local.get 9
          i32.const 100
          i32.mul
          i32.sub
          i32.const 65535
          i32.and
          i32.const 1
          i32.shl
          i32.add
          i32.load16_u align=1
          i32.store16 align=1
          local.get 3
          i32.const -4
          i32.add
          local.set 3
          local.get 0
          i32.const 9999999
          i32.gt_u
          local.set 6
          local.get 5
          local.set 0
          local.get 6
          br_if 0 (;@2;)
        end
      end
      block ;; label = @1
        block ;; label = @2
          local.get 5
          i32.const 9
          i32.gt_u
          br_if 0 (;@2;)
          local.get 5
          local.set 0
          br 1 (;@1;)
        end
        local.get 2
        i32.const 6
        i32.add
        local.get 3
        i32.const -2
        i32.add
        local.tee 3
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 5
        local.get 5
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 0
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
      end
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i32.eqz
          br_if 0 (;@2;)
          local.get 0
          i32.eqz
          br_if 1 (;@1;)
        end
        local.get 2
        i32.const 6
        i32.add
        local.get 3
        i32.const -1
        i32.add
        local.tee 3
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054211
        i32.add
        local.get 0
        i32.const 1
        i32.shl
        i32.add
        i32.load8_u offset=1
        i32.store8
      end
      local.get 1
      local.get 4
      i32.const -1
      i32.xor
      i32.const 31
      i32.shr_u
      i32.const 1
      i32.const 0
      local.get 2
      i32.const 6
      i32.add
      local.get 3
      i32.add
      i32.const 10
      local.get 3
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 0
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u8$GT$3fmt17h063a5a81464c7db2E (;194;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 0
      i32.load8_u
      local.set 3
      i32.const 0
      local.set 0
      loop ;; label = @1
        local.get 2
        i32.const 14
        i32.add
        local.get 0
        i32.add
        i32.const 1
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054411
        i32.add
        local.get 3
        i32.const 15
        i32.and
        i32.add
        i32.load8_u
        i32.store8
        local.get 0
        i32.const -1
        i32.add
        local.set 0
        local.get 3
        i32.const 255
        i32.and
        local.tee 4
        i32.const 4
        i32.shr_u
        local.set 3
        local.get 4
        i32.const 15
        i32.gt_u
        br_if 0 (;@1;)
      end
      local.get 1
      i32.const 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1054427
      i32.add
      i32.const 2
      local.get 2
      i32.const 14
      i32.add
      local.get 0
      i32.add
      i32.const 2
      i32.add
      i32.const 0
      local.get 0
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 0
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u8$GT$3fmt17h1a44585e24c514deE (;195;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 0
      i32.load8_u
      local.set 3
      i32.const 0
      local.set 0
      loop ;; label = @1
        local.get 2
        i32.const 14
        i32.add
        local.get 0
        i32.add
        i32.const 1
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054429
        i32.add
        local.get 3
        i32.const 15
        i32.and
        i32.add
        i32.load8_u
        i32.store8
        local.get 0
        i32.const -1
        i32.add
        local.set 0
        local.get 3
        i32.const 255
        i32.and
        local.tee 4
        i32.const 4
        i32.shr_u
        local.set 3
        local.get 4
        i32.const 15
        i32.gt_u
        br_if 0 (;@1;)
      end
      local.get 1
      i32.const 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1054427
      i32.add
      i32.const 2
      local.get 2
      i32.const 14
      i32.add
      local.get 0
      i32.add
      i32.const 2
      i32.add
      i32.const 0
      local.get 0
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 0
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hebbdd05705cf5268E (;196;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 0
      i32.load
      local.set 0
      i32.const 0
      local.set 3
      loop ;; label = @1
        local.get 2
        i32.const 8
        i32.add
        local.get 3
        i32.add
        i32.const 7
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054411
        i32.add
        local.get 0
        i32.const 15
        i32.and
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const -1
        i32.add
        local.set 3
        local.get 0
        i32.const 15
        i32.gt_u
        local.set 4
        local.get 0
        i32.const 4
        i32.shr_u
        local.set 0
        local.get 4
        br_if 0 (;@1;)
      end
      local.get 1
      i32.const 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1054427
      i32.add
      i32.const 2
      local.get 2
      i32.const 8
      i32.add
      local.get 3
      i32.add
      i32.const 8
      i32.add
      i32.const 0
      local.get 3
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 0
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17h358537a2663ec30eE (;197;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 0
      i32.load
      local.set 0
      i32.const 0
      local.set 3
      loop ;; label = @1
        local.get 2
        i32.const 8
        i32.add
        local.get 3
        i32.add
        i32.const 7
        i32.add
        global.get $GOT.data.internal.__memory_base
        i32.const 1054429
        i32.add
        local.get 0
        i32.const 15
        i32.and
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const -1
        i32.add
        local.set 3
        local.get 0
        i32.const 15
        i32.gt_u
        local.set 4
        local.get 0
        i32.const 4
        i32.shr_u
        local.set 0
        local.get 4
        br_if 0 (;@1;)
      end
      local.get 1
      i32.const 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1054427
      i32.add
      i32.const 2
      local.get 2
      i32.const 8
      i32.add
      local.get 3
      i32.add
      i32.const 8
      i32.add
      i32.const 0
      local.get 3
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
      local.set 0
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E (;198;) (type 5) (param i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          local.get 0
          local.get 2
          i32.gt_u
          br_if 0 (;@2;)
          local.get 1
          local.get 2
          i32.gt_u
          br_if 1 (;@1;)
          local.get 0
          local.get 1
          i32.le_u
          br_if 1 (;@1;)
          local.get 0
          local.get 1
          local.get 3
          call $_ZN4core5slice5index16slice_index_fail8do_panic7runtime17h35ce0ffc3e1b3088E
          unreachable
        end
        local.get 0
        local.get 2
        local.get 3
        call $_ZN4core5slice5index16slice_index_fail8do_panic7runtime17h78ec4bf3f51595ceE
        unreachable
      end
      local.get 1
      local.get 2
      local.get 3
      call $_ZN4core5slice5index16slice_index_fail8do_panic7runtime17h0134f2f4033eb1cbE
      unreachable
    )
    (func $_ZN4core3fmt5write17h2e7b0d99429abb3bE (;199;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      i32.store offset=4
      local.get 3
      local.get 0
      i32.store
      local.get 3
      i64.const 3758096416
      i64.store offset=8 align=4
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                local.get 2
                i32.load offset=16
                local.tee 4
                i32.eqz
                br_if 0 (;@5;)
                local.get 2
                i32.load offset=20
                local.tee 1
                br_if 1 (;@4;)
                br 2 (;@3;)
              end
              local.get 2
              i32.load offset=12
              local.tee 0
              i32.eqz
              br_if 1 (;@3;)
              local.get 2
              i32.load offset=8
              local.tee 1
              local.get 0
              i32.const 3
              i32.shl
              local.tee 0
              i32.add
              local.set 5
              local.get 0
              i32.const -8
              i32.add
              i32.const 3
              i32.shr_u
              i32.const 1
              i32.add
              local.set 6
              local.get 2
              i32.load
              local.set 0
              loop ;; label = @5
                block ;; label = @6
                  local.get 0
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 7
                  i32.eqz
                  br_if 0 (;@6;)
                  local.get 3
                  i32.load
                  local.get 0
                  i32.load
                  local.get 7
                  local.get 3
                  i32.load offset=4
                  i32.load offset=12
                  call_indirect (type 4)
                  i32.eqz
                  br_if 0 (;@6;)
                  i32.const 1
                  local.set 1
                  br 5 (;@1;)
                end
                block ;; label = @6
                  local.get 1
                  i32.load
                  local.get 3
                  local.get 1
                  i32.const 4
                  i32.add
                  i32.load
                  call_indirect (type 2)
                  i32.eqz
                  br_if 0 (;@6;)
                  i32.const 1
                  local.set 1
                  br 5 (;@1;)
                end
                local.get 0
                i32.const 8
                i32.add
                local.set 0
                local.get 1
                i32.const 8
                i32.add
                local.tee 1
                local.get 5
                i32.eq
                br_if 3 (;@2;)
                br 0 (;@5;)
              end
            end
            local.get 1
            i32.const 24
            i32.mul
            local.set 8
            local.get 1
            i32.const -1
            i32.add
            i32.const 536870911
            i32.and
            i32.const 1
            i32.add
            local.set 6
            local.get 2
            i32.load offset=8
            local.set 9
            local.get 2
            i32.load
            local.set 0
            i32.const 0
            local.set 7
            loop ;; label = @4
              block ;; label = @5
                local.get 0
                i32.const 4
                i32.add
                i32.load
                local.tee 1
                i32.eqz
                br_if 0 (;@5;)
                local.get 3
                i32.load
                local.get 0
                i32.load
                local.get 1
                local.get 3
                i32.load offset=4
                i32.load offset=12
                call_indirect (type 4)
                i32.eqz
                br_if 0 (;@5;)
                i32.const 1
                local.set 1
                br 4 (;@1;)
              end
              i32.const 0
              local.set 5
              i32.const 0
              local.set 10
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 4
                    local.get 7
                    i32.add
                    local.tee 1
                    i32.const 8
                    i32.add
                    i32.load16_u
                    br_table 0 (;@7;) 1 (;@6;) 2 (;@5;) 0 (;@7;)
                  end
                  local.get 1
                  i32.const 10
                  i32.add
                  i32.load16_u
                  local.set 10
                  br 1 (;@5;)
                end
                local.get 9
                local.get 1
                i32.const 12
                i32.add
                i32.load
                i32.const 3
                i32.shl
                i32.add
                i32.load16_u offset=4
                local.set 10
              end
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 1
                    i32.load16_u
                    br_table 0 (;@7;) 1 (;@6;) 2 (;@5;) 0 (;@7;)
                  end
                  local.get 1
                  i32.const 2
                  i32.add
                  i32.load16_u
                  local.set 5
                  br 1 (;@5;)
                end
                local.get 9
                local.get 1
                i32.const 4
                i32.add
                i32.load
                i32.const 3
                i32.shl
                i32.add
                i32.load16_u offset=4
                local.set 5
              end
              local.get 3
              local.get 5
              i32.store16 offset=14
              local.get 3
              local.get 10
              i32.store16 offset=12
              local.get 3
              local.get 1
              i32.const 20
              i32.add
              i32.load
              i32.store offset=8
              block ;; label = @5
                local.get 9
                local.get 1
                i32.const 16
                i32.add
                i32.load
                i32.const 3
                i32.shl
                i32.add
                local.tee 1
                i32.load
                local.get 3
                local.get 1
                i32.load offset=4
                call_indirect (type 2)
                i32.eqz
                br_if 0 (;@5;)
                i32.const 1
                local.set 1
                br 4 (;@1;)
              end
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 8
              local.get 7
              i32.const 24
              i32.add
              local.tee 7
              i32.eq
              br_if 2 (;@2;)
              br 0 (;@4;)
            end
          end
          i32.const 0
          local.set 6
        end
        block ;; label = @2
          local.get 6
          local.get 2
          i32.load offset=4
          i32.ge_u
          br_if 0 (;@2;)
          local.get 3
          i32.load
          local.get 2
          i32.load
          local.get 6
          i32.const 3
          i32.shl
          i32.add
          local.tee 1
          i32.load
          local.get 1
          i32.load offset=4
          local.get 3
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          i32.eqz
          br_if 0 (;@2;)
          i32.const 1
          local.set 1
          br 1 (;@1;)
        end
        i32.const 0
        local.set 1
      end
      local.get 3
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN4core3fmt5Write9write_fmt17h6707361cac7c8b2eE (;200;) (type 2) (param i32 i32) (result i32)
      local.get 0
      global.get $GOT.data.internal.__memory_base
      i32.const 1058308
      i32.add
      local.get 1
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
    )
    (func $_ZN4core9panicking5panic17ha8927ffe3ffa2332E (;201;) (type 3) (param i32 i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      i32.const 0
      i32.store offset=16
      local.get 3
      i32.const 1
      i32.store offset=4
      local.get 3
      i64.const 4
      i64.store offset=8 align=4
      local.get 3
      local.get 1
      i32.store offset=28
      local.get 3
      local.get 0
      i32.store offset=24
      local.get 3
      local.get 3
      i32.const 24
      i32.add
      i32.store
      local.get 3
      local.get 2
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hb62a926b209c9a39E (;202;) (type 4) (param i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
      local.get 1
      i32.const -1
      i32.add
      local.set 3
      local.get 0
      i32.load offset=4
      local.set 4
      local.get 0
      i32.load
      local.set 5
      local.get 0
      i32.load offset=8
      local.set 6
      i32.const 0
      local.set 7
      i32.const 0
      local.set 8
      i32.const 0
      local.set 9
      i32.const 0
      local.set 10
      block ;; label = @1
        loop ;; label = @2
          local.get 10
          i32.const 1
          i32.and
          br_if 1 (;@1;)
          block ;; label = @3
            block ;; label = @4
              local.get 2
              local.get 9
              i32.lt_u
              br_if 0 (;@4;)
              loop ;; label = @5
                local.get 1
                local.get 9
                i32.add
                local.set 10
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          block ;; label = @11
                            local.get 2
                            local.get 9
                            i32.sub
                            local.tee 11
                            i32.const 7
                            i32.gt_u
                            br_if 0 (;@11;)
                            local.get 2
                            local.get 9
                            i32.ne
                            br_if 1 (;@10;)
                            local.get 2
                            local.set 9
                            br 7 (;@4;)
                          end
                          local.get 10
                          i32.const 3
                          i32.add
                          i32.const -4
                          i32.and
                          local.tee 0
                          local.get 10
                          i32.eq
                          br_if 1 (;@9;)
                          local.get 0
                          local.get 10
                          i32.sub
                          local.set 0
                          i32.const 0
                          local.set 12
                          loop ;; label = @11
                            local.get 10
                            local.get 12
                            i32.add
                            i32.load8_u
                            i32.const 10
                            i32.eq
                            br_if 5 (;@6;)
                            local.get 0
                            local.get 12
                            i32.const 1
                            i32.add
                            local.tee 12
                            i32.ne
                            br_if 0 (;@11;)
                          end
                          local.get 0
                          local.get 11
                          i32.const -8
                          i32.add
                          local.tee 13
                          i32.gt_u
                          br_if 3 (;@7;)
                          br 2 (;@8;)
                        end
                        i32.const 0
                        local.set 12
                        loop ;; label = @10
                          local.get 10
                          local.get 12
                          i32.add
                          i32.load8_u
                          i32.const 10
                          i32.eq
                          br_if 4 (;@6;)
                          local.get 11
                          local.get 12
                          i32.const 1
                          i32.add
                          local.tee 12
                          i32.ne
                          br_if 0 (;@10;)
                        end
                        local.get 2
                        local.set 9
                        br 5 (;@4;)
                      end
                      local.get 11
                      i32.const -8
                      i32.add
                      local.set 13
                      i32.const 0
                      local.set 0
                    end
                    loop ;; label = @8
                      i32.const 16843008
                      local.get 10
                      local.get 0
                      i32.add
                      local.tee 12
                      i32.load
                      local.tee 14
                      i32.const 168430090
                      i32.xor
                      i32.sub
                      local.get 14
                      i32.or
                      i32.const 16843008
                      local.get 12
                      i32.const 4
                      i32.add
                      i32.load
                      local.tee 12
                      i32.const 168430090
                      i32.xor
                      i32.sub
                      local.get 12
                      i32.or
                      i32.and
                      i32.const -2139062144
                      i32.and
                      i32.const -2139062144
                      i32.ne
                      br_if 1 (;@7;)
                      local.get 0
                      i32.const 8
                      i32.add
                      local.tee 0
                      local.get 13
                      i32.le_u
                      br_if 0 (;@8;)
                    end
                  end
                  block ;; label = @7
                    local.get 11
                    local.get 0
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 2
                    local.set 9
                    br 3 (;@4;)
                  end
                  loop ;; label = @7
                    block ;; label = @8
                      local.get 10
                      local.get 0
                      i32.add
                      i32.load8_u
                      i32.const 10
                      i32.ne
                      br_if 0 (;@8;)
                      local.get 0
                      local.set 12
                      br 2 (;@6;)
                    end
                    local.get 11
                    local.get 0
                    i32.const 1
                    i32.add
                    local.tee 0
                    i32.ne
                    br_if 0 (;@7;)
                  end
                  local.get 2
                  local.set 9
                  br 2 (;@4;)
                end
                local.get 9
                local.get 12
                i32.add
                local.tee 0
                i32.const 1
                i32.add
                local.set 9
                block ;; label = @6
                  local.get 0
                  local.get 2
                  i32.ge_u
                  br_if 0 (;@6;)
                  local.get 10
                  local.get 12
                  i32.add
                  i32.load8_u
                  i32.const 10
                  i32.ne
                  br_if 0 (;@6;)
                  i32.const 0
                  local.set 10
                  local.get 9
                  local.set 11
                  local.get 9
                  local.set 0
                  br 3 (;@3;)
                end
                local.get 2
                local.get 9
                i32.ge_u
                br_if 0 (;@5;)
              end
            end
            local.get 2
            local.get 8
            i32.eq
            br_if 2 (;@1;)
            i32.const 1
            local.set 10
            local.get 8
            local.set 11
            local.get 2
            local.set 0
          end
          block ;; label = @3
            block ;; label = @4
              local.get 6
              i32.load8_u
              i32.eqz
              br_if 0 (;@4;)
              local.get 5
              global.get $GOT.data.internal.__memory_base
              i32.const 1056699
              i32.add
              i32.const 4
              local.get 4
              i32.load offset=12
              call_indirect (type 4)
              br_if 1 (;@3;)
            end
            local.get 0
            local.get 8
            i32.sub
            local.set 14
            i32.const 0
            local.set 12
            block ;; label = @4
              local.get 0
              local.get 8
              i32.eq
              br_if 0 (;@4;)
              local.get 3
              local.get 0
              i32.add
              i32.load8_u
              i32.const 10
              i32.eq
              local.set 12
            end
            local.get 1
            local.get 8
            i32.add
            local.set 0
            local.get 6
            local.get 12
            i32.store8
            local.get 11
            local.set 8
            local.get 5
            local.get 0
            local.get 14
            local.get 4
            i32.load offset=12
            call_indirect (type 4)
            i32.eqz
            br_if 1 (;@2;)
          end
        end
        i32.const 1
        local.set 7
      end
      local.get 7
    )
    (func $_ZN4core3fmt8builders11DebugStruct5field17h2232ee3137e12257E (;203;) (type 12) (param i32 i32 i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 5
      global.set $__stack_pointer
      i32.const 1
      local.set 6
      block ;; label = @1
        local.get 0
        i32.load8_u offset=4
        br_if 0 (;@1;)
        local.get 0
        i32.load8_u offset=5
        local.set 7
        block ;; label = @2
          local.get 0
          i32.load
          local.tee 8
          i32.load8_u offset=10
          i32.const 128
          i32.and
          br_if 0 (;@2;)
          i32.const 1
          local.set 6
          global.get $GOT.data.internal.__memory_base
          local.set 9
          local.get 8
          i32.load
          local.get 9
          i32.const 1054445
          i32.add
          local.get 9
          i32.const 1054454
          i32.add
          local.get 7
          i32.const 1
          i32.and
          local.tee 7
          select
          i32.const 2
          i32.const 3
          local.get 7
          select
          local.get 8
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
          local.get 8
          i32.load
          local.get 1
          local.get 2
          local.get 8
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
          global.get $GOT.data.internal.__memory_base
          local.set 2
          local.get 8
          i32.load
          local.get 2
          i32.const 1054457
          i32.add
          i32.const 2
          local.get 8
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
          local.get 3
          local.get 8
          local.get 4
          i32.load offset=12
          call_indirect (type 2)
          local.set 6
          br 1 (;@1;)
        end
        i32.const 1
        local.set 6
        block ;; label = @2
          local.get 7
          i32.const 1
          i32.and
          br_if 0 (;@2;)
          global.get $GOT.data.internal.__memory_base
          local.set 7
          local.get 8
          i32.load
          local.get 7
          i32.const 1054459
          i32.add
          i32.const 3
          local.get 8
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
        end
        i32.const 1
        local.set 6
        local.get 5
        i32.const 1
        i32.store8 offset=15
        local.get 5
        global.get $GOT.data.internal.__memory_base
        i32.const 1058308
        i32.add
        i32.store offset=20
        local.get 5
        local.get 8
        i64.load align=4
        i64.store align=4
        local.get 5
        local.get 8
        i64.load offset=8 align=4
        i64.store offset=24 align=4
        local.get 5
        local.get 5
        i32.const 15
        i32.add
        i32.store offset=8
        local.get 5
        local.get 5
        i32.store offset=16
        local.get 5
        local.get 1
        local.get 2
        call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hb62a926b209c9a39E
        br_if 0 (;@1;)
        local.get 5
        global.get $GOT.data.internal.__memory_base
        i32.const 1054457
        i32.add
        i32.const 2
        call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17hb62a926b209c9a39E
        br_if 0 (;@1;)
        local.get 3
        local.get 5
        i32.const 16
        i32.add
        local.get 4
        i32.load offset=12
        call_indirect (type 2)
        br_if 0 (;@1;)
        global.get $GOT.data.internal.__memory_base
        local.set 6
        local.get 5
        i32.load offset=16
        local.get 6
        i32.const 1054447
        i32.add
        i32.const 2
        local.get 5
        i32.load offset=20
        i32.load offset=12
        call_indirect (type 4)
        local.set 6
      end
      local.get 0
      i32.const 1
      i32.store8 offset=5
      local.get 0
      local.get 6
      i32.store8 offset=4
      local.get 5
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h84bc924cb6b06b2aE (;204;) (type 12) (param i32 i32 i32 i32 i32) (result i32)
      block ;; label = @1
        local.get 2
        i32.const 1114112
        i32.eq
        br_if 0 (;@1;)
        local.get 0
        local.get 2
        local.get 1
        i32.load offset=16
        call_indirect (type 2)
        i32.eqz
        br_if 0 (;@1;)
        i32.const 1
        return
      end
      block ;; label = @1
        local.get 3
        br_if 0 (;@1;)
        i32.const 0
        return
      end
      local.get 0
      local.get 3
      local.get 4
      local.get 1
      i32.load offset=12
      call_indirect (type 4)
    )
    (func $_ZN4core3str5count14do_count_chars17h51df80c571f91e4bE (;205;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          local.get 1
          local.get 0
          i32.const 3
          i32.add
          i32.const -4
          i32.and
          local.tee 2
          local.get 0
          i32.sub
          local.tee 3
          i32.lt_u
          br_if 0 (;@2;)
          local.get 1
          local.get 3
          i32.sub
          local.tee 4
          i32.const 4
          i32.lt_u
          br_if 0 (;@2;)
          local.get 4
          i32.const 3
          i32.and
          local.set 5
          i32.const 0
          local.set 6
          i32.const 0
          local.set 1
          block ;; label = @3
            local.get 2
            local.get 0
            i32.eq
            br_if 0 (;@3;)
            i32.const 0
            local.set 1
            i32.const 0
            local.set 7
            block ;; label = @4
              local.get 0
              local.get 2
              i32.sub
              local.tee 8
              i32.const -4
              i32.gt_u
              br_if 0 (;@4;)
              i32.const 0
              local.set 1
              i32.const 0
              local.set 7
              loop ;; label = @5
                local.get 1
                local.get 0
                local.get 7
                i32.add
                local.tee 2
                i32.load8_s
                i32.const -65
                i32.gt_s
                i32.add
                local.get 2
                i32.const 1
                i32.add
                i32.load8_s
                i32.const -65
                i32.gt_s
                i32.add
                local.get 2
                i32.const 2
                i32.add
                i32.load8_s
                i32.const -65
                i32.gt_s
                i32.add
                local.get 2
                i32.const 3
                i32.add
                i32.load8_s
                i32.const -65
                i32.gt_s
                i32.add
                local.set 1
                local.get 7
                i32.const 4
                i32.add
                local.tee 7
                br_if 0 (;@5;)
              end
            end
            local.get 0
            local.get 7
            i32.add
            local.set 2
            loop ;; label = @4
              local.get 1
              local.get 2
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 2
              i32.const 1
              i32.add
              local.set 2
              local.get 8
              i32.const 1
              i32.add
              local.tee 8
              br_if 0 (;@4;)
            end
          end
          local.get 0
          local.get 3
          i32.add
          local.set 8
          block ;; label = @3
            local.get 5
            i32.eqz
            br_if 0 (;@3;)
            local.get 8
            local.get 4
            i32.const -4
            i32.and
            i32.add
            local.tee 2
            i32.load8_s
            i32.const -65
            i32.gt_s
            local.set 6
            local.get 5
            i32.const 1
            i32.eq
            br_if 0 (;@3;)
            local.get 6
            local.get 2
            i32.load8_s offset=1
            i32.const -65
            i32.gt_s
            i32.add
            local.set 6
            local.get 5
            i32.const 2
            i32.eq
            br_if 0 (;@3;)
            local.get 6
            local.get 2
            i32.load8_s offset=2
            i32.const -65
            i32.gt_s
            i32.add
            local.set 6
          end
          local.get 4
          i32.const 2
          i32.shr_u
          local.set 3
          local.get 6
          local.get 1
          i32.add
          local.set 7
          loop ;; label = @3
            local.get 8
            local.set 4
            local.get 3
            i32.eqz
            br_if 2 (;@1;)
            local.get 3
            i32.const 192
            local.get 3
            i32.const 192
            i32.lt_u
            select
            local.tee 6
            i32.const 3
            i32.and
            local.set 5
            block ;; label = @4
              block ;; label = @5
                local.get 6
                i32.const 2
                i32.shl
                local.tee 9
                i32.const 1008
                i32.and
                local.tee 1
                br_if 0 (;@5;)
                i32.const 0
                local.set 2
                br 1 (;@4;)
              end
              local.get 4
              local.get 1
              i32.add
              local.set 0
              i32.const 0
              local.set 2
              local.get 4
              local.set 1
              loop ;; label = @5
                local.get 1
                i32.const 12
                i32.add
                i32.load
                local.tee 8
                i32.const -1
                i32.xor
                i32.const 7
                i32.shr_u
                local.get 8
                i32.const 6
                i32.shr_u
                i32.or
                i32.const 16843009
                i32.and
                local.get 1
                i32.const 8
                i32.add
                i32.load
                local.tee 8
                i32.const -1
                i32.xor
                i32.const 7
                i32.shr_u
                local.get 8
                i32.const 6
                i32.shr_u
                i32.or
                i32.const 16843009
                i32.and
                local.get 1
                i32.const 4
                i32.add
                i32.load
                local.tee 8
                i32.const -1
                i32.xor
                i32.const 7
                i32.shr_u
                local.get 8
                i32.const 6
                i32.shr_u
                i32.or
                i32.const 16843009
                i32.and
                local.get 1
                i32.load
                local.tee 8
                i32.const -1
                i32.xor
                i32.const 7
                i32.shr_u
                local.get 8
                i32.const 6
                i32.shr_u
                i32.or
                i32.const 16843009
                i32.and
                local.get 2
                i32.add
                i32.add
                i32.add
                i32.add
                local.set 2
                local.get 1
                i32.const 16
                i32.add
                local.tee 1
                local.get 0
                i32.ne
                br_if 0 (;@5;)
              end
            end
            local.get 3
            local.get 6
            i32.sub
            local.set 3
            local.get 4
            local.get 9
            i32.add
            local.set 8
            local.get 2
            i32.const 8
            i32.shr_u
            i32.const 16711935
            i32.and
            local.get 2
            i32.const 16711935
            i32.and
            i32.add
            i32.const 65537
            i32.mul
            i32.const 16
            i32.shr_u
            local.get 7
            i32.add
            local.set 7
            local.get 5
            i32.eqz
            br_if 0 (;@3;)
          end
          local.get 4
          local.get 6
          i32.const 252
          i32.and
          i32.const 2
          i32.shl
          i32.add
          local.tee 2
          i32.load
          local.tee 1
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 1
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.set 1
          block ;; label = @3
            local.get 5
            i32.const 1
            i32.eq
            br_if 0 (;@3;)
            local.get 2
            i32.load offset=4
            local.tee 8
            i32.const -1
            i32.xor
            i32.const 7
            i32.shr_u
            local.get 8
            i32.const 6
            i32.shr_u
            i32.or
            i32.const 16843009
            i32.and
            local.get 1
            i32.add
            local.set 1
            local.get 5
            i32.const 2
            i32.eq
            br_if 0 (;@3;)
            local.get 2
            i32.load offset=8
            local.tee 2
            i32.const -1
            i32.xor
            i32.const 7
            i32.shr_u
            local.get 2
            i32.const 6
            i32.shr_u
            i32.or
            i32.const 16843009
            i32.and
            local.get 1
            i32.add
            local.set 1
          end
          local.get 1
          i32.const 8
          i32.shr_u
          i32.const 459007
          i32.and
          local.get 1
          i32.const 16711935
          i32.and
          i32.add
          i32.const 65537
          i32.mul
          i32.const 16
          i32.shr_u
          local.get 7
          i32.add
          local.set 7
          br 1 (;@1;)
        end
        block ;; label = @2
          local.get 1
          br_if 0 (;@2;)
          i32.const 0
          return
        end
        local.get 1
        i32.const 3
        i32.and
        local.set 8
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.const 4
            i32.ge_u
            br_if 0 (;@3;)
            i32.const 0
            local.set 7
            i32.const 0
            local.set 2
            br 1 (;@2;)
          end
          local.get 1
          i32.const -4
          i32.and
          local.set 3
          i32.const 0
          local.set 7
          i32.const 0
          local.set 2
          loop ;; label = @3
            local.get 7
            local.get 0
            local.get 2
            i32.add
            local.tee 1
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 1
            i32.const 1
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 1
            i32.const 2
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 1
            i32.const 3
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 7
            local.get 3
            local.get 2
            i32.const 4
            i32.add
            local.tee 2
            i32.ne
            br_if 0 (;@3;)
          end
        end
        local.get 8
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        local.get 2
        i32.add
        local.set 1
        loop ;; label = @2
          local.get 7
          local.get 1
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 7
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 8
          i32.const -1
          i32.add
          local.tee 8
          br_if 0 (;@2;)
        end
      end
      local.get 7
    )
    (func $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h0b6484f914d461a8E (;206;) (type 12) (param i32 i32 i32 i32 i32) (result i32)
      (local i32 i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 5
      global.set $__stack_pointer
      i32.const 1
      local.set 6
      block ;; label = @1
        local.get 0
        i32.load
        local.tee 7
        local.get 1
        local.get 2
        local.get 0
        i32.load offset=4
        local.tee 8
        i32.load offset=12
        local.tee 9
        call_indirect (type 4)
        br_if 0 (;@1;)
        block ;; label = @2
          block ;; label = @3
            local.get 0
            i32.load8_u offset=10
            i32.const 128
            i32.and
            br_if 0 (;@3;)
            i32.const 1
            local.set 6
            local.get 7
            global.get $GOT.data.internal.__memory_base
            i32.const 1054449
            i32.add
            i32.const 1
            local.get 9
            call_indirect (type 4)
            br_if 2 (;@1;)
            local.get 3
            local.get 0
            local.get 4
            i32.load offset=12
            call_indirect (type 2)
            i32.eqz
            br_if 1 (;@2;)
            br 2 (;@1;)
          end
          local.get 7
          global.get $GOT.data.internal.__memory_base
          i32.const 1054450
          i32.add
          i32.const 2
          local.get 9
          call_indirect (type 4)
          br_if 1 (;@1;)
          i32.const 1
          local.set 6
          local.get 5
          i32.const 1
          i32.store8 offset=15
          local.get 5
          local.get 8
          i32.store offset=4
          local.get 5
          local.get 7
          i32.store
          local.get 5
          global.get $GOT.data.internal.__memory_base
          i32.const 1058308
          i32.add
          i32.store offset=20
          local.get 5
          local.get 0
          i64.load offset=8 align=4
          i64.store offset=24 align=4
          local.get 5
          local.get 5
          i32.const 15
          i32.add
          i32.store offset=8
          local.get 5
          local.get 5
          i32.store offset=16
          local.get 3
          local.get 5
          i32.const 16
          i32.add
          local.get 4
          i32.load offset=12
          call_indirect (type 2)
          br_if 1 (;@1;)
          global.get $GOT.data.internal.__memory_base
          local.set 1
          local.get 5
          i32.load offset=16
          local.get 1
          i32.const 1054447
          i32.add
          i32.const 2
          local.get 5
          i32.load offset=20
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
        end
        block ;; label = @2
          local.get 2
          br_if 0 (;@2;)
          local.get 0
          i32.load8_u offset=10
          i32.const 128
          i32.and
          br_if 0 (;@2;)
          global.get $GOT.data.internal.__memory_base
          local.set 2
          i32.const 1
          local.set 6
          local.get 0
          i32.load
          local.get 2
          i32.const 1054453
          i32.add
          i32.const 1
          local.get 0
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          br_if 1 (;@1;)
        end
        global.get $GOT.data.internal.__memory_base
        local.set 6
        local.get 0
        i32.load
        local.get 6
        i32.const 1054452
        i32.add
        i32.const 1
        local.get 0
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 4)
        local.set 6
      end
      local.get 5
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 6
    )
    (func $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h5ecaa9e0e5a3130bE (;207;) (type 13) (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 11
      global.set $__stack_pointer
      local.get 0
      i32.load
      local.get 1
      local.get 2
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 4)
      local.set 2
      local.get 11
      i32.const 0
      i32.store8 offset=13
      local.get 11
      local.get 2
      i32.store8 offset=12
      local.get 11
      local.get 0
      i32.store offset=8
      local.get 11
      i32.const 8
      i32.add
      local.get 3
      local.get 4
      local.get 5
      local.get 6
      call $_ZN4core3fmt8builders11DebugStruct5field17h2232ee3137e12257E
      local.get 7
      local.get 8
      local.get 9
      local.get 10
      call $_ZN4core3fmt8builders11DebugStruct5field17h2232ee3137e12257E
      local.set 10
      local.get 11
      i32.load8_u offset=13
      local.tee 2
      local.get 11
      i32.load8_u offset=12
      local.tee 1
      i32.or
      local.set 0
      block ;; label = @1
        local.get 2
        i32.const 1
        i32.ne
        br_if 0 (;@1;)
        local.get 1
        i32.const 1
        i32.and
        br_if 0 (;@1;)
        block ;; label = @2
          local.get 10
          i32.load
          local.tee 0
          i32.load8_u offset=10
          i32.const 128
          i32.and
          br_if 0 (;@2;)
          global.get $GOT.data.internal.__memory_base
          local.set 2
          local.get 0
          i32.load
          local.get 2
          i32.const 1054463
          i32.add
          i32.const 2
          local.get 0
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          local.set 0
          br 1 (;@1;)
        end
        global.get $GOT.data.internal.__memory_base
        local.set 2
        local.get 0
        i32.load
        local.get 2
        i32.const 1054462
        i32.add
        i32.const 1
        local.get 0
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 4)
        local.set 0
      end
      local.get 11
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
      i32.const 1
      i32.and
    )
    (func $_ZN4core3fmt9Formatter9write_str17h2218e50d8c415133E (;208;) (type 4) (param i32 i32 i32) (result i32)
      local.get 0
      i32.load
      local.get 1
      local.get 2
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 4)
    )
    (func $_ZN4core3str19slice_error_fail_rt17habd119a0c33c303eE (;209;) (type 10) (param i32 i32 i32 i32 i32)
      (local i32 i32 i32 i64)
      global.get $__stack_pointer
      i32.const 112
      i32.sub
      local.tee 5
      global.set $__stack_pointer
      local.get 5
      local.get 3
      i32.store offset=12
      local.get 5
      local.get 2
      i32.store offset=8
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  local.get 1
                  i32.const 257
                  i32.lt_u
                  br_if 0 (;@6;)
                  i32.const 253
                  local.set 6
                  loop ;; label = @7
                    local.get 0
                    local.get 6
                    i32.add
                    local.tee 7
                    i32.const 3
                    i32.add
                    i32.load8_s
                    i32.const -65
                    i32.gt_s
                    br_if 3 (;@4;)
                    local.get 7
                    i32.const 2
                    i32.add
                    i32.load8_s
                    i32.const -65
                    i32.gt_s
                    br_if 2 (;@5;)
                    local.get 7
                    i32.const 1
                    i32.add
                    i32.load8_s
                    i32.const -65
                    i32.gt_s
                    br_if 4 (;@3;)
                    local.get 7
                    i32.load8_s
                    i32.const -65
                    i32.gt_s
                    br_if 5 (;@2;)
                    local.get 6
                    i32.const -4
                    i32.add
                    local.tee 6
                    i32.const -3
                    i32.ne
                    br_if 0 (;@7;)
                  end
                  i32.const 0
                  local.set 6
                  br 4 (;@2;)
                end
                local.get 5
                local.get 1
                i32.store offset=20
                local.get 5
                local.get 0
                i32.store offset=16
                i32.const 0
                local.set 7
                i32.const 1
                local.set 6
                br 4 (;@1;)
              end
              local.get 6
              i32.const 2
              i32.add
              local.set 6
              br 2 (;@2;)
            end
            local.get 6
            i32.const 3
            i32.add
            local.set 6
            br 1 (;@2;)
          end
          local.get 6
          i32.const 1
          i32.add
          local.set 6
        end
        local.get 5
        local.get 0
        i32.store offset=16
        global.get $GOT.data.internal.__memory_base
        local.set 7
        local.get 5
        local.get 6
        i32.store offset=20
        local.get 7
        i32.const 1054721
        i32.add
        i32.const 1
        local.get 6
        local.get 1
        i32.lt_u
        local.tee 7
        select
        local.set 6
        i32.const 5
        i32.const 0
        local.get 7
        select
        local.set 7
      end
      local.get 5
      local.get 7
      i32.store offset=28
      local.get 5
      local.get 6
      i32.store offset=24
      block ;; label = @1
        block ;; label = @2
          local.get 2
          local.get 1
          i32.gt_u
          br_if 0 (;@2;)
          local.get 3
          local.get 1
          i32.le_u
          br_if 1 (;@1;)
          local.get 3
          local.set 2
        end
        local.get 5
        local.get 2
        i32.store offset=40
        local.get 5
        i32.const 3
        i32.store offset=52
        local.get 5
        global.get $GOT.data.internal.__memory_base
        i32.const 1058404
        i32.add
        i32.store offset=48
        local.get 5
        i64.const 3
        i64.store offset=60 align=4
        local.get 5
        global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 5
        i32.const 40
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=72
        local.get 5
        global.get $GOT.data.internal.__table_base
        i32.const 70
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.tee 8
        local.get 5
        i32.const 24
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=88
        local.get 5
        local.get 8
        local.get 5
        i32.const 16
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=80
        local.get 5
        local.get 5
        i32.const 72
        i32.add
        i32.store offset=56
        local.get 5
        i32.const 48
        i32.add
        local.get 4
        call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
        unreachable
      end
      block ;; label = @1
        local.get 2
        local.get 3
        i32.gt_u
        br_if 0 (;@1;)
        block ;; label = @2
          local.get 2
          i32.eqz
          br_if 0 (;@2;)
          local.get 2
          local.get 1
          i32.ge_u
          br_if 0 (;@2;)
          local.get 5
          i32.const 12
          i32.add
          local.get 5
          i32.const 8
          i32.add
          local.get 0
          local.get 2
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          select
          i32.load
          local.set 3
        end
        local.get 5
        local.get 3
        i32.store offset=32
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 3
              local.get 1
              i32.ge_u
              br_if 0 (;@4;)
              i32.const 0
              local.set 7
              block ;; label = @5
                local.get 3
                i32.eqz
                br_if 0 (;@5;)
                loop ;; label = @6
                  block ;; label = @7
                    local.get 0
                    local.get 3
                    i32.add
                    i32.load8_s
                    i32.const -65
                    i32.le_s
                    br_if 0 (;@7;)
                    local.get 3
                    local.set 7
                    br 2 (;@5;)
                  end
                  local.get 3
                  i32.const -1
                  i32.add
                  local.tee 3
                  br_if 0 (;@6;)
                end
              end
              local.get 7
              local.get 1
              i32.eq
              br_if 0 (;@4;)
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    local.get 0
                    local.get 7
                    i32.add
                    local.tee 0
                    i32.load8_s
                    local.tee 6
                    i32.const -1
                    i32.gt_s
                    br_if 0 (;@7;)
                    local.get 0
                    i32.load8_u offset=1
                    i32.const 63
                    i32.and
                    local.set 3
                    local.get 6
                    i32.const 31
                    i32.and
                    local.set 1
                    local.get 6
                    i32.const -33
                    i32.gt_u
                    br_if 1 (;@6;)
                    local.get 1
                    i32.const 6
                    i32.shl
                    local.get 3
                    i32.or
                    local.set 6
                    br 2 (;@5;)
                  end
                  local.get 5
                  local.get 6
                  i32.const 255
                  i32.and
                  i32.store offset=36
                  i32.const 1
                  local.set 6
                  br 4 (;@2;)
                end
                local.get 3
                i32.const 6
                i32.shl
                local.get 0
                i32.load8_u offset=2
                i32.const 63
                i32.and
                i32.or
                local.set 3
                block ;; label = @6
                  local.get 6
                  i32.const -16
                  i32.ge_u
                  br_if 0 (;@6;)
                  local.get 3
                  local.get 1
                  i32.const 12
                  i32.shl
                  i32.or
                  local.set 6
                  br 1 (;@5;)
                end
                local.get 3
                i32.const 6
                i32.shl
                local.get 0
                i32.load8_u offset=3
                i32.const 63
                i32.and
                i32.or
                local.get 1
                i32.const 18
                i32.shl
                i32.const 1835008
                i32.and
                i32.or
                local.tee 6
                i32.const 1114112
                i32.eq
                br_if 1 (;@4;)
              end
              local.get 5
              local.get 6
              i32.store offset=36
              local.get 6
              i32.const 128
              i32.ge_u
              br_if 1 (;@3;)
              i32.const 1
              local.set 6
              br 2 (;@2;)
            end
            local.get 4
            call $_ZN4core6option13unwrap_failed17h37f20c15ca5e53d0E
            unreachable
          end
          block ;; label = @3
            local.get 6
            i32.const 2048
            i32.ge_u
            br_if 0 (;@3;)
            i32.const 2
            local.set 6
            br 1 (;@2;)
          end
          i32.const 3
          i32.const 4
          local.get 6
          i32.const 65536
          i32.lt_u
          select
          local.set 6
        end
        local.get 5
        local.get 7
        i32.store offset=40
        local.get 5
        local.get 6
        local.get 7
        i32.add
        i32.store offset=44
        local.get 5
        i32.const 5
        i32.store offset=52
        local.get 5
        global.get $GOT.data.internal.__memory_base
        i32.const 1058364
        i32.add
        i32.store offset=48
        local.get 5
        i64.const 5
        i64.store offset=60 align=4
        local.get 5
        global.get $GOT.data.internal.__table_base
        local.tee 7
        i32.const 70
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.tee 8
        local.get 5
        i32.const 24
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=104
        local.get 5
        local.get 8
        local.get 5
        i32.const 16
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=96
        local.get 5
        local.get 7
        i32.const 71
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 5
        i32.const 40
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=88
        local.get 5
        global.get $GOT.func.internal._ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17had6411be8545c4e2E
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 5
        i32.const 36
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=80
        local.get 5
        global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 5
        i32.const 32
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=72
        local.get 5
        local.get 5
        i32.const 72
        i32.add
        i32.store offset=56
        local.get 5
        i32.const 48
        i32.add
        local.get 4
        call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
        unreachable
      end
      local.get 5
      i32.const 4
      i32.store offset=52
      local.get 5
      i64.const 4
      i64.store offset=60 align=4
      local.get 5
      global.get $GOT.data.internal.__memory_base
      i32.const 1058332
      i32.add
      i32.store offset=48
      local.get 5
      global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 8
      local.get 5
      i32.const 12
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=80
      local.get 5
      local.get 8
      local.get 5
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=72
      local.get 5
      global.get $GOT.data.internal.__table_base
      i32.const 70
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 8
      local.get 5
      i32.const 24
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=96
      local.get 5
      local.get 8
      local.get 5
      i32.const 16
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=88
      local.get 5
      local.get 5
      i32.const 72
      i32.add
      i32.store offset=56
      local.get 5
      i32.const 48
      i32.add
      local.get 4
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN4core6option13unwrap_failed17h37f20c15ca5e53d0E (;210;) (type 0) (param i32)
      global.get $GOT.data.internal.__memory_base
      i32.const 1054959
      i32.add
      i32.const 43
      local.get 0
      call $_ZN4core9panicking5panic17ha8927ffe3ffa2332E
      unreachable
    )
    (func $_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5c7189ec8b57c2a3E (;211;) (type 2) (param i32 i32) (result i32)
      (local i32 i32 i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 1
              i32.load offset=8
              local.tee 3
              i32.const 33554432
              i32.and
              br_if 0 (;@4;)
              local.get 3
              i32.const 67108864
              i32.and
              br_if 1 (;@3;)
              local.get 0
              local.get 1
              call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
              i32.eqz
              br_if 2 (;@2;)
              i32.const 1
              local.set 3
              br 3 (;@1;)
            end
            local.get 0
            i32.load
            local.set 3
            i32.const 0
            local.set 4
            loop ;; label = @4
              local.get 2
              i32.const 8
              i32.add
              local.get 4
              i32.add
              i32.const 7
              i32.add
              global.get $GOT.data.internal.__memory_base
              i32.const 1054411
              i32.add
              local.get 3
              i32.const 15
              i32.and
              i32.add
              i32.load8_u
              i32.store8
              local.get 4
              i32.const -1
              i32.add
              local.set 4
              local.get 3
              i32.const 16
              i32.lt_u
              local.set 5
              local.get 3
              i32.const 4
              i32.shr_u
              local.set 3
              local.get 5
              i32.eqz
              br_if 0 (;@4;)
            end
            i32.const 1
            local.set 3
            local.get 1
            i32.const 1
            global.get $GOT.data.internal.__memory_base
            i32.const 1054427
            i32.add
            i32.const 2
            local.get 2
            i32.const 8
            i32.add
            local.get 4
            i32.add
            i32.const 8
            i32.add
            i32.const 0
            local.get 4
            i32.sub
            call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
            i32.eqz
            br_if 1 (;@2;)
            br 2 (;@1;)
          end
          local.get 0
          i32.load
          local.set 3
          i32.const 0
          local.set 4
          loop ;; label = @3
            local.get 2
            i32.const 8
            i32.add
            local.get 4
            i32.add
            i32.const 7
            i32.add
            global.get $GOT.data.internal.__memory_base
            i32.const 1054429
            i32.add
            local.get 3
            i32.const 15
            i32.and
            i32.add
            i32.load8_u
            i32.store8
            local.get 4
            i32.const -1
            i32.add
            local.set 4
            local.get 3
            i32.const 15
            i32.gt_u
            local.set 5
            local.get 3
            i32.const 4
            i32.shr_u
            local.set 3
            local.get 5
            br_if 0 (;@3;)
          end
          i32.const 1
          local.set 3
          local.get 1
          i32.const 1
          global.get $GOT.data.internal.__memory_base
          i32.const 1054427
          i32.add
          i32.const 2
          local.get 2
          i32.const 8
          i32.add
          local.get 4
          i32.add
          i32.const 8
          i32.add
          i32.const 0
          local.get 4
          i32.sub
          call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
          br_if 1 (;@1;)
        end
        global.get $GOT.data.internal.__memory_base
        local.set 3
        block ;; label = @2
          local.get 1
          i32.load
          local.get 3
          i32.const 1056673
          i32.add
          i32.const 2
          local.get 1
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 4)
          i32.eqz
          br_if 0 (;@2;)
          i32.const 1
          local.set 3
          br 1 (;@1;)
        end
        local.get 0
        i32.const 4
        i32.add
        local.set 3
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.load offset=8
            local.tee 4
            i32.const 33554432
            i32.and
            br_if 0 (;@3;)
            local.get 4
            i32.const 67108864
            i32.and
            br_if 1 (;@2;)
            local.get 3
            local.get 1
            call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
            local.set 3
            br 2 (;@1;)
          end
          local.get 3
          i32.load
          local.set 3
          i32.const 0
          local.set 4
          loop ;; label = @3
            local.get 2
            i32.const 8
            i32.add
            local.get 4
            i32.add
            i32.const 7
            i32.add
            global.get $GOT.data.internal.__memory_base
            i32.const 1054411
            i32.add
            local.get 3
            i32.const 15
            i32.and
            i32.add
            i32.load8_u
            i32.store8
            local.get 4
            i32.const -1
            i32.add
            local.set 4
            local.get 3
            i32.const 15
            i32.gt_u
            local.set 5
            local.get 3
            i32.const 4
            i32.shr_u
            local.set 3
            local.get 5
            br_if 0 (;@3;)
          end
          local.get 1
          i32.const 1
          global.get $GOT.data.internal.__memory_base
          i32.const 1054427
          i32.add
          i32.const 2
          local.get 2
          i32.const 8
          i32.add
          local.get 4
          i32.add
          i32.const 8
          i32.add
          i32.const 0
          local.get 4
          i32.sub
          call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
          local.set 3
          br 1 (;@1;)
        end
        local.get 3
        i32.load
        local.set 3
        i32.const 0
        local.set 4
        loop ;; label = @2
          local.get 2
          i32.const 8
          i32.add
          local.get 4
          i32.add
          i32.const 7
          i32.add
          global.get $GOT.data.internal.__memory_base
          i32.const 1054429
          i32.add
          local.get 3
          i32.const 15
          i32.and
          i32.add
          i32.load8_u
          i32.store8
          local.get 4
          i32.const -1
          i32.add
          local.set 4
          local.get 3
          i32.const 15
          i32.gt_u
          local.set 5
          local.get 3
          i32.const 4
          i32.shr_u
          local.set 3
          local.get 5
          br_if 0 (;@2;)
        end
        local.get 1
        i32.const 1
        global.get $GOT.data.internal.__memory_base
        i32.const 1054427
        i32.add
        i32.const 2
        local.get 2
        i32.const 8
        i32.add
        local.get 4
        i32.add
        i32.const 8
        i32.add
        i32.const 0
        local.get 4
        i32.sub
        call $_ZN4core3fmt9Formatter12pad_integral17h5070c041e530f060E
        local.set 3
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 3
    )
    (func $_ZN4core4cell22panic_already_borrowed17hea6cbdb897553084E (;212;) (type 0) (param i32)
      local.get 0
      call $_ZN4core4cell22panic_already_borrowed8do_panic7runtime17h0dd423d8a571a94aE
      unreachable
    )
    (func $_ZN4core4cell22panic_already_borrowed8do_panic7runtime17h0dd423d8a571a94aE (;213;) (type 0) (param i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 1
      i32.const 1
      i32.store offset=12
      local.get 1
      i64.const 1
      i64.store offset=20 align=4
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1054848
      i32.add
      i32.store offset=8
      local.get 1
      global.get $GOT.func.internal._ZN65_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Display$GT$3fmt17h8e75564e2bf34426E
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 1
      i32.const 47
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 1
      local.get 1
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 1
      i32.const 8
      i32.add
      local.get 0
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN65_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Display$GT$3fmt17h8e75564e2bf34426E (;214;) (type 2) (param i32 i32) (result i32)
      local.get 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1056675
      i32.add
      i32.const 24
      call $_ZN4core3fmt9Formatter3pad17h218c4ce82702ca8dE
    )
    (func $_ZN4core7unicode12unicode_data15grapheme_extend11lookup_slow17hfa6fbe5f22d576d4E (;215;) (type 9) (param i32) (result i32)
      (local i32 i32 i32 i32 i32)
      i32.const 0
      local.set 1
      global.get $GOT.data.internal.__memory_base
      i32.const 1055004
      i32.add
      local.tee 2
      local.get 2
      i32.const 0
      i32.const 17
      local.get 0
      i32.const 71727
      i32.lt_u
      select
      local.tee 3
      local.get 3
      i32.const 8
      i32.or
      local.tee 3
      local.get 2
      local.get 3
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.const 11
      i32.shl
      local.get 0
      i32.const 11
      i32.shl
      local.tee 3
      i32.gt_u
      select
      local.tee 4
      local.get 4
      i32.const 4
      i32.or
      local.tee 4
      local.get 2
      local.get 4
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.const 11
      i32.shl
      local.get 3
      i32.gt_u
      select
      local.tee 4
      local.get 4
      i32.const 2
      i32.or
      local.tee 4
      local.get 2
      local.get 4
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.const 11
      i32.shl
      local.get 3
      i32.gt_u
      select
      local.tee 4
      local.get 4
      i32.const 1
      i32.add
      local.tee 4
      local.get 2
      local.get 4
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.const 11
      i32.shl
      local.get 3
      i32.gt_u
      select
      local.tee 4
      local.get 4
      i32.const 1
      i32.add
      local.tee 4
      local.get 2
      local.get 4
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.const 11
      i32.shl
      local.get 3
      i32.gt_u
      select
      local.tee 4
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.const 11
      i32.shl
      local.tee 2
      local.get 3
      i32.eq
      local.get 2
      local.get 3
      i32.lt_u
      i32.add
      local.get 4
      i32.add
      local.tee 4
      i32.const 2
      i32.shl
      i32.add
      local.tee 5
      i32.load
      i32.const 21
      i32.shr_u
      local.set 2
      i32.const 751
      local.set 3
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i32.const 32
          i32.gt_u
          br_if 0 (;@2;)
          local.get 5
          i32.load offset=4
          i32.const 21
          i32.shr_u
          local.set 3
          local.get 4
          i32.eqz
          br_if 1 (;@1;)
        end
        local.get 5
        i32.const -4
        i32.add
        i32.load
        i32.const 2097151
        i32.and
        local.set 1
      end
      block ;; label = @1
        local.get 3
        local.get 2
        i32.const -1
        i32.xor
        i32.add
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        local.get 1
        i32.sub
        local.set 0
        local.get 3
        i32.const -1
        i32.add
        local.set 4
        i32.const 0
        local.set 3
        loop ;; label = @2
          local.get 3
          global.get $GOT.data.internal.__memory_base
          i32.const 1053451
          i32.add
          local.get 2
          i32.add
          i32.load8_u
          i32.add
          local.tee 3
          local.get 0
          i32.gt_u
          br_if 1 (;@1;)
          local.get 4
          local.get 2
          i32.const 1
          i32.add
          local.tee 2
          i32.ne
          br_if 0 (;@2;)
        end
      end
      local.get 2
      i32.const 1
      i32.and
    )
    (func $_ZN4core7unicode9printable12is_printable17h3c90da7a17fb35b6E (;216;) (type 9) (param i32) (result i32)
      (local i32 i32 i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  local.get 0
                  i32.const 32
                  i32.lt_u
                  br_if 0 (;@6;)
                  block ;; label = @7
                    local.get 0
                    i32.const 127
                    i32.ge_u
                    br_if 0 (;@7;)
                    i32.const 1
                    local.set 1
                    br 6 (;@1;)
                  end
                  block ;; label = @7
                    block ;; label = @8
                      local.get 0
                      i32.const 65536
                      i32.lt_u
                      br_if 0 (;@8;)
                      local.get 0
                      i32.const 131072
                      i32.lt_u
                      br_if 1 (;@7;)
                      local.get 0
                      i32.const 2097120
                      i32.and
                      i32.const 173792
                      i32.ne
                      local.get 0
                      i32.const 2097150
                      i32.and
                      i32.const 178206
                      i32.ne
                      i32.and
                      local.get 0
                      i32.const -177984
                      i32.add
                      i32.const -6
                      i32.lt_u
                      i32.and
                      local.get 0
                      i32.const -183984
                      i32.add
                      i32.const -14
                      i32.lt_u
                      i32.and
                      local.get 0
                      i32.const -191472
                      i32.add
                      i32.const -15
                      i32.lt_u
                      i32.and
                      local.get 0
                      i32.const -194560
                      i32.add
                      i32.const -2466
                      i32.lt_u
                      i32.and
                      local.get 0
                      i32.const -196608
                      i32.add
                      i32.const -1506
                      i32.lt_u
                      i32.and
                      local.get 0
                      i32.const -201552
                      i32.add
                      i32.const -5
                      i32.lt_u
                      i32.and
                      local.get 0
                      i32.const -917760
                      i32.add
                      i32.const -712016
                      i32.lt_u
                      i32.and
                      local.get 0
                      i32.const 918000
                      i32.lt_u
                      i32.and
                      local.set 1
                      br 7 (;@1;)
                    end
                    i32.const 0
                    local.set 2
                    local.get 0
                    i32.const 8
                    i32.shr_u
                    i32.const 255
                    i32.and
                    local.set 3
                    i32.const 0
                    local.set 4
                    loop ;; label = @8
                      global.get $GOT.data.internal.__memory_base
                      i32.const 1055922
                      i32.add
                      local.get 4
                      i32.add
                      local.set 5
                      local.get 4
                      i32.const 2
                      i32.add
                      local.set 4
                      local.get 2
                      local.get 5
                      i32.load8_u offset=1
                      local.tee 1
                      i32.add
                      local.set 6
                      block ;; label = @9
                        local.get 5
                        i32.load8_u
                        local.tee 5
                        local.get 3
                        i32.eq
                        br_if 0 (;@9;)
                        local.get 5
                        local.get 3
                        i32.gt_u
                        br_if 7 (;@2;)
                        local.get 6
                        local.set 2
                        local.get 4
                        i32.const 80
                        i32.ne
                        br_if 1 (;@8;)
                        br 7 (;@2;)
                      end
                      local.get 6
                      local.get 2
                      i32.lt_u
                      br_if 5 (;@3;)
                      local.get 6
                      i32.const 290
                      i32.gt_u
                      br_if 5 (;@3;)
                      global.get $GOT.data.internal.__memory_base
                      i32.const 1056002
                      i32.add
                      local.get 2
                      i32.add
                      local.set 2
                      loop ;; label = @9
                        block ;; label = @10
                          local.get 1
                          br_if 0 (;@10;)
                          local.get 6
                          local.set 2
                          local.get 4
                          i32.const 80
                          i32.ne
                          br_if 2 (;@8;)
                          br 8 (;@2;)
                        end
                        local.get 1
                        i32.const -1
                        i32.add
                        local.set 1
                        local.get 2
                        i32.load8_u
                        local.set 5
                        local.get 2
                        i32.const 1
                        i32.add
                        local.set 2
                        local.get 5
                        local.get 0
                        i32.const 255
                        i32.and
                        i32.ne
                        br_if 0 (;@9;)
                        br 3 (;@6;)
                      end
                    end
                  end
                  i32.const 0
                  local.set 2
                  local.get 0
                  i32.const 8
                  i32.shr_u
                  i32.const 255
                  i32.and
                  local.set 3
                  i32.const 0
                  local.set 4
                  loop ;; label = @7
                    global.get $GOT.data.internal.__memory_base
                    i32.const 1055140
                    i32.add
                    local.get 4
                    i32.add
                    local.set 5
                    local.get 4
                    i32.const 2
                    i32.add
                    local.set 4
                    local.get 2
                    local.get 5
                    i32.load8_u offset=1
                    local.tee 1
                    i32.add
                    local.set 6
                    block ;; label = @8
                      local.get 5
                      i32.load8_u
                      local.tee 5
                      local.get 3
                      i32.eq
                      br_if 0 (;@8;)
                      local.get 5
                      local.get 3
                      i32.gt_u
                      br_if 4 (;@4;)
                      local.get 6
                      local.set 2
                      local.get 4
                      i32.const 88
                      i32.ne
                      br_if 1 (;@7;)
                      br 4 (;@4;)
                    end
                    local.get 6
                    local.get 2
                    i32.lt_u
                    br_if 2 (;@5;)
                    local.get 6
                    i32.const 208
                    i32.gt_u
                    br_if 2 (;@5;)
                    global.get $GOT.data.internal.__memory_base
                    i32.const 1055228
                    i32.add
                    local.get 2
                    i32.add
                    local.set 2
                    loop ;; label = @8
                      block ;; label = @9
                        local.get 1
                        br_if 0 (;@9;)
                        local.get 6
                        local.set 2
                        local.get 4
                        i32.const 88
                        i32.ne
                        br_if 2 (;@7;)
                        br 5 (;@4;)
                      end
                      local.get 1
                      i32.const -1
                      i32.add
                      local.set 1
                      local.get 2
                      i32.load8_u
                      local.set 5
                      local.get 2
                      i32.const 1
                      i32.add
                      local.set 2
                      local.get 5
                      local.get 0
                      i32.const 255
                      i32.and
                      i32.ne
                      br_if 0 (;@8;)
                    end
                  end
                end
                i32.const 0
                local.set 1
                br 4 (;@1;)
              end
              local.get 2
              local.get 6
              i32.const 208
              global.get $GOT.data.internal.__memory_base
              i32.const 1058540
              i32.add
              call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
              unreachable
            end
            local.get 0
            i32.const 65535
            i32.and
            local.set 5
            i32.const 1
            local.set 1
            i32.const 0
            local.set 2
            loop ;; label = @4
              local.get 2
              i32.const 1
              i32.add
              local.set 4
              block ;; label = @5
                block ;; label = @6
                  global.get $GOT.data.internal.__memory_base
                  i32.const 1055436
                  i32.add
                  local.get 2
                  i32.add
                  i32.load8_s
                  local.tee 0
                  i32.const 0
                  i32.lt_s
                  br_if 0 (;@6;)
                  local.get 4
                  local.set 2
                  br 1 (;@5;)
                end
                block ;; label = @6
                  local.get 4
                  i32.const 486
                  i32.eq
                  br_if 0 (;@6;)
                  local.get 0
                  i32.const 127
                  i32.and
                  i32.const 8
                  i32.shl
                  global.get $GOT.data.internal.__memory_base
                  i32.const 1055436
                  i32.add
                  local.get 2
                  i32.add
                  i32.const 1
                  i32.add
                  i32.load8_u
                  i32.or
                  local.set 0
                  local.get 2
                  i32.const 2
                  i32.add
                  local.set 2
                  br 1 (;@5;)
                end
                global.get $GOT.data.internal.__memory_base
                i32.const 1058524
                i32.add
                call $_ZN4core6option13unwrap_failed17h37f20c15ca5e53d0E
                unreachable
              end
              local.get 5
              local.get 0
              i32.sub
              local.tee 5
              i32.const 0
              i32.lt_s
              br_if 3 (;@1;)
              local.get 1
              i32.const 1
              i32.xor
              local.set 1
              local.get 2
              i32.const 486
              i32.ne
              br_if 0 (;@4;)
              br 3 (;@1;)
            end
          end
          local.get 2
          local.get 6
          i32.const 290
          global.get $GOT.data.internal.__memory_base
          i32.const 1058540
          i32.add
          call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
          unreachable
        end
        i32.const 1
        local.set 1
        i32.const 0
        local.set 2
        loop ;; label = @2
          local.get 2
          i32.const 1
          i32.add
          local.set 4
          block ;; label = @3
            block ;; label = @4
              global.get $GOT.data.internal.__memory_base
              i32.const 1056292
              i32.add
              local.get 2
              i32.add
              i32.load8_s
              local.tee 5
              i32.const 0
              i32.lt_s
              br_if 0 (;@4;)
              local.get 4
              local.set 2
              br 1 (;@3;)
            end
            block ;; label = @4
              local.get 4
              i32.const 297
              i32.eq
              br_if 0 (;@4;)
              local.get 5
              i32.const 127
              i32.and
              i32.const 8
              i32.shl
              global.get $GOT.data.internal.__memory_base
              i32.const 1056292
              i32.add
              local.get 2
              i32.add
              i32.const 1
              i32.add
              i32.load8_u
              i32.or
              local.set 5
              local.get 2
              i32.const 2
              i32.add
              local.set 2
              br 1 (;@3;)
            end
            global.get $GOT.data.internal.__memory_base
            i32.const 1058524
            i32.add
            call $_ZN4core6option13unwrap_failed17h37f20c15ca5e53d0E
            unreachable
          end
          local.get 0
          local.get 5
          i32.sub
          local.tee 0
          i32.const 0
          i32.lt_s
          br_if 1 (;@1;)
          local.get 1
          i32.const 1
          i32.xor
          local.set 1
          local.get 2
          i32.const 297
          i32.ne
          br_if 0 (;@2;)
        end
      end
      local.get 1
      i32.const 1
      i32.and
    )
    (func $_ZN4core5slice5index16slice_index_fail8do_panic7runtime17h35ce0ffc3e1b3088E (;217;) (type 3) (param i32 i32 i32)
      (local i32 i64)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      i32.store offset=4
      local.get 3
      local.get 0
      i32.store
      local.get 3
      i32.const 2
      i32.store offset=12
      local.get 3
      global.get $GOT.data.internal.__memory_base
      i32.const 1058444
      i32.add
      i32.store offset=8
      local.get 3
      i64.const 2
      i64.store offset=20 align=4
      local.get 3
      global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 4
      local.get 3
      i32.const 4
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=40
      local.get 3
      local.get 4
      local.get 3
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 3
      local.get 3
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 3
      i32.const 8
      i32.add
      local.get 2
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN4core5slice5index16slice_index_fail8do_panic7runtime17h78ec4bf3f51595ceE (;218;) (type 3) (param i32 i32 i32)
      (local i32 i64)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      i32.store offset=4
      local.get 3
      local.get 0
      i32.store
      local.get 3
      i32.const 2
      i32.store offset=12
      local.get 3
      global.get $GOT.data.internal.__memory_base
      i32.const 1058460
      i32.add
      i32.store offset=8
      local.get 3
      i64.const 2
      i64.store offset=20 align=4
      local.get 3
      global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 4
      local.get 3
      i32.const 4
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=40
      local.get 3
      local.get 4
      local.get 3
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 3
      local.get 3
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 3
      i32.const 8
      i32.add
      local.get 2
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN4core5slice5index16slice_index_fail8do_panic7runtime17h0134f2f4033eb1cbE (;219;) (type 3) (param i32 i32 i32)
      (local i32 i64)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      i32.store offset=4
      local.get 3
      local.get 0
      i32.store
      local.get 3
      i32.const 2
      i32.store offset=12
      local.get 3
      global.get $GOT.data.internal.__memory_base
      i32.const 1058428
      i32.add
      i32.store offset=8
      local.get 3
      i64.const 2
      i64.store offset=20 align=4
      local.get 3
      global.get $GOT.func.internal._ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h27bb88f85232b27dE
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 4
      local.get 3
      i32.const 4
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=40
      local.get 3
      local.get 4
      local.get 3
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 3
      local.get 3
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 3
      i32.const 8
      i32.add
      local.get 2
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN4core5slice6memchr14memchr_aligned17h53cfbfbcd60d9e5aE (;220;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32 i32)
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 2
              i32.const 3
              i32.add
              i32.const -4
              i32.and
              local.tee 4
              local.get 2
              i32.ne
              br_if 0 (;@4;)
              local.get 3
              i32.const -8
              i32.add
              local.set 5
              i32.const 0
              local.set 4
              br 1 (;@3;)
            end
            local.get 3
            local.get 4
            local.get 2
            i32.sub
            local.tee 4
            local.get 3
            local.get 4
            i32.lt_u
            select
            local.set 4
            block ;; label = @4
              local.get 3
              i32.eqz
              br_if 0 (;@4;)
              i32.const 0
              local.set 6
              local.get 1
              i32.const 255
              i32.and
              local.set 7
              i32.const 1
              local.set 8
              loop ;; label = @5
                local.get 2
                local.get 6
                i32.add
                i32.load8_u
                local.get 7
                i32.eq
                br_if 4 (;@1;)
                local.get 4
                local.get 6
                i32.const 1
                i32.add
                local.tee 6
                i32.ne
                br_if 0 (;@5;)
              end
            end
            local.get 4
            local.get 3
            i32.const -8
            i32.add
            local.tee 5
            i32.gt_u
            br_if 1 (;@2;)
          end
          local.get 1
          i32.const 255
          i32.and
          i32.const 16843009
          i32.mul
          local.set 6
          loop ;; label = @3
            i32.const 16843008
            local.get 2
            local.get 4
            i32.add
            local.tee 7
            i32.load
            local.get 6
            i32.xor
            local.tee 8
            i32.sub
            local.get 8
            i32.or
            i32.const 16843008
            local.get 7
            i32.const 4
            i32.add
            i32.load
            local.get 6
            i32.xor
            local.tee 7
            i32.sub
            local.get 7
            i32.or
            i32.and
            i32.const -2139062144
            i32.and
            i32.const -2139062144
            i32.ne
            br_if 1 (;@2;)
            local.get 4
            i32.const 8
            i32.add
            local.tee 4
            local.get 5
            i32.le_u
            br_if 0 (;@3;)
          end
        end
        block ;; label = @2
          local.get 3
          local.get 4
          i32.eq
          br_if 0 (;@2;)
          local.get 1
          i32.const 255
          i32.and
          local.set 6
          i32.const 1
          local.set 8
          loop ;; label = @3
            block ;; label = @4
              local.get 2
              local.get 4
              i32.add
              i32.load8_u
              local.get 6
              i32.ne
              br_if 0 (;@4;)
              local.get 4
              local.set 6
              br 3 (;@1;)
            end
            local.get 3
            local.get 4
            i32.const 1
            i32.add
            local.tee 4
            i32.ne
            br_if 0 (;@3;)
          end
        end
        i32.const 0
        local.set 8
      end
      local.get 0
      local.get 6
      i32.store offset=4
      local.get 0
      local.get 8
      i32.store
    )
    (func $_ZN4core5slice6memchr7memrchr17hdc45ebff6cde5bbdE (;221;) (type 5) (param i32 i32 i32 i32)
      (local i32 i32 i32 i32 i32 i32)
      local.get 3
      i32.const 0
      local.get 3
      local.get 2
      i32.const 3
      i32.add
      i32.const -4
      i32.and
      local.get 2
      i32.sub
      local.tee 4
      i32.sub
      i32.const 7
      i32.and
      local.get 3
      local.get 4
      i32.lt_u
      select
      local.tee 5
      i32.sub
      local.set 6
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              local.get 3
              local.get 5
              i32.lt_u
              br_if 0 (;@4;)
              block ;; label = @5
                local.get 5
                i32.eqz
                br_if 0 (;@5;)
                block ;; label = @6
                  block ;; label = @7
                    local.get 2
                    local.get 3
                    i32.add
                    local.tee 7
                    i32.const -1
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.get 1
                    i32.const 255
                    i32.and
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const -1
                    i32.add
                    local.set 5
                    br 1 (;@6;)
                  end
                  local.get 2
                  local.get 6
                  i32.add
                  local.tee 9
                  local.get 8
                  i32.eq
                  br_if 1 (;@5;)
                  block ;; label = @7
                    local.get 7
                    i32.const -2
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.get 1
                    i32.const 255
                    i32.and
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const -2
                    i32.add
                    local.set 5
                    br 1 (;@6;)
                  end
                  local.get 9
                  local.get 8
                  i32.eq
                  br_if 1 (;@5;)
                  block ;; label = @7
                    local.get 7
                    i32.const -3
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.get 1
                    i32.const 255
                    i32.and
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const -3
                    i32.add
                    local.set 5
                    br 1 (;@6;)
                  end
                  local.get 9
                  local.get 8
                  i32.eq
                  br_if 1 (;@5;)
                  block ;; label = @7
                    local.get 7
                    i32.const -4
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.get 1
                    i32.const 255
                    i32.and
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const -4
                    i32.add
                    local.set 5
                    br 1 (;@6;)
                  end
                  local.get 9
                  local.get 8
                  i32.eq
                  br_if 1 (;@5;)
                  block ;; label = @7
                    local.get 7
                    i32.const -5
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.get 1
                    i32.const 255
                    i32.and
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const -5
                    i32.add
                    local.set 5
                    br 1 (;@6;)
                  end
                  local.get 9
                  local.get 8
                  i32.eq
                  br_if 1 (;@5;)
                  block ;; label = @7
                    local.get 7
                    i32.const -6
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.get 1
                    i32.const 255
                    i32.and
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const -6
                    i32.add
                    local.set 5
                    br 1 (;@6;)
                  end
                  local.get 9
                  local.get 8
                  i32.eq
                  br_if 1 (;@5;)
                  block ;; label = @7
                    local.get 7
                    i32.const -7
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.get 1
                    i32.const 255
                    i32.and
                    i32.ne
                    br_if 0 (;@7;)
                    local.get 5
                    i32.const -7
                    i32.add
                    local.set 5
                    br 1 (;@6;)
                  end
                  local.get 9
                  local.get 8
                  i32.eq
                  br_if 1 (;@5;)
                  local.get 5
                  i32.const -8
                  i32.or
                  local.set 5
                end
                local.get 5
                local.get 6
                i32.add
                local.set 5
                br 3 (;@2;)
              end
              local.get 4
              local.get 3
              local.get 3
              local.get 4
              i32.gt_u
              select
              local.set 9
              local.get 1
              i32.const 255
              i32.and
              i32.const 16843009
              i32.mul
              local.set 4
              block ;; label = @5
                loop ;; label = @6
                  local.get 6
                  local.tee 5
                  local.get 9
                  i32.le_u
                  br_if 1 (;@5;)
                  local.get 5
                  i32.const -8
                  i32.add
                  local.set 6
                  i32.const 16843008
                  local.get 2
                  local.get 5
                  i32.add
                  local.tee 8
                  i32.const -8
                  i32.add
                  i32.load
                  local.get 4
                  i32.xor
                  local.tee 7
                  i32.sub
                  local.get 7
                  i32.or
                  i32.const 16843008
                  local.get 8
                  i32.const -4
                  i32.add
                  i32.load
                  local.get 4
                  i32.xor
                  local.tee 8
                  i32.sub
                  local.get 8
                  i32.or
                  i32.and
                  i32.const -2139062144
                  i32.and
                  i32.const -2139062144
                  i32.eq
                  br_if 0 (;@6;)
                end
              end
              local.get 5
              local.get 3
              i32.gt_u
              br_if 1 (;@3;)
              local.get 2
              i32.const -1
              i32.add
              local.set 4
              local.get 1
              i32.const 255
              i32.and
              local.set 8
              loop ;; label = @5
                block ;; label = @6
                  local.get 5
                  br_if 0 (;@6;)
                  i32.const 0
                  local.set 6
                  br 5 (;@1;)
                end
                local.get 4
                local.get 5
                i32.add
                local.set 6
                local.get 5
                i32.const -1
                i32.add
                local.set 5
                local.get 6
                i32.load8_u
                local.get 8
                i32.eq
                br_if 3 (;@2;)
                br 0 (;@5;)
              end
            end
            local.get 6
            local.get 3
            local.get 3
            global.get $GOT.data.internal.__memory_base
            i32.const 1058476
            i32.add
            call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
            unreachable
          end
          i32.const 0
          local.get 5
          local.get 3
          global.get $GOT.data.internal.__memory_base
          i32.const 1058492
          i32.add
          call $_ZN4core5slice5index16slice_index_fail17hbefd99047f3f47b8E
          unreachable
        end
        i32.const 1
        local.set 6
      end
      local.get 0
      local.get 5
      i32.store offset=4
      local.get 0
      local.get 6
      i32.store
    )
    (func $_ZN4core6option13expect_failed17had8d4ff3f7f9fec5E (;222;) (type 3) (param i32 i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      local.get 3
      local.get 1
      i32.store offset=12
      local.get 3
      local.get 0
      i32.store offset=8
      local.get 3
      i32.const 1
      i32.store offset=20
      local.get 3
      global.get $GOT.data.internal.__memory_base
      i32.const 1054848
      i32.add
      i32.store offset=16
      local.get 3
      i64.const 1
      i64.store offset=28 align=4
      local.get 3
      global.get $GOT.data.internal.__table_base
      i32.const 70
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 3
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=40
      local.get 3
      local.get 3
      i32.const 40
      i32.add
      i32.store offset=24
      local.get 3
      i32.const 16
      i32.add
      local.get 2
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN4core6result13unwrap_failed17h448fe3da622852aeE (;223;) (type 10) (param i32 i32 i32 i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 64
      i32.sub
      local.tee 5
      global.set $__stack_pointer
      local.get 5
      local.get 1
      i32.store offset=12
      local.get 5
      local.get 0
      i32.store offset=8
      local.get 5
      local.get 3
      i32.store offset=20
      local.get 5
      local.get 2
      i32.store offset=16
      local.get 5
      i32.const 2
      i32.store offset=28
      local.get 5
      global.get $GOT.data.internal.__memory_base
      i32.const 1058508
      i32.add
      i32.store offset=24
      local.get 5
      i64.const 2
      i64.store offset=36 align=4
      local.get 5
      global.get $GOT.data.internal.__table_base
      local.tee 1
      i32.const 74
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 5
      i32.const 16
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=56
      local.get 5
      local.get 1
      i32.const 70
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 5
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=48
      local.get 5
      local.get 5
      i32.const 48
      i32.add
      i32.store offset=32
      local.get 5
      i32.const 24
      i32.add
      local.get 4
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN4core9panicking19assert_failed_inner17h948b46d16a47337bE (;224;) (type 14) (param i32 i32 i32 i32 i32 i32 i32)
      (local i32 i64)
      global.get $__stack_pointer
      i32.const 112
      i32.sub
      local.tee 7
      global.set $__stack_pointer
      local.get 7
      local.get 2
      i32.store offset=12
      local.get 7
      local.get 1
      i32.store offset=8
      local.get 7
      local.get 4
      i32.store offset=20
      local.get 7
      local.get 3
      i32.store offset=16
      local.get 7
      global.get $GOT.data.internal.__memory_base
      local.tee 2
      i32.const 1056704
      i32.add
      local.get 0
      i32.const 255
      i32.and
      i32.const 2
      i32.shl
      local.tee 1
      i32.add
      i32.load
      i32.store offset=28
      local.get 7
      local.get 2
      i32.const 1058612
      i32.add
      local.get 1
      i32.add
      i32.load
      i32.store offset=24
      block ;; label = @1
        local.get 5
        i32.load
        i32.eqz
        br_if 0 (;@1;)
        local.get 7
        i32.const 32
        i32.add
        i32.const 16
        i32.add
        local.get 5
        i32.const 16
        i32.add
        i64.load align=4
        i64.store
        local.get 7
        i32.const 32
        i32.add
        i32.const 8
        i32.add
        local.get 5
        i32.const 8
        i32.add
        i64.load align=4
        i64.store
        local.get 7
        local.get 5
        i64.load align=4
        i64.store offset=32
        local.get 7
        i32.const 4
        i32.store offset=92
        local.get 7
        global.get $GOT.data.internal.__memory_base
        i32.const 1058580
        i32.add
        i32.store offset=88
        local.get 7
        i64.const 4
        i64.store offset=100 align=4
        local.get 7
        global.get $GOT.data.internal.__table_base
        local.tee 5
        i32.const 74
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.tee 8
        local.get 7
        i32.const 16
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=80
        local.get 7
        local.get 8
        local.get 7
        i32.const 8
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=72
        local.get 7
        global.get $GOT.func.internal._ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h41e4e0481f0d43d7E
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 7
        i32.const 32
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=64
        local.get 7
        local.get 5
        i32.const 70
        i32.add
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 7
        i32.const 24
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=56
        local.get 7
        local.get 7
        i32.const 56
        i32.add
        i32.store offset=96
        local.get 7
        i32.const 88
        i32.add
        local.get 6
        call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
        unreachable
      end
      local.get 7
      i32.const 3
      i32.store offset=92
      local.get 7
      i64.const 3
      i64.store offset=100 align=4
      local.get 7
      global.get $GOT.data.internal.__memory_base
      i32.const 1058556
      i32.add
      i32.store offset=88
      local.get 7
      global.get $GOT.data.internal.__table_base
      local.tee 5
      i32.const 74
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 8
      local.get 7
      i32.const 16
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=72
      local.get 7
      local.get 8
      local.get 7
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=64
      local.get 7
      local.get 5
      i32.const 70
      i32.add
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 7
      i32.const 24
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=56
      local.get 7
      local.get 7
      i32.const 56
      i32.add
      i32.store offset=96
      local.get 7
      i32.const 88
      i32.add
      local.get 6
      call $_ZN4core9panicking9panic_fmt17he4af7122229aee01E
      unreachable
    )
    (func $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h41e4e0481f0d43d7E (;225;) (type 2) (param i32 i32) (result i32)
      local.get 1
      i32.load
      local.get 1
      i32.load offset=4
      local.get 0
      call $_ZN4core3fmt5write17h2e7b0d99429abb3bE
    )
    (func $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17hf383df329ca2be04E (;226;) (type 2) (param i32 i32) (result i32)
      (local i32 i32)
      local.get 0
      i32.load offset=4
      local.set 2
      local.get 0
      i32.load
      local.set 3
      block ;; label = @1
        local.get 0
        i32.load offset=8
        local.tee 0
        i32.load8_u
        i32.eqz
        br_if 0 (;@1;)
        local.get 3
        global.get $GOT.data.internal.__memory_base
        i32.const 1056699
        i32.add
        i32.const 4
        local.get 2
        i32.load offset=12
        call_indirect (type 4)
        i32.eqz
        br_if 0 (;@1;)
        i32.const 1
        return
      end
      local.get 0
      local.get 1
      i32.const 10
      i32.eq
      i32.store8
      local.get 3
      local.get 1
      local.get 2
      i32.load offset=16
      call_indirect (type 2)
    )
    (data $.rodata (;0;) (i32.const 1048576) "0123456789abcdeflibrary/std/src/sys/pal/wasip2/../wasip1/os.rs\00library/std/src/sys/sync/mutex/no_threads.rs\00library/alloc/src/ffi/c_str.rs\00library/core/src/slice/memchr.rs\00library/std/src/io/buffered/bufwriter.rs\00library/std/src/io/stdio.rs\00library/std/src/io/buffered/linewritershim.rs\00library/std/src/sync/reentrant_lock.rs\00library/std/src/sys/io/io_slice/wasi.rs\00library/std/src/panicking.rs\00library/core/src/unicode/printable.rs\00library/std/src/sync/poison/once.rs\00/rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/alloc/src/slice.rs\00library/core/src/fmt/mod.rs\00library/std/src/io/mod.rs\00library/std/src/thread/mod.rs\00/home/sergiyivan/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/alloc/src/raw_vec/mod.rs\00/rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/alloc/src/raw_vec/mod.rs\00/rustc/ed61e7d7e242494fb7057f2657300d9e77bb4fcb/library/alloc/src/vec/mod.rs\00library/std/src/alloc.rs\00src/lib.rs\00/\00Array before:   \0aArray after:    fatal runtime error: failed to initiate panic, error , aborting\0a\00\99-\e2\cb\db\18|E\baa\d2K\9aNX\b2m]\cb\d6,P\ebcxA\a6Wq\1b\8b\b9\01\00\00\00\00\00\00\00:\0a: a formatting trait implementation returned an error when the underlying stream did notfailed to write whole bufferentity not foundpermission deniedconnection refusedconnection resethost unreachablenetwork unreachableconnection abortednot connectedaddress in useaddress not availablenetwork downbroken pipeentity already existsoperation would blocknot a directoryis a directorydirectory not emptyread-only filesystem or storage mediumfilesystem loop or indirection limit (e.g. symlink loop)stale network file handleinvalid input parameterinvalid datatimed outwrite zerono storage spaceseek on unseekable filequota exceededfile too largeresource busyexecutable file busydeadlockcross-device link or renametoo many linksinvalid filenameargument list too longoperation interruptedunsupportedunexpected end of fileout of memoryin progressother erroruncategorized errormid > lenstdoutfailed printing to advancing io slices beyond their lengthadvancing IoSlice beyond its lengthfailed to write the buffered datacalled `Result::unwrap()` on an `Err` valuefile name contained an unexpected NUL bytestrerror_r failureone-time initialization may not be performed recursivelyfatal runtime error: rwlock locked for writing, aborting\0astack backtrace:\0anote: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.\0acannot recursively acquire mutexlock count overflow in reentrant mutex\00memory allocation of  bytes failed\0a bytes failedRUST_BACKTRACEmainfailed to generate unique thread ID: bitspace exhaustednote: run with `RUST_BACKTRACE=1` environment variable to display a backtrace\0a<unnamed>\0athread '' () panicked at :\0aBox<dyn Any>aborting due to panic at panicked at \0athread panicked while processing panic. aborting.\0athread caused non-unwinding panic. aborting.\0adescription() is deprecated; use Display\00\00\00 \ea\df{\d8\b7\8c\e1\22\89\0a\cf)\b2:\12 (os error )Utf8Errorvalid_up_toerror_lenNoneSome\00\00\00\10\00\00\00\11\00\00\00\12\00\00\00\10\00\00\00\10\00\00\00\13\00\00\00\12\00\00\00\0d\00\00\00\0e\00\00\00\15\00\00\00\0c\00\00\00\0b\00\00\00\15\00\00\00\15\00\00\00\0f\00\00\00\0e\00\00\00\13\00\00\00&\00\00\008\00\00\00\19\00\00\00\17\00\00\00\0c\00\00\00\09\00\00\00\0a\00\00\00\10\00\00\00\17\00\00\00\0e\00\00\00\0e\00\00\00\0d\00\00\00\14\00\00\00\08\00\00\00\1b\00\00\00\0e\00\00\00\10\00\00\00\16\00\00\00\15\00\00\00\0b\00\00\00\16\00\00\00\0d\00\00\00\0b\00\00\00\0b\00\00\00\13\00\00\00Success\00Illegal byte sequence\00Domain error\00Result not representable\00Not a tty\00Permission denied\00Operation not permitted\00No such file or directory\00No such process\00File exists\00Value too large for data type\00No space left on device\00Out of memory\00Resource busy\00Interrupted system call\00Resource temporarily unavailable\00Invalid seek\00Cross-device link\00Read-only file system\00Directory not empty\00Connection reset by peer\00Operation timed out\00Connection refused\00Host is unreachable\00Address in use\00Broken pipe\00I/O error\00No such device or address\00No such device\00Not a directory\00Is a directory\00Text file busy\00Exec format error\00Invalid argument\00Argument list too long\00Symbolic link loop\00Filename too long\00Too many open files in system\00No file descriptors available\00Bad file descriptor\00No child process\00Bad address\00File too large\00Too many links\00No locks available\00Resource deadlock would occur\00State not recoverable\00Previous owner died\00Operation canceled\00Function not implemented\00No message of desired type\00Identifier removed\00Link has been severed\00Protocol error\00Bad message\00Not a socket\00Destination address required\00Message too large\00Protocol wrong type for socket\00Protocol not available\00Protocol not supported\00Not supported\00Address family not supported by protocol\00Address not available\00Network is down\00Network unreachable\00Connection reset by network\00Connection aborted\00No buffer space available\00Socket is connected\00Socket not connected\00Operation already in progress\00Operation in progress\00Stale file handle\00Quota exceeded\00Multihop attempted\00Capabilities insufficient\00\00\00\00\00\00\00\00\00\00\00u\02N\00\d6\01\e2\04\b9\04\18\01\8e\05\ed\02\16\04\f2\00\97\03\01\038\05\af\01\82\01O\03/\04\1e\00\d4\05\a2\00\12\03\1e\03\c2\01\de\03\08\00\ac\05\00\01d\02\f1\01e\054\02\8c\02\cf\02-\03L\04\e3\05\9f\02\f8\04\1c\05\08\05\b1\02K\05\15\02x\00R\02<\03\f1\03\e4\00\c3\03}\04\cc\00\aa\03y\05$\02n\01m\03\22\04\ab\04D\00\fb\01\ae\00\83\03`\00\e5\01\07\04\94\04^\04+\00X\019\01\92\00\c2\05\9b\01C\02F\01\f6\05capacity overflow\00p\00\07\00-\01\01\01\02\01\02\01\01H\0b0\15\10\01e\07\02\06\02\02\01\04#\01\1e\1b[\0b:\09\09\01\18\04\01\09\01\03\01\05+\03;\09*\18\01 7\01\01\01\04\08\04\01\03\07\0a\02\1d\01:\01\01\01\02\04\08\01\09\01\0a\02\1a\01\02\029\01\04\02\04\02\02\03\03\01\1e\02\03\01\0b\029\01\04\05\01\02\04\01\14\02\16\06\01\01:\01\01\02\01\04\08\01\07\03\0a\02\1e\01;\01\01\01\0c\01\09\01(\01\03\017\01\01\03\05\03\01\04\07\02\0b\02\1d\01:\01\02\02\01\01\03\03\01\04\07\02\0b\02\1c\029\02\01\01\02\04\08\01\09\01\0a\02\1d\01H\01\04\01\02\03\01\01\08\01Q\01\02\07\0c\08b\01\02\09\0b\07I\02\1b\01\01\01\01\017\0e\01\05\01\02\05\0b\01$\09\01f\04\01\06\01\02\02\02\19\02\04\03\10\04\0d\01\02\02\06\01\0f\01\00\03\00\04\1c\03\1d\02\1e\02@\02\01\07\08\01\02\0b\09\01-\03\01\01u\02\22\01v\03\04\02\09\01\06\03\db\02\02\01:\01\01\07\01\01\01\01\02\08\06\0a\02\010\1f1\040\0a\04\03&\09\0c\02 \04\02\068\01\01\02\03\01\01\058\08\02\02\98\03\01\0d\01\07\04\01\06\01\03\02\c6@\00\01\c3!\00\03\8d\01` \00\06i\02\00\04\01\0a \02P\02\00\01\03\01\04\01\19\02\05\01\97\02\1a\12\0d\01&\08\19\0b\01\01,\030\01\02\04\02\02\02\01$\01C\06\02\02\02\02\0c\01\08\01/\013\01\01\03\02\02\05\02\01\01*\02\08\01\ee\01\02\01\04\01\00\01\00\10\10\10\00\02\00\01\e2\01\95\05\00\03\01\02\05\04(\03\04\01\a5\02\00\04A\05\00\02O\04F\0b1\04{\016\0f)\01\02\02\0a\031\04\02\02\07\01=\03$\05\01\08>\01\0c\024\09\01\01\08\04\02\01_\03\02\04\06\01\02\01\9d\01\03\08\15\029\02\01\01\01\01\0c\01\09\01\0e\07\03\05C\01\02\06\01\01\02\01\01\03\04\03\01\01\0e\02U\08\02\03\01\01\17\01Q\01\02\06\01\01\02\01\01\02\01\02\eb\01\02\04\06\02\01\02\1b\02U\08\02\01\01\02j\01\01\01\02\08e\01\01\01\02\04\01\05\00\09\01\02\f5\01\0a\04\04\01\90\04\02\02\04\01 \0a(\06\02\04\08\01\09\06\02\03.\0d\01\02\00\07\01\06\01\01R\16\02\07\01\02\01\02z\06\03\01\01\02\01\07\01\01H\02\03\01\01\01\00\02\0b\024\05\05\03\17\01\00\01\06\0f\00\0c\03\03\00\05;\07\00\01?\04Q\01\0b\02\00\02\00.\02\17\00\05\03\06\08\08\02\07\1e\04\94\03\007\042\08\01\0e\01\16\05\01\0f\00\07\01\11\02\07\01\02\01\05d\01\a0\07\00\01=\04\00\04\fe\02\00\07m\07\00`\80\f0\00falsetrue000102030405060708091011121314151617181920212223242526272829303132333435363738394041424344454647484950515253545556575859606162636465666768697071727374757677787980818283848586878889909192939495969798990123456789abcdef0x0123456789ABCDEF, ,\0a((\0a), { :  {\0a} }\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\04\04\04\04\04\00\00\00\00\00\00\00\00\00\00\00[...]begin <= end ( <= ) when slicing ``byte index  is not a char boundary; it is inside  (bytes ) of ` is out of bounds of `\00\00\01\00\00\00\00\00\00\00range end index  out of range for slice of length slice index starts at  but ends at range start index called `Option::unwrap()` on a `None` value\00\00\00\03\00\00\83\04 \00\91\05`\00]\13\a0\00\12\17 \1f\0c `\1f\ef, +*0\a0+o\a6`,\02\a8\e0,\1e\fb\e0-\00\fe 6\9e\ff`6\fd\01\e16\01\0a!7$\0d\e17\ab\0ea9/\18\e190\1c\e1J\f3\1e\e1N@4\a1R\1ea\e1S\f0jaTOo\e1T\9d\bcaU\00\cfaVe\d1\a1V\00\da!W\00\e0\a1X\ae\e2!Z\ec\e4\e1[\d0\e8a\5c \00\ee\5c\f0\01\7f]\00\06\01\01\03\01\04\02\05\07\07\02\08\08\09\02\0a\05\0b\02\0e\04\10\01\11\02\12\05\13\1c\14\01\15\02\17\02\19\0d\1c\05\1d\08\1f\01$\01j\04k\02\af\03\b1\02\bc\02\cf\02\d1\02\d4\0c\d5\09\d6\02\d7\02\da\01\e0\05\e1\02\e7\04\e8\02\ee \f0\04\f8\02\fa\04\fb\01\0c';>NO\8f\9e\9e\9f{\8b\93\96\a2\b2\ba\86\b1\06\07\096=>V\f3\d0\d1\04\14\1867VW\7f\aa\ae\af\bd5\e0\12\87\89\8e\9e\04\0d\0e\11\12)14:EFIJNOde\8a\8c\8d\8f\b6\c1\c3\c4\c6\cb\d6\5c\b6\b7\1b\1c\07\08\0a\0b\14\1769:\a8\a9\d8\d9\097\90\91\a8\07\0a;>fi\8f\92\11o_\bf\ee\efZb\f4\fc\ffST\9a\9b./'(U\9d\a0\a1\a3\a4\a7\a8\ad\ba\bc\c4\06\0b\0c\15\1d:?EQ\a6\a7\cc\cd\a0\07\19\1a\22%>?\e7\ec\ef\ff\c5\c6\04 #%&(38:HJLPSUVXZ\5c^`cefksx}\7f\8a\a4\aa\af\b0\c0\d0\ae\afno\dd\de\93^\22{\05\03\04-\03f\03\01/.\80\82\1d\031\0f\1c\04$\09\1e\05+\05D\04\0e*\80\aa\06$\04$\04(\084\0bN\034\0c\817\09\16\0a\08\18;E9\03c\08\090\16\05!\03\1b\05\01@8\04K\05/\04\0a\07\09\07@ '\04\0c\096\03:\05\1a\07\04\0c\07PI73\0d3\07.\08\0a\06&\03\1d\08\02\80\d0R\10\037,\08*\16\1a&\1c\14\17\09N\04$\09D\0d\19\07\0a\06H\08'\09u\0bB>*\06;\05\0a\06Q\06\01\05\10\03\05\0bY\08\02\1db\1eH\08\0a\80\a6^\22E\0b\0a\06\0d\13:\06\0a\06\14\1c,\04\17\80\b9<dS\0cH\09\0aFE\1bH\08S\0dI\07\0a\80\b6\22\0e\0a\06F\0a\1d\03GI7\03\0e\08\0a\069\07\0a\816\19\07;\03\1dU\01\0f2\0d\83\9bfu\0b\80\c4\8aLc\0d\840\10\16\0a\8f\9b\05\82G\9a\b9:\86\c6\829\07*\04\5c\06&\0aF\0a(\05\13\81\b0:\80\c6[eK\049\07\11@\05\0b\02\0e\97\f8\08\84\d6)\0a\a2\e7\813\0f\01\1d\06\0e\04\08\81\8c\89\04k\05\0d\03\09\07\10\8f`\80\fa\06\81\b4LG\09t<\80\f6\0as\08p\15Fz\14\0c\14\0cW\09\19\80\87\81G\03\85B\0f\15\84P\1f\06\06\80\d5+\05>!\01p-\03\1a\04\02\81@\1f\11:\05\01\81\d0*\80\d6+\04\01\81\e0\80\f7)L\04\0a\04\02\83\11DL=\80\c2<\06\01\04U\05\1b4\02\81\0e,\04d\0cV\0a\80\ae8\1d\0d,\04\09\07\02\0e\06\80\9a\83\d8\04\11\03\0d\03w\04_\06\0c\04\01\0f\0c\048\08\0a\06(\08,\04\02>\81T\0c\1d\03\0a\058\07\1c\06\09\07\80\fa\84\06\00\01\03\05\05\06\06\02\07\06\08\07\09\11\0a\1c\0b\19\0c\1a\0d\10\0e\0c\0f\04\10\03\12\12\13\09\16\01\17\04\18\01\19\03\1a\07\1b\01\1c\02\1f\16 \03+\03-\0b.\010\041\022\01\a7\04\a9\02\aa\04\ab\08\fa\02\fb\05\fd\02\fe\03\ff\09\adxy\8b\8d\a20WX\8b\8c\90\1c\dd\0e\0fKL\fb\fc./?\5c]_\e2\84\8d\8e\91\92\a9\b1\ba\bb\c5\c6\c9\ca\de\e4\e5\ff\00\04\11\12)147:;=IJ]\84\8e\92\a9\b1\b4\ba\bb\c6\ca\ce\cf\e4\e5\00\04\0d\0e\11\12)14:;EFIJ^de\84\91\9b\9d\c9\ce\cf\0d\11):;EIW[\5c^_de\8d\91\a9\b4\ba\bb\c5\c9\df\e4\e5\f0\0d\11EIde\80\84\b2\bc\be\bf\d5\d7\f0\f1\83\85\8b\a4\a6\be\bf\c5\c7\cf\da\dbH\98\bd\cd\c6\ce\cfINOWY^_\89\8e\8f\b1\b6\b7\bf\c1\c6\c7\d7\11\16\17[\5c\f6\f7\fe\ff\80mq\de\df\0e\1fno\1c\1d_}~\ae\afM\bb\bc\16\17\1e\1fFGNOXZ\5c^~\7f\b5\c5\d4\d5\dc\f0\f1\f5rs\8ftu\96&./\a7\af\b7\bf\c7\cf\d7\df\9a\00@\97\980\8f\1f\ce\cf\d2\d4\ce\ffNOZ[\07\08\0f\10'/\ee\efno7=?BE\90\91Sgu\c8\c9\d0\d1\d8\d9\e7\fe\ff\00 _\22\82\df\04\82D\08\1b\04\06\11\81\ac\0e\80\ab\05\1f\08\81\1c\03\19\08\01\04/\044\04\07\03\01\07\06\07\11\0aP\0f\12\07U\07\03\04\1c\0a\09\03\08\03\07\03\02\03\03\03\0c\04\05\03\0b\06\01\0e\15\05N\07\1b\07W\07\02\06\17\0cP\04C\03-\03\01\04\11\06\0f\0c:\04\1d%_ m\04j%\80\c8\05\82\b0\03\1a\06\82\fd\03Y\07\16\09\18\09\14\0c\14\0cj\06\0a\06\1a\06Y\07+\05F\0a,\04\0c\04\01\031\0b,\04\1a\06\0b\03\80\ac\06\0a\06/1\80\f4\08<\03\0f\03>\058\08+\05\82\ff\11\18\08/\11-\03!\0f!\0f\80\8c\04\82\9a\16\0b\15\88\94\05/\05;\07\02\0e\18\09\80\be\22t\0c\80\d6\1a\81\10\05\80\e1\09\f2\9e\037\09\81\5c\14\80\b8\08\80\dd\15;\03\0a\068\08F\08\0c\06t\0b\1e\03Z\04Y\09\80\83\18\1c\0a\16\09L\04\80\8a\06\ab\a4\0c\17\041\a1\04\81\da&\07\0c\05\05\80\a6\10\81\f5\07\01 *\06L\04\80\8d\04\80\be\03\1b\03\0f\0d==!=matchesassertion `left  right` failed\0a  left: \0a right:  right` failed: \0a  left: ..RefCell already borrowed    \00\02\00\00\00\02\00\00\00\07\00\00\00")
    (data $.data (;1;) (i32.const 1056720) "\02\00\00\00\02\00\00\00t\02\10\00y\00\00\00*\02\00\00\11\00\00\00\a5\03\10\00\0a\00\00\00\10\00\00\00\13\00\00\00\b2\03\10\00\10\00\00\00\c2\03\10\00\01\00\00\00\c3\03\10\00\10\00\00\00\c2\03\10\00\01\00\00\00\0d\00\00\00\d3\03\10\005\00\00\00\08\04\10\00\0b\00\00\00\0e\00\00\00\0c\00\00\00\04\00\00\00\0f\00\00\00\10\00\00\00\11\00\00\00@\04\10\00V\00\00\00<\02\10\00\19\00\00\00\88\02\00\00\11\00\00\00\0e\00\00\00\0c\00\00\00\04\00\00\00\12\00\00\00\13\00\00\00\14\00\00\00\0e\00\00\00\0c\00\00\00\04\00\00\00\15\00\00\00\16\00\00\00\17\00\00\00\0e\00\00\00\0c\00\00\00\04\00\00\00\18\00\00\00\19\00\00\00\1a\00\00\00\96\04\10\00\1c\00\00\00\17\00\00\00\02\00\00\00\a4 \10\00<\02\10\00\19\00\00\001\07\00\00$\00\00\00\9f\07\10\00\09\00\00\00\ac\00\10\00(\00\00\00z\00\00\00!\00\00\00\ae\07\10\00\13\00\00\00>\04\10\00\02\00\00\00\d5\00\10\00\1b\00\00\00\8d\04\00\00\09\00\00\00<\02\10\00\19\00\00\000\06\00\00 \00\00\00\c1\07\10\00'\00\00\00<\02\10\00\19\00\00\002\06\00\00\0d\00\00\00\e8\07\10\00#\00\00\00F\01\10\00'\00\00\00\14\00\00\00\0d\00\00\00\0b\08\10\00!\00\00\00\17\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\1b\00\00\00W\08\10\00*\00\00\00\14\00\00\00\02\00\00\00\5c!\10\00\10\00\10\00.\00\00\00'\00\00\006\00\00\00\81\08\10\00\12\00\00\00\10\00\10\00.\00\00\00%\00\00\00\0d\00\00\00\10\00\10\00.\00\00\00,\00\00\00\13\00\00\00\10\00\10\00.\00\00\003\00\00\00\15\00\00\00\93\08\10\008\00\00\00\cb\08\10\009\00\00\00m\09\10\00 \00\00\00?\00\10\00,\00\00\00\13\00\00\00\09\00\00\00\1f\01\10\00&\00\00\00#\01\00\00-\00\00\00\b1\01\10\00#\00\00\00\d7\00\00\00\14\00\00\00\b4\09\10\00\15\00\00\00\c9\09\10\00\0e\00\00\00\b4\09\10\00\15\00\00\00\d7\09\10\00\0d\00\00\00\8c\03\10\00\18\00\00\00d\01\00\00\09\00\00\00\f6\09\10\007\00\00\00V\02\10\00\1d\00\00\00\d4\04\00\00\0d\00\00\00\1c\00\00\00\0c\00\00\00\04\00\00\00\1d\00\00\00\1e\00\00\00\1f\00\00\00 \00\00\00!\00\00\00\22\00\00\00#\00\00\00$\00\00\00\08\00\00\00\04\00\00\00%\00\00\00&\00\00\00'\00\00\00(\00\00\00)\00\00\00*\00\00\00+\00\00\00\01\00\00\00-\0a\10\00N\00\00\00n\01\10\00\1c\00\00\00\1e\01\00\00.\00\00\00\84\0a\10\00\09\00\00\00\8d\0a\10\00\03\00\00\00\90\0a\10\00\0e\00\00\00\9e\0a\10\00\02\00\00\00=\04\10\00\01\00\00\00,\00\00\00\0c\00\00\00\04\00\00\00-\00\00\00.\00\00\00/\00\00\00\00\00\00\00\08\00\00\00\04\00\00\000\00\00\001\00\00\002\00\00\003\00\00\004\00\00\00\10\00\00\00\04\00\00\005\00\00\006\00\00\007\00\00\008\00\00\00\ac\0a\10\00\19\00\00\00\9e\0a\10\00\02\00\00\00=\04\10\00\01\00\00\00\c5\0a\10\00\0c\00\00\00\9e\0a\10\00\02\00\00\00\d1\0a\10\003\00\00\00\04\0b\10\00-\00\00\00\00\00\00\00\04\00\00\00\04\00\00\009\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00:\00\00\00?\03\10\00L\00\00\00\14\0b\00\00$\00\00\00;\00\00\00\0c\00\00\00\04\00\00\00<\00\00\00;\00\00\00\0c\00\00\00\04\00\00\00=\00\00\00<\00\00\00\94#\10\00>\00\00\00?\00\00\00@\00\00\00>\00\00\00A\00\00\00\ee\02\10\00P\00\00\00*\02\00\00\11\00\00\00\01\00\00\00\00\00\00\00l\0b\10\00\0b\00\00\00w\0b\10\00\01\00\00\00\d5\00\10\00\1b\00\00\00\5c\03\00\00\14\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00B\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00C\00\00\00\01\00\00\00\00\00\00\00<\04\10\00\01\00\00\00<\04\10\00\01\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00D\00\00\00\d5\01\10\00J\00\00\00\bd\01\00\00\1d\00\00\00\f1\00\10\00-\00\00\00\16\01\00\00)\00\00\00,\00\00\00\0c\00\00\00\04\00\00\00E\00\00\00\b2\04\10\00\c2\04\10\00\d3\04\10\00\e5\04\10\00\f5\04\10\00\05\05\10\00\18\05\10\00*\05\10\007\05\10\00E\05\10\00Z\05\10\00f\05\10\00q\05\10\00\86\05\10\00\9b\05\10\00\aa\05\10\00\b8\05\10\00\cb\05\10\00\f1\05\10\00)\06\10\00B\06\10\00Y\06\10\00e\06\10\00n\06\10\00x\06\10\00\88\06\10\00\9f\06\10\00\ad\06\10\00\bb\06\10\00\c8\06\10\00\dc\06\10\00\e4\06\10\00\ff\06\10\00\0d\07\10\00\1d\07\10\003\07\10\00H\07\10\00S\07\10\00i\07\10\00v\07\10\00\81\07\10\00\8c\07\10\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00F\00\00\00\ff\ff\ff\ff\b0\03\10\00l\00\10\00\1e\00\00\00U\01\00\00\0b\00\00\00l\00\10\00\1e\00\00\00\1a\01\00\00\1e\00\00\00l\00\10\00\1e\00\00\00\16\01\00\007\00\00\00\fa\12\10\00\11\00\00\00 \02\10\00\1b\00\00\00\af\0a\00\00&\00\00\00 \02\10\00\1b\00\00\00\b8\0a\00\00\1a\00\00\00\00\00\00\00\0c\00\00\00\04\00\00\00M\00\00\00N\00\00\00O\00\00\00\06\18\10\00\0e\00\00\00\14\18\10\00\04\00\00\00\18\18\10\00\10\00\00\00(\18\10\00\01\00\00\00)\18\10\00\0b\00\00\004\18\10\00&\00\00\00Z\18\10\00\08\00\00\00b\18\10\00\06\00\00\00(\18\10\00\01\00\00\00)\18\10\00\0b\00\00\00h\18\10\00\16\00\00\00(\18\10\00\01\00\00\00\88\18\10\00\10\00\00\00\98\18\10\00\22\00\00\00\ba\18\10\00\16\00\00\00\d0\18\10\00\0d\00\00\00\dd\18\10\00\12\00\00\00\98\18\10\00\22\00\00\00\8b\00\10\00 \00\00\00\84\00\00\00\1e\00\00\00\8b\00\10\00 \00\00\00\a0\00\00\00\09\00\00\00\01\00\00\00\00\00\00\00\f9\16\10\00\02\00\00\00\8b\01\10\00%\00\00\00\1a\00\00\006\00\00\00\8b\01\10\00%\00\00\00\0a\00\00\00+\00\00\00X\1f\10\00\10\00\00\00h\1f\10\00\17\00\00\00\7f\1f\10\00\09\00\00\00X\1f\10\00\10\00\00\00\88\1f\10\00\10\00\00\00\98\1f\10\00\09\00\00\00\7f\1f\10\00\09\00\00\00M\1f\10\00O\1f\10\00Q\1f\10\00")
    (@producers
      (language "Rust" "")
      (language "C11" "")
      (processed-by "rustc" "1.91.1 (ed61e7d7e 2025-11-07)")
      (processed-by "clang" "20.1.8-wasi-sdk (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)")
      (processed-by "wit-component" "0.20.1")
      (processed-by "wit-bindgen-rust" "0.45.0")
      (processed-by "wit-bindgen-c" "0.17.0")
    )
    (@custom "target_features" (after data) "\09+\0bbulk-memory+\0fbulk-memory-opt+\16call-indirect-overlong+\0eextended-const+\0amultivalue+\0fmutable-globals+\13nontrapping-fptoint+\0freference-types+\08sign-ext")
  )
  (core module (;1;)
    (type (;0;) (func (param i32)))
    (type (;1;) (func (param i32 i32)))
    (type (;2;) (func (param i32 i32 i32 i32)))
    (type (;3;) (func (param i32 i32 i32 i32) (result i32)))
    (type (;4;) (func (result i32)))
    (type (;5;) (func (param i32 i32) (result i32)))
    (type (;6;) (func (param i32 i32 i32) (result i32)))
    (type (;7;) (func))
    (import "env" "memory" (memory (;0;) 0))
    (import "wasi:cli/environment@0.2.6" "get-environment" (func $_ZN22wasi_snapshot_preview124wasi_cli_get_environment17hd91349d7511e889dE (;0;) (type 0)))
    (import "wasi:io/streams@0.2.6" "[resource-drop]output-stream" (func $_ZN137_$LT$wasi_snapshot_preview1..bindings..wasi..io..streams..OutputStream$u20$as$u20$wasi_snapshot_preview1..bindings.._rt..WasmResource$GT$4drop4drop17h7e9e0ccc97db9a68E (;1;) (type 0)))
    (import "wasi:io/error@0.2.6" "[resource-drop]error" (func $_ZN128_$LT$wasi_snapshot_preview1..bindings..wasi..io..error..Error$u20$as$u20$wasi_snapshot_preview1..bindings.._rt..WasmResource$GT$4drop4drop17h307e3b67ba1db50cE (;2;) (type 0)))
    (import "__main_module__" "cabi_realloc" (func $_ZN22wasi_snapshot_preview15State3new12cabi_realloc17h95199bd564b03e97E (;3;) (type 3)))
    (import "wasi:cli/stderr@0.2.6" "get-stderr" (func $_ZN22wasi_snapshot_preview18bindings4wasi3cli6stderr10get_stderr11wit_import017hfab20fe8fd705f8aE (;4;) (type 4)))
    (import "wasi:io/streams@0.2.6" "[method]output-stream.blocking-write-and-flush" (func $_ZN22wasi_snapshot_preview18bindings4wasi2io7streams12OutputStream24blocking_write_and_flush11wit_import217hab3f5533e90cb774E (;5;) (type 2)))
    (import "wasi:cli/exit@0.2.6" "exit" (func $_ZN22wasi_snapshot_preview18bindings4wasi3cli4exit4exit11wit_import117h75e8d53fb2061fa3E (;6;) (type 0)))
    (global $__stack_pointer (;0;) (mut i32) i32.const 0)
    (global $internal_state_ptr (;1;) (mut i32) i32.const 0)
    (global $allocation_state (;2;) (mut i32) i32.const 0)
    (export "environ_sizes_get" (func $environ_sizes_get))
    (export "proc_exit" (func $proc_exit))
    (export "environ_get" (func $environ_get))
    (export "cabi_import_realloc" (func $cabi_import_realloc))
    (func $_ZN22wasi_snapshot_preview15State3ptr17h2803479c6950581dE (;7;) (type 4) (result i32)
      (local i32)
      block ;; label = @1
        call $get_state_ptr
        local.tee 0
        br_if 0 (;@1;)
        call $_ZN22wasi_snapshot_preview15State3new17ha84499d1912b46c3E
        local.tee 0
        call $set_state_ptr
      end
      local.get 0
    )
    (func $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E (;8;) (type 0) (param i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 1
      i32.const 32
      i32.store8 offset=47
      local.get 1
      i64.const 7308895158390646132
      i64.store offset=39 align=1
      local.get 1
      i64.const 8097863973307965728
      i64.store offset=31 align=1
      local.get 1
      i64.const 7234307576302018670
      i64.store offset=23 align=1
      local.get 1
      i64.const 8028075845441778529
      i64.store offset=15 align=1
      local.get 1
      i32.const 15
      i32.add
      i32.const 33
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      local.get 0
      call $_ZN22wasi_snapshot_preview16macros10eprint_u3217ha368748b66280818E
      unreachable
    )
    (func $cabi_import_realloc (;9;) (type 3) (param i32 i32 i32 i32) (result i32)
      (local i32 i32 i64)
      call $allocate_stack
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    block ;; label = @8
                      block ;; label = @9
                        block ;; label = @10
                          call $_ZN22wasi_snapshot_preview15State3ptr17h2803479c6950581dE
                          local.tee 5
                          i32.load
                          i32.const 560490357
                          i32.ne
                          br_if 0 (;@10;)
                          local.get 5
                          i32.load offset=65532
                          i32.const 560490357
                          i32.ne
                          br_if 1 (;@9;)
                          local.get 5
                          i64.load offset=4 align=4
                          local.set 6
                          local.get 5
                          i32.const 4
                          i32.store offset=4
                          local.get 4
                          i32.const 16
                          i32.add
                          local.get 5
                          i32.const 20
                          i32.add
                          i32.load
                          i32.store
                          local.get 4
                          i32.const 8
                          i32.add
                          local.get 5
                          i32.const 12
                          i32.add
                          i64.load align=4
                          i64.store
                          local.get 4
                          local.get 6
                          i64.store
                          local.get 0
                          i32.eqz
                          br_if 2 (;@8;)
                          local.get 1
                          local.get 3
                          i32.le_u
                          br_if 3 (;@7;)
                          local.get 2
                          i32.const 1
                          i32.eq
                          br_if 9 (;@1;)
                          i32.const 387
                          call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
                          unreachable
                        end
                        i32.const 2795
                        call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
                        unreachable
                      end
                      i32.const 2796
                      call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
                      unreachable
                    end
                    local.get 4
                    i32.load
                    br_table 5 (;@2;) 3 (;@4;) 2 (;@5;) 1 (;@6;) 4 (;@3;) 5 (;@2;)
                  end
                  i32.const 386
                  call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
                  unreachable
                end
                local.get 4
                i32.const 12
                i32.add
                local.set 0
                block ;; label = @6
                  local.get 2
                  i32.const 1
                  i32.eq
                  br_if 0 (;@6;)
                  local.get 0
                  local.get 2
                  local.get 3
                  call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
                  local.set 0
                  br 5 (;@1;)
                end
                local.get 4
                local.get 4
                i32.load offset=4
                local.tee 2
                i32.const 1
                i32.add
                i32.store offset=4
                block ;; label = @6
                  local.get 2
                  local.get 4
                  i32.load offset=8
                  i32.eq
                  br_if 0 (;@6;)
                  local.get 4
                  local.get 4
                  i64.load offset=12 align=4
                  i64.store offset=24 align=4
                  local.get 4
                  i32.const 24
                  i32.add
                  i32.const 1
                  local.get 3
                  call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
                  local.set 0
                  br 5 (;@1;)
                end
                local.get 0
                i32.const 1
                local.get 3
                call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
                local.set 0
                br 4 (;@1;)
              end
              block ;; label = @5
                local.get 2
                i32.const 1
                i32.eq
                br_if 0 (;@5;)
                local.get 4
                i32.const 12
                i32.add
                local.get 2
                local.get 3
                call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
                local.set 0
                br 4 (;@1;)
              end
              local.get 4
              i32.const 4
              i32.or
              i32.const 1
              local.get 3
              i32.const 1
              i32.add
              call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
              local.set 0
              br 3 (;@1;)
            end
            block ;; label = @4
              local.get 2
              i32.const 1
              i32.eq
              br_if 0 (;@4;)
              local.get 4
              i32.const 8
              i32.add
              local.get 2
              local.get 3
              call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
              local.set 0
              br 3 (;@1;)
            end
            local.get 4
            local.get 4
            i32.load offset=4
            local.get 3
            i32.add
            i32.store offset=4
            local.get 4
            local.get 4
            i64.load offset=8
            i64.store offset=24 align=4
            local.get 4
            i32.const 24
            i32.add
            i32.const 1
            local.get 3
            call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
            local.set 0
            br 2 (;@1;)
          end
          i32.const 428
          call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
          local.get 4
          i32.const 8250
          i32.store16 offset=24 align=1
          local.get 4
          i32.const 24
          i32.add
          i32.const 2
          call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
          local.get 4
          i64.const 748834980320733542
          i64.store offset=40 align=1
          local.get 4
          i64.const 7957688057596965985
          i64.store offset=32 align=1
          local.get 4
          i64.const 7165064744911531886
          i64.store offset=24 align=1
          local.get 4
          i32.const 24
          i32.add
          i32.const 24
          call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
          local.get 4
          i32.const 10
          i32.store8 offset=24
          local.get 4
          i32.const 24
          i32.add
          i32.const 1
          call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
          unreachable
        end
        local.get 4
        i32.const 4
        i32.or
        local.get 2
        local.get 3
        call $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E
        local.set 0
        local.get 4
        i32.const 4
        i32.store
      end
      local.get 5
      i32.const 4
      i32.add
      local.tee 5
      local.get 4
      i64.load
      i64.store align=4
      local.get 5
      i32.const 16
      i32.add
      local.get 4
      i32.const 16
      i32.add
      i32.load
      i32.store
      local.get 5
      i32.const 8
      i32.add
      local.get 4
      i32.const 8
      i32.add
      i64.load
      i64.store align=4
      local.get 4
      i32.const 48
      i32.add
      global.set $__stack_pointer
      local.get 0
    )
    (func $_ZN22wasi_snapshot_preview19BumpAlloc5alloc17h033fed397a0a9831E (;10;) (type 6) (param i32 i32 i32) (result i32)
      (local i32 i32 i32)
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 3
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            local.get 1
            i32.popcnt
            i32.const 1
            i32.ne
            br_if 0 (;@3;)
            local.get 0
            i32.load offset=4
            local.tee 4
            local.get 1
            local.get 0
            i32.load
            local.tee 5
            i32.add
            i32.const -1
            i32.add
            i32.const 0
            local.get 1
            i32.sub
            i32.and
            local.get 5
            i32.sub
            local.tee 1
            i32.lt_u
            br_if 1 (;@2;)
            local.get 4
            local.get 1
            i32.sub
            local.tee 4
            local.get 2
            i32.ge_u
            br_if 2 (;@1;)
            i32.const 450
            call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
            local.get 3
            i32.const 8250
            i32.store16 offset=3 align=1
            local.get 3
            i32.const 3
            i32.add
            i32.const 2
            call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
            local.get 3
            i32.const 10
            i32.store8 offset=31
            local.get 3
            i32.const 1701278305
            i32.store offset=27 align=1
            local.get 3
            i64.const 7791349879831294825
            i64.store offset=19 align=1
            local.get 3
            i64.const 2334406575183130223
            i64.store offset=11 align=1
            local.get 3
            i64.const 7598805550979902561
            i64.store offset=3 align=1
            local.get 3
            i32.const 3
            i32.add
            i32.const 29
            call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
            local.get 3
            i32.const 10
            i32.store8 offset=3
            local.get 3
            i32.const 3
            i32.add
            i32.const 1
            call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
            unreachable
          end
          i32.const 460
          call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
          local.get 3
          i32.const 8250
          i32.store16 offset=3 align=1
          local.get 3
          i32.const 3
          i32.add
          i32.const 2
          call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
          local.get 3
          i32.const 2676
          i32.store16 offset=19 align=1
          local.get 3
          i64.const 7954884637768641633
          i64.store offset=11 align=1
          local.get 3
          i64.const 2334106421097295465
          i64.store offset=3 align=1
          local.get 3
          i32.const 3
          i32.add
          i32.const 18
          call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
          local.get 3
          i32.const 10
          i32.store8 offset=3
          local.get 3
          i32.const 3
          i32.add
          i32.const 1
          call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
          unreachable
        end
        i32.const 464
        call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
        local.get 3
        i32.const 8250
        i32.store16 offset=3 align=1
        local.get 3
        i32.const 3
        i32.add
        i32.const 2
        call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
        local.get 3
        i32.const 10
        i32.store8 offset=21
        local.get 3
        i32.const 25972
        i32.store16 offset=19 align=1
        local.get 3
        i64.const 7017575155838820463
        i64.store offset=11 align=1
        local.get 3
        i64.const 8367798494427701606
        i64.store offset=3 align=1
        local.get 3
        i32.const 3
        i32.add
        i32.const 19
        call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
        local.get 3
        i32.const 10
        i32.store8 offset=3
        local.get 3
        i32.const 3
        i32.add
        i32.const 1
        call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
        unreachable
      end
      local.get 0
      local.get 4
      local.get 2
      i32.sub
      i32.store offset=4
      local.get 0
      local.get 5
      local.get 1
      i32.add
      local.tee 1
      local.get 2
      i32.add
      i32.store
      local.get 3
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 1
    )
    (func $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E (;11;) (type 0) (param i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 1
      i32.const 32
      i32.store8 offset=47
      local.get 1
      i32.const 1701734764
      i32.store offset=43 align=1
      local.get 1
      i64.const 2338042707334751329
      i64.store offset=35 align=1
      local.get 1
      i64.const 2338600898263348341
      i64.store offset=27 align=1
      local.get 1
      i64.const 7162263158133189730
      i64.store offset=19 align=1
      local.get 1
      i64.const 7018969289221893749
      i64.store offset=11 align=1
      local.get 1
      i32.const 11
      i32.add
      i32.const 37
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      local.get 0
      call $_ZN22wasi_snapshot_preview16macros10eprint_u3215eprint_u32_impl17hf0d78a676c195047E
      local.get 1
      i32.const 48
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE (;12;) (type 1) (param i32 i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      local.get 2
      call $_ZN22wasi_snapshot_preview18bindings4wasi3cli6stderr10get_stderr11wit_import017hfab20fe8fd705f8aE
      i32.store offset=12
      local.get 2
      i32.const 4
      i32.add
      local.get 2
      i32.const 12
      i32.add
      local.get 0
      local.get 1
      call $_ZN22wasi_snapshot_preview18bindings4wasi2io7streams12OutputStream24blocking_write_and_flush17h17e28cd33036c401E
      block ;; label = @1
        local.get 2
        i32.load offset=4
        local.tee 1
        i32.const 2
        i32.eq
        br_if 0 (;@1;)
        local.get 1
        br_if 0 (;@1;)
        local.get 2
        i32.load offset=8
        local.tee 1
        i32.const -1
        i32.eq
        br_if 0 (;@1;)
        local.get 1
        call $_ZN128_$LT$wasi_snapshot_preview1..bindings..wasi..io..error..Error$u20$as$u20$wasi_snapshot_preview1..bindings.._rt..WasmResource$GT$4drop4drop17h307e3b67ba1db50cE
      end
      block ;; label = @1
        local.get 2
        i32.load offset=12
        local.tee 1
        i32.const -1
        i32.eq
        br_if 0 (;@1;)
        local.get 1
        call $_ZN137_$LT$wasi_snapshot_preview1..bindings..wasi..io..streams..OutputStream$u20$as$u20$wasi_snapshot_preview1..bindings.._rt..WasmResource$GT$4drop4drop17h7e9e0ccc97db9a68E
      end
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN22wasi_snapshot_preview16macros11unreachable17h7096e84065e14834E (;13;) (type 0) (param i32)
      (local i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 0
      call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
      local.get 1
      i32.const 10
      i32.store8 offset=15
      local.get 1
      i32.const 15
      i32.add
      i32.const 1
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      unreachable
    )
    (func $environ_get (;14;) (type 5) (param i32 i32) (result i32)
      (local i32 i32 i32 i32 i32 i32)
      call $allocate_stack
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            call $_ZN22wasi_snapshot_preview15State3ptr17h2803479c6950581dE
            local.tee 3
            i32.load
            i32.const 560490357
            i32.ne
            br_if 0 (;@3;)
            local.get 3
            i32.load offset=65532
            i32.const 560490357
            i32.ne
            br_if 1 (;@2;)
            local.get 3
            i32.const 59032
            i32.store offset=20
            local.get 3
            i32.const -1
            i32.store offset=12
            local.get 3
            local.get 1
            i32.store offset=8
            local.get 3
            local.get 3
            i32.const 6192
            i32.add
            i32.store offset=16
            local.get 3
            i32.load offset=4
            local.set 1
            local.get 3
            i32.const 2
            i32.store offset=4
            local.get 1
            i32.const 4
            i32.ne
            br_if 2 (;@1;)
            local.get 2
            i64.const 0
            i64.store align=4
            local.get 2
            call $_ZN22wasi_snapshot_preview124wasi_cli_get_environment17hd91349d7511e889dE
            local.get 2
            i32.load offset=4
            local.set 4
            local.get 2
            i32.load
            local.set 1
            local.get 3
            i32.const 4
            i32.store offset=4
            block ;; label = @4
              local.get 4
              i32.eqz
              br_if 0 (;@4;)
              loop ;; label = @5
                local.get 1
                i32.const 12
                i32.add
                i32.load
                local.set 3
                local.get 1
                i32.const 8
                i32.add
                i32.load
                local.set 5
                local.get 1
                i32.const 4
                i32.add
                i32.load
                local.set 6
                local.get 0
                local.get 1
                i32.load
                local.tee 7
                i32.store
                local.get 7
                local.get 6
                i32.add
                i32.const 61
                i32.store8
                local.get 5
                local.get 3
                i32.add
                i32.const 0
                i32.store8
                local.get 1
                i32.const 16
                i32.add
                local.set 1
                local.get 0
                i32.const 4
                i32.add
                local.set 0
                local.get 4
                i32.const -1
                i32.add
                local.tee 4
                br_if 0 (;@5;)
              end
            end
            local.get 2
            i32.const 32
            i32.add
            global.set $__stack_pointer
            i32.const 0
            return
          end
          i32.const 2795
          call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
          unreachable
        end
        i32.const 2796
        call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
        unreachable
      end
      i32.const 2936
      call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
      local.get 2
      i32.const 8250
      i32.store16 align=1
      local.get 2
      i32.const 2
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      local.get 2
      i32.const 10
      i32.store8 offset=28
      local.get 2
      i32.const 1952805664
      i32.store offset=24 align=1
      local.get 2
      i64.const 8747223464599642400
      i64.store offset=16 align=1
      local.get 2
      i64.const 8245937404367563884
      i64.store offset=8 align=1
      local.get 2
      i64.const 6998721855778483561
      i64.store align=1
      local.get 2
      i32.const 29
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      local.get 2
      i32.const 10
      i32.store8
      local.get 2
      i32.const 1
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      unreachable
    )
    (func $environ_sizes_get (;15;) (type 5) (param i32 i32) (result i32)
      (local i32 i32 i32 i32)
      call $allocate_stack
      global.get $__stack_pointer
      i32.const 32
      i32.sub
      local.tee 2
      global.set $__stack_pointer
      block ;; label = @1
        block ;; label = @2
          block ;; label = @3
            block ;; label = @4
              block ;; label = @5
                block ;; label = @6
                  block ;; label = @7
                    call $get_allocation_state
                    i32.const -2
                    i32.add
                    br_table 1 (;@6;) 0 (;@7;) 1 (;@6;) 0 (;@7;)
                  end
                  i32.const 0
                  local.set 3
                  local.get 0
                  i32.const 0
                  i32.store
                  br 1 (;@5;)
                end
                call $_ZN22wasi_snapshot_preview15State3ptr17h2803479c6950581dE
                local.tee 3
                i32.load
                i32.const 560490357
                i32.ne
                br_if 1 (;@4;)
                local.get 3
                i32.load offset=65532
                i32.const 560490357
                i32.ne
                br_if 2 (;@3;)
                local.get 3
                i32.const 59032
                i32.store offset=16
                local.get 3
                local.get 3
                i32.const 6192
                i32.add
                i32.store offset=12
                local.get 3
                i32.load offset=4
                local.set 4
                local.get 3
                i64.const 1
                i64.store offset=4 align=4
                local.get 4
                i32.const 4
                i32.ne
                br_if 3 (;@2;)
                local.get 2
                i64.const 0
                i64.store align=4
                local.get 2
                call $_ZN22wasi_snapshot_preview124wasi_cli_get_environment17hd91349d7511e889dE
                local.get 2
                i32.load offset=4
                local.set 4
                local.get 3
                i32.load offset=4
                local.set 5
                local.get 3
                i32.const 4
                i32.store offset=4
                local.get 5
                i32.const 1
                i32.ne
                br_if 4 (;@1;)
                local.get 3
                i32.load offset=8
                local.set 3
                local.get 0
                local.get 4
                i32.store
                local.get 3
                local.get 4
                i32.const 1
                i32.shl
                i32.add
                local.set 3
              end
              local.get 1
              local.get 3
              i32.store
              local.get 2
              i32.const 32
              i32.add
              global.set $__stack_pointer
              i32.const 0
              return
            end
            i32.const 2795
            call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
            unreachable
          end
          i32.const 2796
          call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
          unreachable
        end
        i32.const 2936
        call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
        local.get 2
        i32.const 8250
        i32.store16 align=1
        local.get 2
        i32.const 2
        call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
        local.get 2
        i32.const 10
        i32.store8 offset=28
        local.get 2
        i32.const 1952805664
        i32.store offset=24 align=1
        local.get 2
        i64.const 8747223464599642400
        i64.store offset=16 align=1
        local.get 2
        i64.const 8245937404367563884
        i64.store offset=8 align=1
        local.get 2
        i64.const 6998721855778483561
        i64.store align=1
        local.get 2
        i32.const 29
        call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
        local.get 2
        i32.const 10
        i32.store8
        local.get 2
        i32.const 1
        call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
        unreachable
      end
      i32.const 644
      call $_ZN22wasi_snapshot_preview16macros11unreachable17h7096e84065e14834E
      unreachable
    )
    (func $_ZN22wasi_snapshot_preview18bindings4wasi2io7streams12OutputStream24blocking_write_and_flush17h17e28cd33036c401E (;16;) (type 2) (param i32 i32 i32 i32)
      (local i32 i64)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 4
      global.set $__stack_pointer
      local.get 1
      i32.load
      local.get 2
      local.get 3
      local.get 4
      i32.const 4
      i32.add
      call $_ZN22wasi_snapshot_preview18bindings4wasi2io7streams12OutputStream24blocking_write_and_flush11wit_import217hab3f5533e90cb774E
      block ;; label = @1
        block ;; label = @2
          local.get 4
          i32.load8_u offset=4
          br_if 0 (;@2;)
          i64.const 2
          local.set 5
          br 1 (;@1;)
        end
        i64.const 1
        local.get 4
        i64.load32_u offset=12
        i64.const 32
        i64.shl
        local.get 4
        i32.load8_u offset=8
        select
        local.set 5
      end
      local.get 0
      local.get 5
      i64.store align=4
      local.get 4
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $proc_exit (;17;) (type 0) (param i32)
      (local i32)
      call $allocate_stack
      global.get $__stack_pointer
      i32.const 48
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      local.get 0
      i32.const 0
      i32.ne
      call $_ZN22wasi_snapshot_preview18bindings4wasi3cli4exit4exit17h1aa6383e2273d08aE
      i32.const 2330
      call $_ZN22wasi_snapshot_preview16macros18eprint_unreachable17h1be46d0de61741c0E
      local.get 1
      i32.const 8250
      i32.store16 offset=10 align=1
      local.get 1
      i32.const 10
      i32.add
      i32.const 2
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      local.get 1
      i32.const 2593
      i32.store16 offset=46 align=1
      local.get 1
      i32.const 1953069157
      i32.store offset=42 align=1
      local.get 1
      i64.const 2338537461596644384
      i64.store offset=34 align=1
      local.get 1
      i64.const 7957695015159098981
      i64.store offset=26 align=1
      local.get 1
      i64.const 7882825952909664372
      i64.store offset=18 align=1
      local.get 1
      i64.const 7599935561254793064
      i64.store offset=10 align=1
      local.get 1
      i32.const 10
      i32.add
      i32.const 38
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      local.get 1
      i32.const 10
      i32.store8 offset=10
      local.get 1
      i32.const 10
      i32.add
      i32.const 1
      call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      unreachable
    )
    (func $_ZN22wasi_snapshot_preview18bindings4wasi3cli4exit4exit17h1aa6383e2273d08aE (;18;) (type 0) (param i32)
      local.get 0
      call $_ZN22wasi_snapshot_preview18bindings4wasi3cli4exit4exit11wit_import117h75e8d53fb2061fa3E
    )
    (func $_ZN22wasi_snapshot_preview15State3new17ha84499d1912b46c3E (;19;) (type 4) (result i32)
      (local i32)
      block ;; label = @1
        call $get_allocation_state
        i32.const 2
        i32.ne
        br_if 0 (;@1;)
        i32.const 3
        call $set_allocation_state
        i32.const 0
        i32.const 0
        i32.const 8
        i32.const 65536
        call $_ZN22wasi_snapshot_preview15State3new12cabi_realloc17h95199bd564b03e97E
        local.set 0
        i32.const 4
        call $set_allocation_state
        local.get 0
        i32.const 2
        i32.store offset=6180
        local.get 0
        i32.const 0
        i32.store offset=24
        local.get 0
        i64.const 17740359541
        i64.store
        block ;; label = @2
          i32.const 37
          i32.eqz
          br_if 0 (;@2;)
          local.get 0
          i32.const 65480
          i32.add
          i32.const 0
          i32.const 37
          memory.fill
        end
        local.get 0
        i32.const 560490357
        i32.store offset=65532
        local.get 0
        i32.const 11822
        i32.store16 offset=65528
        local.get 0
        i32.const 0
        i32.store offset=65520
        local.get 0
        return
      end
      i32.const 2827
      call $_ZN22wasi_snapshot_preview16macros11assert_fail17hb9324b4de76c4900E
      unreachable
    )
    (func $_ZN22wasi_snapshot_preview16macros10eprint_u3215eprint_u32_impl17hf0d78a676c195047E (;20;) (type 0) (param i32)
      (local i32 i32)
      global.get $__stack_pointer
      i32.const 16
      i32.sub
      local.tee 1
      global.set $__stack_pointer
      block ;; label = @1
        local.get 0
        i32.eqz
        br_if 0 (;@1;)
        local.get 0
        i32.const 10
        i32.div_u
        local.tee 2
        call $_ZN22wasi_snapshot_preview16macros10eprint_u3215eprint_u32_impl17hf0d78a676c195047E
        local.get 1
        local.get 2
        i32.const 246
        i32.mul
        local.get 0
        i32.add
        i32.const 48
        i32.or
        i32.store8 offset=15
        local.get 1
        i32.const 15
        i32.add
        i32.const 1
        call $_ZN22wasi_snapshot_preview16macros5print17h7a5e480c00a9a73eE
      end
      local.get 1
      i32.const 16
      i32.add
      global.set $__stack_pointer
    )
    (func $_ZN22wasi_snapshot_preview16macros10eprint_u3217ha368748b66280818E (;21;) (type 0) (param i32)
      local.get 0
      call $_ZN22wasi_snapshot_preview16macros10eprint_u3215eprint_u32_impl17hf0d78a676c195047E
    )
    (func $get_state_ptr (;22;) (type 4) (result i32)
      global.get $internal_state_ptr
    )
    (func $set_state_ptr (;23;) (type 0) (param i32)
      local.get 0
      global.set $internal_state_ptr
    )
    (func $get_allocation_state (;24;) (type 4) (result i32)
      global.get $allocation_state
    )
    (func $set_allocation_state (;25;) (type 0) (param i32)
      local.get 0
      global.set $allocation_state
    )
    (func $allocate_stack (;26;) (type 7)
      global.get $allocation_state
      i32.const 0
      i32.eq
      if ;; label = @1
        i32.const 1
        global.set $allocation_state
        i32.const 0
        i32.const 0
        i32.const 8
        i32.const 65536
        call $_ZN22wasi_snapshot_preview15State3new12cabi_realloc17h95199bd564b03e97E
        i32.const 65536
        i32.add
        global.set $__stack_pointer
        i32.const 2
        global.set $allocation_state
      end
    )
    (@producers
      (language "Rust" "")
      (processed-by "rustc" "1.88.0 (6b00bc388 2025-06-23)")
    )
  )
  (core module (;2;)
    (type (;0;) (func (param i32 i32)))
    (type (;1;) (func (param i32 i32)))
    (type (;2;) (func (param i32 i32 i32 i32)))
    (type (;3;) (func (param i32 i32) (result i32)))
    (type (;4;) (func (param i32)))
    (type (;5;) (func (param i32)))
    (table (;0;) 8 8 funcref)
    (export "0" (func $indirect-docs:guest/hosted@0.1.0-host-function))
    (export "1" (func $"indirect-wasi:io/error@0.2.4-[method]error.to-debug-string"))
    (export "2" (func $"indirect-wasi:io/streams@0.2.4-[method]output-stream.blocking-write-and-flush"))
    (export "3" (func $adapt-wasi_snapshot_preview1-environ_get))
    (export "4" (func $adapt-wasi_snapshot_preview1-environ_sizes_get))
    (export "5" (func $adapt-wasi_snapshot_preview1-proc_exit))
    (export "6" (func $indirect-wasi:cli/environment@0.2.6-get-environment))
    (export "7" (func $"indirect-wasi:io/streams@0.2.6-[method]output-stream.blocking-write-and-flush"))
    (export "$imports" (table 0))
    (func $indirect-docs:guest/hosted@0.1.0-host-function (;0;) (type 0) (param i32 i32)
      local.get 0
      local.get 1
      i32.const 0
      call_indirect (type 0)
    )
    (func $"indirect-wasi:io/error@0.2.4-[method]error.to-debug-string" (;1;) (type 1) (param i32 i32)
      local.get 0
      local.get 1
      i32.const 1
      call_indirect (type 1)
    )
    (func $"indirect-wasi:io/streams@0.2.4-[method]output-stream.blocking-write-and-flush" (;2;) (type 2) (param i32 i32 i32 i32)
      local.get 0
      local.get 1
      local.get 2
      local.get 3
      i32.const 2
      call_indirect (type 2)
    )
    (func $adapt-wasi_snapshot_preview1-environ_get (;3;) (type 3) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      i32.const 3
      call_indirect (type 3)
    )
    (func $adapt-wasi_snapshot_preview1-environ_sizes_get (;4;) (type 3) (param i32 i32) (result i32)
      local.get 0
      local.get 1
      i32.const 4
      call_indirect (type 3)
    )
    (func $adapt-wasi_snapshot_preview1-proc_exit (;5;) (type 4) (param i32)
      local.get 0
      i32.const 5
      call_indirect (type 4)
    )
    (func $indirect-wasi:cli/environment@0.2.6-get-environment (;6;) (type 5) (param i32)
      local.get 0
      i32.const 6
      call_indirect (type 5)
    )
    (func $"indirect-wasi:io/streams@0.2.6-[method]output-stream.blocking-write-and-flush" (;7;) (type 2) (param i32 i32 i32 i32)
      local.get 0
      local.get 1
      local.get 2
      local.get 3
      i32.const 7
      call_indirect (type 2)
    )
    (@producers
      (processed-by "wit-component" "0.239.0")
    )
  )
  (core module (;3;)
    (type (;0;) (func (param i32 i32)))
    (type (;1;) (func (param i32 i32)))
    (type (;2;) (func (param i32 i32 i32 i32)))
    (type (;3;) (func (param i32 i32) (result i32)))
    (type (;4;) (func (param i32)))
    (type (;5;) (func (param i32)))
    (import "" "0" (func (;0;) (type 0)))
    (import "" "1" (func (;1;) (type 1)))
    (import "" "2" (func (;2;) (type 2)))
    (import "" "3" (func (;3;) (type 3)))
    (import "" "4" (func (;4;) (type 3)))
    (import "" "5" (func (;5;) (type 4)))
    (import "" "6" (func (;6;) (type 5)))
    (import "" "7" (func (;7;) (type 2)))
    (import "" "$imports" (table (;0;) 8 8 funcref))
    (elem (;0;) (i32.const 0) func 0 1 2 3 4 5 6 7)
    (@producers
      (processed-by "wit-component" "0.239.0")
    )
  )
  (core instance (;0;) (instantiate 2))
  (alias core export 0 "0" (core func (;0;)))
  (core instance (;1;)
    (export "host-function" (func 0))
  )
  (alias export 1 "error" (type (;10;)))
  (core func (;1;) (canon resource.drop 10))
  (alias core export 0 "1" (core func (;2;)))
  (core instance (;2;)
    (export "[resource-drop]error" (func 1))
    (export "[method]error.to-debug-string" (func 2))
  )
  (alias export 2 "output-stream" (type (;11;)))
  (core func (;3;) (canon resource.drop 11))
  (alias core export 0 "2" (core func (;4;)))
  (core instance (;3;)
    (export "[resource-drop]output-stream" (func 3))
    (export "[method]output-stream.blocking-write-and-flush" (func 4))
  )
  (alias export 6 "get-stderr" (func (;0;)))
  (core func (;5;) (canon lower (func 0)))
  (core instance (;4;)
    (export "get-stderr" (func 5))
  )
  (alias export 5 "get-stdout" (func (;1;)))
  (core func (;6;) (canon lower (func 1)))
  (core instance (;5;)
    (export "get-stdout" (func 6))
  )
  (alias core export 0 "3" (core func (;7;)))
  (alias core export 0 "4" (core func (;8;)))
  (alias core export 0 "5" (core func (;9;)))
  (core instance (;6;)
    (export "environ_get" (func 7))
    (export "environ_sizes_get" (func 8))
    (export "proc_exit" (func 9))
  )
  (core instance (;7;) (instantiate 0
      (with "docs:guest/hosted@0.1.0" (instance 1))
      (with "wasi:io/error@0.2.4" (instance 2))
      (with "wasi:io/streams@0.2.4" (instance 3))
      (with "wasi:cli/stderr@0.2.4" (instance 4))
      (with "wasi:cli/stdout@0.2.4" (instance 5))
      (with "wasi_snapshot_preview1" (instance 6))
    )
  )
  (alias core export 7 "memory" (core memory (;0;)))
  (core instance (;8;)
    (export "memory" (memory 0))
  )
  (alias core export 0 "6" (core func (;10;)))
  (core instance (;9;)
    (export "get-environment" (func 10))
  )
  (alias export 2 "output-stream" (type (;12;)))
  (core func (;11;) (canon resource.drop 12))
  (alias core export 0 "7" (core func (;12;)))
  (core instance (;10;)
    (export "[resource-drop]output-stream" (func 11))
    (export "[method]output-stream.blocking-write-and-flush" (func 12))
  )
  (alias export 1 "error" (type (;13;)))
  (core func (;13;) (canon resource.drop 13))
  (core instance (;11;)
    (export "[resource-drop]error" (func 13))
  )
  (alias core export 7 "cabi_realloc" (core func (;14;)))
  (core instance (;12;)
    (export "cabi_realloc" (func 14))
  )
  (alias export 6 "get-stderr" (func (;2;)))
  (core func (;15;) (canon lower (func 2)))
  (core instance (;13;)
    (export "get-stderr" (func 15))
  )
  (alias export 4 "exit" (func (;3;)))
  (core func (;16;) (canon lower (func 3)))
  (core instance (;14;)
    (export "exit" (func 16))
  )
  (core instance (;15;) (instantiate 1
      (with "env" (instance 8))
      (with "wasi:cli/environment@0.2.6" (instance 9))
      (with "wasi:io/streams@0.2.6" (instance 10))
      (with "wasi:io/error@0.2.6" (instance 11))
      (with "__main_module__" (instance 12))
      (with "wasi:cli/stderr@0.2.6" (instance 13))
      (with "wasi:cli/exit@0.2.6" (instance 14))
    )
  )
  (alias core export 0 "$imports" (core table (;0;)))
  (alias export 0 "host-function" (func (;4;)))
  (core func (;17;) (canon lower (func 4) (memory 0)))
  (alias export 1 "[method]error.to-debug-string" (func (;5;)))
  (core func (;18;) (canon lower (func 5) (memory 0) (realloc 14) string-encoding=utf8))
  (alias export 2 "[method]output-stream.blocking-write-and-flush" (func (;6;)))
  (core func (;19;) (canon lower (func 6) (memory 0)))
  (alias core export 15 "environ_get" (core func (;20;)))
  (alias core export 15 "environ_sizes_get" (core func (;21;)))
  (alias core export 15 "proc_exit" (core func (;22;)))
  (alias export 3 "get-environment" (func (;7;)))
  (alias core export 15 "cabi_import_realloc" (core func (;23;)))
  (core func (;24;) (canon lower (func 7) (memory 0) (realloc 23) string-encoding=utf8))
  (alias export 2 "[method]output-stream.blocking-write-and-flush" (func (;8;)))
  (core func (;25;) (canon lower (func 8) (memory 0)))
  (core instance (;16;)
    (export "$imports" (table 0))
    (export "0" (func 17))
    (export "1" (func 18))
    (export "2" (func 19))
    (export "3" (func 20))
    (export "4" (func 21))
    (export "5" (func 22))
    (export "6" (func 24))
    (export "7" (func 25))
  )
  (core instance (;17;) (instantiate 3
      (with "" (instance 16))
    )
  )
  (type (;14;) (func (result u32)))
  (alias core export 7 "docs:guest/runner@0.1.0#run" (core func (;26;)))
  (func (;9;) (type 14) (canon lift (core func 26)))
  (component (;0;)
    (type (;0;) (func (result u32)))
    (import "import-func-run" (func (;0;) (type 0)))
    (type (;1;) (func (result u32)))
    (export (;1;) "run" (func 0) (func (type 1)))
  )
  (instance (;7;) (instantiate 0
      (with "import-func-run" (func 9))
    )
  )
  (export (;8;) "docs:guest/runner@0.1.0" (instance 7))
  (@producers
    (processed-by "wit-component" "0.239.0")
  )
)
