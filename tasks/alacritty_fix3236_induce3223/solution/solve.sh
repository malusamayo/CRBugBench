#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty_terminal/src/selection.rs`:

This pull request introduces the defect later reported as "Crash with OOB after c84cd0fdb0335fa873f397e95a0a728be0fe15f5". The
problem a user observed, and its root cause:

basically you can try to repro it by staring selection and moving a cursor clockwise outside of the window, it should crash at some point. More investigations showing that it's related to First cell in a row, however I don't have a formal prove of it right now.

```
thread 'main' panicked at 'index out of bounds: the len is 149 but the index is 149', /rustc/73528e339aae0f17a15ffa49a8ac608f50c6cf14/src/libcore/slice/mod.rs:2796:10
stack backtrace:
   0:     0x55a2a50aff24 - backtrace::backtrace::libunwind::trace::h65597d255cb1398b
                               at /cargo/registry/src/github.com-1ecc6299db9ec823/backtrace-0.3.40/src/backtrace/libunwind.rs:88
   1:     0x55a2a50aff24 - backtrace::backtrace::trace_unsynchronized::hd4f479d7150ec4a0
                               at /cargo/registry/src/github.com-1ecc6299db9ec823/backtrace-0.3.40/src/backtrace/mod.rs:66
   2:     0x55a2a50aff24 - std::sys_common::backtrace::_print_fmt::h015072984a2b172c
                               at src/libstd/sys_common/backtrace.rs:77
   3:     0x55a2a50aff24 - <std::sys_common::backtrace::_print::DisplayBacktrace as core::fmt::Display>::fmt::h6df05d3335f32194
                               at src/libstd/sys_common/backtrace.rs:61
   4:     0x55a2a50d7b1c - core::fmt::write::h1f444f4312eb6c27
                               at src/libcore/fmt/mod.rs:1028
   5:     0x55a2a50acb37 - std::io::Write::write_fmt::h8d147888220078ef
                               at src/libstd/io/mod.rs:1412
   6:     0x55a2a50b25de - std::sys_common::backtrace::_print::h8a6df0fa81d6af62
                               at src/libstd/sys_common/backtrace.rs:65
   7:     0x55a2a50b25de - std::sys_common::backtrace::print::h6f05b4733407e509
                               at src/libstd/sys_common/backtrace.rs:50
   8:     0x55a2a50b25de - std::panicking::default_hook::{{closure}}::h0d0a23bd02315dd8
                               at src/libstd/panicking.rs:188
   9:     0x55a2a50b22d1 - std::panicking::default_hook::h8d15a9aecb4efac6
                               at src/libstd/panicking.rs:205
  10:     0x55a2a50b2cdb - std::panicking::rust_panic_with_hook::hbe174577402a475d
                               at src/libstd/panicking.rs:464
  11:     0x55a2a50b287e - std::panicking::continue_panic_fmt::h4d855dad868accf3
                               at src/libstd/panicking.rs:373
  12:     0x55a2a50b2766 - rust_begin_unwind
                               at src/libstd/panicking.rs:302
  13:     0x55a2a50d3d5e - core::panicking::panic_fmt::hdeb7979ab6591473
                               at src/libcore/panicking.rs:139
  14:     0x55a2a50d3d25 - core::panicking::panic_bounds_check::h48b559825fef6c92
                               at src/libcore/panicking.rs:96
  15:     0x55a2a4a80c87 - <usize as core::slice::SliceIndex<[T]>>::index::hc410d46bc70d82fb
                               at /rustc/73528e339aae0f17a15ffa49a8ac608f50c6cf14/src/libcore/slice/mod.rs:2796
  16:     0x55a2a4a7d998 - core::slice::<impl core::ops::index::Index<I> for [T]>::index::h5f7b1ea8808eca8e
                               at /rustc/73528e339aae0f17a15ffa49a8ac608f50c6cf14/src/libcore/slice/mod.rs:2647
  17:     0x55a2a4a744cb - <alloc::vec::Vec<T> as core::ops::index::Index<I>>::index::he3db410d2d651c7e
                               at /rustc/73528e339aae0f17a15ffa49a8ac608f50c6cf14/src/liballoc/vec.rs:1861
  18:     0x55a2a4a6d211 - <alacritty_terminal::grid::row::Row<T> as core::ops::index::Index<alacritty_terminal::index::Column>>::index::h381b58882d66ac85
                               at alacritty_terminal/src/grid/row.rs:184
  19:     0x55a2a4274d32 - alacritty_terminal::selection::Selection::range_expand_fullwidth::{{closure}}::ha6987a8f8a3ed1e6
                               at /home/kchibisov/Developer/rust/forks/alacritty-workspace/alacritty/alacritty_terminal/src/selection.rs:216
  20:     0x55a2a4274a64 - alacritty_terminal::selection::Selection::range_expand_fullwidth::h5c5d3f9b07d428f9
                               at /home/kchibisov/Developer/rust/forks/alacritty-workspace/alacritty/alacritty_terminal/src/selection.rs:246
  21:     0x55a2a4275514 - alacritty_terminal::selection::Selection::to_range::{{closure}}::h291332495c41cda2
                               at /home/kchibisov/Developer/rust/forks/alacritty-workspace/alacritty/alacritty_terminal/src/selection.rs:206
  22:     0x55a2a444652a - core::option::Option<T>::map::hdf63d703ebe4b386
                               at /rustc/73528e339aae0f17a15ffa49a8ac608f50c6cf14/src/libcore/option.rs:447
  23:     0x55a2a42754b4 - alacritty_terminal::selection::Selection::to_range::h36810d4072756d78
                               at /home/kchibisov/Developer/rust/forks/alacritty-workspace/alacritty/alacritty_terminal/src/selection.rs:206
  24:     0x55a2a4383607 - alacritty_terminal::term::Term<T>::renderable_cells::{{closure}}::h84ceaea1b35b8546
                               at /home/kchibisov/Developer/rust/forks/alacritty-workspace/alacritty/alacritty_terminal/src/term/mod.rs:1051
  25:     0x55a2a4450055 - core::option::Option<T>::and_then::hd3c811c5e7087271
                               at /rustc/73528e339aae0f17a15ffa49a8ac608f50c6cf14/src/libcore/option.rs:655
  26:     0x55a2a43834cb - alacritty_terminal::term::Term<T>::renderable_cells::hfabbfc31a3a4f024
                               at /home/kchibisov/Developer/rust/forks/alacritty-workspace/alacritty/alacritty_terminal/src/term/mod.rs:1051
  27:     0x55a2a42b4023 - alacritty::display::Display::draw::habf7b4740bfd4a04
                               at alacritty/src/display.rs:359
  28:     0x55a2a4558c2a - alacritty::event::Processor<N>::run::{{closure}}::hc2d5361466aa31bd
                               at alacritty/src/event.rs:438
  29:     0x55a2a429dbad - winit::platform_impl::platform::sticky_exit_callback::hc952b1832dc1eb5c
                               at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.20.0/src/platform_impl/linux/mod.rs:697
  30:     0x55a2a42a0d21 - winit::platform_impl::platform::wayland::event_loop::EventLoop<T>::run_return::h09f76b597a394ba2
                               at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.20.0/src/platform_impl/linux/wayland/event_loop.rs:527
  31:     0x55a2a429cb6d - winit::platform_impl::platform::EventLoop<T>::run_return::he6da89e5940f3596
                               at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.20.0/src/platform_impl/linux/mod.rs:633
  32:     0x55a2a44d76d5 - <winit::event_loop::EventLoop<T> as winit::platform::desktop::EventLoopExtDesktop>::run_return::ha237bfaedfded6ad
                               at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.20.0/src/platform/desktop.rs:51
  33:     0x55a2a4557fdb - alacritty::event::Processor<N>::run::h9b908826e9e7d009
                               at alacritty/src/event.rs:349
  34:     0x55a2a449d451 - alacritty::run::h33a1039697e27b33
                               at alacritty/src/main.rs:204
  35:     0x55a2a449bf3b - alacritty::main::h9cff650252b9a664
                               at alacritty/src/main.rs:112
  36:     0x55a2a453aa30 - std::rt::lang_start::{{closure}}::h0d1eacd6e899f96c
                               at /rustc/73528e339aae0f17a15ffa49a8ac608f50c6cf14/src/libstd/rt.rs:61
  37:     0x55a2a50b2703 - std::rt::lang_start_internal::{{closure}}::h6ea535ec5c50fc3e
                               at src/libstd/rt.rs:48
  38:     0x55a2a50b2703 - std::panicking::try::do_call::h631c6408dfccc6f5
                               at src/libstd/panicking.rs:287
  39:     0x55a2a50bb60a - __rust_maybe_catch_panic
                               at src/libpanic_unwind/lib.rs:78
  40:     0x55a2a50b31bd - std::panicking::try::hab539b2d1255d635
                               at src/l

This same root cause must be fixed before merging.
REVIEW_EOF
