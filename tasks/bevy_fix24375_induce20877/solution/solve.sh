#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_ptr/src/lib.rs`:

This pull request introduces the defect later reported as "`bevy_ptr::MovingPtr::assign_to` can cause double drops / use after free". The
problem a user observed, and its root cause:

## Bevy version and features

`bevy_ptr@0.18.1`

## Info

`bevy_ptr::MovingPtr::assign_to` doesn't continue to assign even if the drop glue panic like `*dst = self.read()` would. Thus if the panic is caught, you can access the partially dropped `dst`. 

Not of immediate concern because it doesn't seem like `bevy_ptr::MovingPtr::assign_to` is actually used anywhere

## repo code

```rust
use bevy_ptr::move_as_ptr;
use std::{
    panic::{AssertUnwindSafe, catch_unwind, resume_unwind},
    sync::atomic::{AtomicBool, Ordering},
};

#[derive(Debug)]
struct PanicOnDropOnce;

impl Drop for PanicOnDropOnce {
    fn drop(&mut self) {
        static DID: AtomicBool = AtomicBool::new(false);
        if !DID.fetch_or(true, Ordering::Relaxed) {
            // using resume unwind here to avoid calling panic hook to keep stderr clean
            resume_unwind(Box::new("intentional"))
        }
    }
}

fn main() {
    let mut dst = (String::from("dst"), PanicOnDropOnce);

    catch_unwind(AssertUnwindSafe(|| {
        let moving_ptr = (String::from("moving"), PanicOnDropOnce);
        move_as_ptr!(moving_ptr);

        moving_ptr.assign_to(&mut dst);
    }))
    .expect_err("Should have unwound");

    dbg!(dst);
}
```
## expected

```
[src\main.rs:31:5] dst = (
    "moving",
    PanicOnDropOnce,
)
```

## actual

UB (exact output varies run to run)


## Additional information

<details>
<summary>Miri output</summary>

```
[src\main.rs:31:5] dst = (
error: Undefined Behavior: pointer not dereferenceable: alloc259 has been freed, so this pointer is dangling
    --> C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\alloc\src\vec\mod.rs:1833:13
     |
1833 |             &*core::intrinsics::aggregate_raw_ptr::<*const [T], _, _>(self.as_ptr(), self.len)
     |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Undefined Behavior occurred here
     |
     = help: this indicates a bug in the program: it performed an invalid operation, and caused Undefined Behavior
     = help: see https://doc.rust-lang.org/nightly/reference/behavior-considered-undefined.html for further information
help: alloc259 was allocated here:
    --> src\main.rs:21:20
     |
  21 |     let mut dst = (String::from("dst"), PanicOnDropOnce);
     |                    ^^^^^^^^^^^^^^^^^^^
help: alloc259 was deallocated here:
    --> src\main.rs:27:9
     |
  27 |         moving_ptr.assign_to(&mut dst);
     |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     = note: stack backtrace:
             0: std::vec::Vec::<u8>::as_slice
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\alloc\src\vec\mod.rs:1833:13: 1833:95
             1: std::string::String::as_str
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\alloc\src\string.rs:1055:43: 1055:62
             2: <std::string::String as std::ops::Deref>::deref
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\alloc\src\string.rs:2823:9: 2823:22
             3: <std::string::String as std::fmt::Debug>::fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\alloc\src\string.rs:2720:26: 2720:32
             4: <&std::string::String as std::fmt::Debug>::fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\mod.rs:2866:62: 2866:82
             5: std::fmt::DebugTuple::<'_, '_>::field::{closure#0}
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\builders.rs:330:29: 330:41
             6: std::fmt::DebugTuple::<'_, '_>::field_with::<{closure@std::fmt::DebugTuple<'_, '_>::field::{closure#0}}>::{closure#0}
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\builders.rs:350:17: 350:39
             7: std::result::Result::<(), std::fmt::Error>::and_then::<(), {closure@std::fmt::DebugTuple<'_, '_>::field_with<{closure@std::fmt::DebugTuple<'_, '_>::field::{closure#0}}>::{closure#0}}>
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\result.rs:1493:22: 1493:27
             8: std::fmt::DebugTuple::<'_, '_>::field_with::<{closure@std::fmt::DebugTuple<'_, '_>::field::{closure#0}}>
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\builders.rs:342:23: 357:11
             9: std::fmt::DebugTuple::<'_, '_>::field
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\builders.rs:330:9: 330:42
             10: <(std::string::String, PanicOnDropOnce) as std::fmt::Debug>::fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\mod.rs:3087:25: 3087:46
             11: <&(std::string::String, PanicOnDropOnce) as std::fmt::Debug>::fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\mod.rs:2866:62: 2866:82
             12: <&dyn std::fmt::Debug as std::fmt::Debug>::fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\mod.rs:2866:62: 2866:82
             13: core::fmt::rt::Argument::<'_>::fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\rt.rs:152:76: 152:95
             14: std::fmt::write
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\fmt\mod.rs:1735:17: 1735:83
             15: std::io::default_write_fmt::<std::io::StderrLock<'_>>
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\io\mod.rs:639:11: 639:40
             16: <std::io::StderrLock<'_> as std::io::Write>::write_fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\io\mod.rs:1994:13: 1994:42
             17: <&std::io::Stderr as std::io::Write>::write_fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\io\stdio.rs:1066:9: 1066:36
             18: <std::io::Stderr as std::io::Write>::write_fmt
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\io\stdio.rs:1040:9: 1040:33
             19: std::io::stdio::print_to::<std::io::Stderr>
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\io\stdio.rs:1164:21: 1164:47
             20: std::io::_eprint
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\io\stdio.rs:1286:5: 1286:37
             21: main
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\macros.rs:180:9: 180:60
             22: <fn() as std::ops::FnOnce<()>>::call_once - shim(fn())
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\core\src\ops\function.rs:250:5: 250:71
             23: std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
                 at C:\Users\kylee\.rustup\toolchains\nightly-x86_64-pc-windows-msvc\lib\rustlib\src\rust\library\std\src\sys\backtrace.rs:166:18: 166:21
             24: std::rt::lang_start::<()>::{closure#0}
                 at C:\Users\kylee\.rustup\toolchains\nig

This same root cause must be fixed before merging.
REVIEW_EOF
