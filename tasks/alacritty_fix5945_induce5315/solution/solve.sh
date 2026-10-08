#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty/src/event.rs`:

This pull request introduces the defect later reported as "Crash and assert triggered during search.". The
problem a user observed, and its root cause:

While triggering Vi mode or sometimes starting search I've got the following crashes.
```gdb
thread 'main' panicked at 'assertion failed: positive < self.len', alacritty_terminal/src/grid/storage.rs:222:9
stack backtrace:
   0: rust_begin_unwind
   1: core::panicking::panic_fmt
   2: core::panicking::panic
   3: alacritty_terminal::grid::storage::Storage<T>::compute_index
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty_terminal/src/grid/storage.rs:222:9
   4: <alacritty_terminal::grid::storage::Storage<T> as core::ops::index::Index<alacritty_terminal::index::Line>>::index
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty_terminal/src/grid/storage.rs:254:21
   5: <alacritty_terminal::grid::Grid<T> as core::ops::index::Index<alacritty_terminal::index::Line>>::index
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty_terminal/src/grid/mod.rs:448:10
   6: alacritty_terminal::term::search::<impl alacritty_terminal::term::Term<T>>::line_search_right
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty_terminal/src/term/search.rs:428:16
   7: alacritty::display::hint::highlighted_at::{{closure}}::{{closure}}
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/display/hint.rs:265:27
   8: alacritty::config::ui_config::LazyRegex::with_compiled
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/config/ui_config.rs:382:9
   9: alacritty::display::hint::highlighted_at::{{closure}}
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/display/hint.rs:261:9
  10: <core::slice::iter::Iter<T> as core::iter::traits::iterator::Iterator>::find_map
             at /rustc/1.59.0/library/core/src/slice/iter/macros.rs:276:38
  11: alacritty::display::hint::highlighted_at
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/display/hint.rs:250:5
  12: alacritty::display::Display::update_highlighted_hints
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/display/mod.rs:747:13
  13: alacritty::window_context::WindowContext::handle_event
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/window_context.rs:311:27
  14: alacritty::event::Processor::run::{{closure}}
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/event.rs:1301:25
  15: winit::platform_impl::platform::sticky_exit_callback
             at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.26.1/src/platform_impl/linux/mod.rs:753:5
  16: winit::platform_impl::platform::wayland::event_loop::EventLoop<T>::run_return
             at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.26.1/src/platform_impl/linux/wayland/event_loop/mod.rs:406:13
  17: winit::platform_impl::platform::EventLoop<T>::run_return
             at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.26.1/src/platform_impl/linux/mod.rs:662:56
  18: <winit::event_loop::EventLoop<T> as winit::platform::run_return::EventLoopExtRunReturn>::run_return
             at /home/kchibisov/.cargo/registry/src/github.com-1ecc6299db9ec823/winit-0.26.1/src/platform/run_return.rs:56:9
  19: alacritty::event::Processor::run
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/event.rs:1249:9
  20: alacritty::alacritty
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/main.rs:201:5
  21: alacritty::main
             at /home/kchibisov/src/rust/alacritty-workspace/fork/alacritty/src/main.rs:81:17
  22: core::ops::function::FnOnce::call_once
             at /rustc/1.59.0/library/core/src/ops/function.rs:227:5

```

To trigger assert you don't need to resize, I got it just from entering Vi mode.

The following is following stacktrace is why I've started investigating in the first place.

```gdb
0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:49
1  0x00007f192cffc546 in __GI_abort () at abort.c:79
2  0x0000564dbb652e57 in panic_abort::__rust_start_panic::abort ()
3  0x0000564dbb652e46 in __rust_start_panic ()
4  0x0000564dbb71a8f6 in rust_panic ()
5  0x0000564dbb7230f8 in std::panicking::rust_panic_with_hook ()
6  0x0000564dbb722a58 in std::panicking::begin_panic_handler::{{closure}} ()
7  0x0000564dbb7229f6 in std::sys_common::backtrace::__rust_end_short_backtrace ()
8  0x0000564dbb7229b2 in rust_begin_unwind ()
9  0x0000564dbb4928b0 in core::panicking::panic_fmt ()
10 0x0000564dbb492a0c in core::panicking::panic ()
11 0x0000564dbb535d7b in core::option::Option::unwrap<alacritty_terminal::index::Point<usize, alacritty_terminal::index::Column>> () at /rustc/1.59.0/library/core/src/option.rs:729
12 alacritty::display::content::RenderableContent::new<alacritty::event::EventProxy> () at alacritty/src/display/content.rs:66
13 0x0000564dbb5b3075 in alacritty::display::Display::draw<alacritty::event::EventProxy> () at alacritty/src/display/mod.rs:544
14 0x0000564dbb57dafd in alacritty::window_context::WindowContext::handle_event () at alacritty/src/window_context.rs:335
15 0x0000564dbb588244 in alacritty::event::{impl#10}::run::{closure#0} () at alacritty/src/event.rs:1301
16 0x0000564dbb58518a in winit::platform_impl::platform::sticky_exit_callback<alacritty::event::Event, alacritty::event::{impl#10}::run::{closure#0}> () at /home/kchibisov/.cargo/git/checkouts/winit-4b1f5e8d108a5ef0/3c0e397/src/platform_impl/linux/mod.rs:788
17 winit::platform_impl::platform::wayland::event_loop::EventLoop::run_return<alacritty::event::Event, alacritty::event::{impl#10}::run::{closure#0}> () at /home/kchibisov/.cargo/git/checkouts/winit-4b1f5e8d108a5ef0/3c0e397/src/platform_impl/linux/wayland/event_loop/mod.rs:421
18 winit::platform_impl::platform::EventLoop::run_return<alacritty::event::Event, alacritty::event::{impl#10}::run::{closure#0}> () at /home/kchibisov/.cargo/git/checkouts/winit-4b1f5e8d108a5ef0/3c0e397/src/platform_impl/linux/mod.rs:701
19 0x0000564dbb4faf40 in winit::platform::run_return::{impl#0}::run_return<alacritty::event::Event, alacritty::event::{impl#10}::run::{closure#0}> () at /home/kchibisov/.cargo/git/checkouts/winit-4b1f5e8d108a5ef0/3c0e397/src/platform/run_return.rs:61
20 alacritty::event::Processor::run () at alacritty/src/event.rs:1249
21 alacritty::alacritty () at alacritty/src/main.rs:201
22 alacritty::main () at alacritty/src/main.rs:81

```

This same root cause must be fixed before merging.
REVIEW_EOF
