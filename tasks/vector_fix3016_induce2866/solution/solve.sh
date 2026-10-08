#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `.meta/sinks/loki.toml.erb`:

This pull request introduces the defect later reported as "Loki crashes during buffer initialization". The
problem a user observed, and its root cause:

It's reproducible with:

```toml
[sources.test]
type = "stdin"

[sinks.loki]
type = "loki"
inputs = ["test"]
endpoint = "http://loki.loki.svc.cluster.local:3100"
healthcheck = false
encoding.codec = "json"
[sinks.loki.labels]
  dummy = "val"
```

Result:

```shell
$ RUST_BACKTRACE=1 cargo run -- -c test.toml
    Finished dev [unoptimized + debuginfo] target(s) in 0.25s
     Running `target/debug/vector -c test.toml`
Jul 10 01:53:25.814  INFO vector: Log level "info" is enabled.
Jul 10 01:53:25.815  INFO vector: Loading configs. path=["test.toml"]
Jul 10 01:53:25.828  INFO vector: Vector is starting. version="0.10.0" git_version="v0.9.0-306-gcaa68d8" released="Thu, 09 Jul 2020 22:50:15 +0000" arch="x86_64"
thread 'main' panicked at 'capacity overflow', src/liballoc/raw_vec.rs:622:5
stack backtrace:
Jul 10 01:53:25.829  INFO vector::sources::stdin: Capturing STDIN.
   0: backtrace::backtrace::libunwind::trace
             at /cargo/registry/src/github.com-1ecc6299db9ec823/backtrace-0.3.46/src/backtrace/libunwind.rs:86
   1: backtrace::backtrace::trace_unsynchronized
             at /cargo/registry/src/github.com-1ecc6299db9ec823/backtrace-0.3.46/src/backtrace/mod.rs:66
   2: std::sys_common::backtrace::_print_fmt
             at src/libstd/sys_common/backtrace.rs:78
   3: <std::sys_common::backtrace::_print::DisplayBacktrace as core::fmt::Display>::fmt
             at src/libstd/sys_common/backtrace.rs:59
   4: core::fmt::write
             at src/libcore/fmt/mod.rs:1069
   5: std::io::Write::write_fmt
             at src/libstd/io/mod.rs:1504
   6: std::sys_common::backtrace::_print
             at src/libstd/sys_common/backtrace.rs:62
   7: std::sys_common::backtrace::print
             at src/libstd/sys_common/backtrace.rs:49
   8: std::panicking::default_hook::{{closure}}
             at src/libstd/panicking.rs:198
   9: std::panicking::default_hook
             at src/libstd/panicking.rs:218
  10: std::panicking::rust_panic_with_hook
             at src/libstd/panicking.rs:511
  11: rust_begin_unwind
             at src/libstd/panicking.rs:419
  12: core::panicking::panic_fmt
             at src/libcore/panicking.rs:111
  13: core::panicking::panic
             at src/libcore/panicking.rs:54
  14: alloc::raw_vec::capacity_overflow
             at src/liballoc/raw_vec.rs:622
  15: alloc::raw_vec::RawVec<T,A>::allocate_in::{{closure}}
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/liballoc/raw_vec.rs:149
  16: core::result::Result<T,E>::unwrap_or_else
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/libcore/result.rs:853
  17: alloc::raw_vec::RawVec<T,A>::allocate_in
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/liballoc/raw_vec.rs:149
  18: alloc::raw_vec::RawVec<T,A>::with_capacity_in
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/liballoc/raw_vec.rs:135
  19: alloc::raw_vec::RawVec<T>::with_capacity
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/liballoc/raw_vec.rs:92
  20: alloc::vec::Vec<T>::with_capacity
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/liballoc/vec.rs:358
  21: vector::sinks::util::buffer::vec::VecBuffer<T>::new_with_max
             at src/sinks/util/buffer/vec.rs:15
  22: vector::sinks::util::buffer::vec::VecBuffer<T>::new
             at src/sinks/util/buffer/vec.rs:11
  23: <vector::sinks::loki::LokiConfig as vector::topology::config::SinkConfig>::build
             at src/sinks/loki.rs:93
  24: vector::topology::builder::build_pieces
             at src/topology/builder.rs:224
  25: vector::topology::builder::check_build
             at src/topology/builder.rs:30
  26: vector::topology::validate
             at src/topology/mod.rs:89
  27: vector::main::{{closure}}
             at src/main.rs:126
  28: <core::future::from_generator::GenFuture<T> as core::future::future::Future>::poll
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/libcore/future/mod.rs:66
  29: <futures_util::future::future::map::Map<Fut,F> as core::future::future::Future>::poll
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/future/future/map.rs:67
  30: <futures_util::future::future::Map<Fut,F> as core::future::future::Future>::poll
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/lib.rs:107
  31: <futures_util::future::future::UnitError<Fut> as core::future::future::Future>::poll
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/lib.rs:107
  32: <core::pin::Pin<P> as core::future::future::Future>::poll
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/libcore/future/future.rs:118
  33: <F as futures_core::future::TryFuture>::try_poll
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-core-0.3.5/src/future.rs:83
  34: <futures_util::compat::compat03as01::Compat<Fut> as futures::future::Future>::poll::{{closure}}
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/compat/compat03as01.rs:121
  35: futures_util::compat::compat03as01::with_context
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/compat/compat03as01.rs:223
  36: <futures_util::compat::compat03as01::Compat<Fut> as futures::future::Future>::poll
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/compat/compat03as01.rs:121
  37: core::ops::function::FnOnce::call_once
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/libcore/ops/function.rs:232
  38: futures::task_impl::Spawn<T>::enter::{{closure}}
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-0.1.29/src/task_impl/mod.rs:399
  39: futures::task_impl::std::set
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-0.1.29/src/task_impl/std/mod.rs:83
  40: futures::task_impl::Spawn<T>::enter
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-0.1.29/src/task_impl/mod.rs:399
  41: futures::task_impl::Spawn<T>::poll_fn_notify
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-0.1.29/src/task_impl/mod.rs:291
  42: futures_util::compat::compat01as03::Compat01As03<T>::in_notify
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/compat/compat01as03.rs:42
  43: <futures_util::compat::compat01as03::Compat01As03<Fut> as core::future::future::Future>::poll
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/futures-util-0.3.5/src/compat/compat01as03.rs:162
  44: tokio_compat::runtime::idle::Track::with::{{closure}}
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/tokio-compat-0.1.5/src/runtime/idle.rs:65
  45: <core::future::from_generator::GenFuture<T> as core::future::future::Future>::poll
             at /home/mozgiii/.rustup/toolchains/1.44.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/libcore/future/mod.rs:66
  46: tokio::runtime::enter::Enter::block_on::{{closure}}
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/tokio-0.2.21/src/runtime/enter.rs:163
  47: tokio::coop::with_budget::{{closure}}
             at /home/mozgiii/.cargo/registry/src/github.com-1ecc6299db9ec823/tokio-0.2.21/src/coop.rs:127
  48: std

This same root cause must be fixed before merging.
REVIEW_EOF
