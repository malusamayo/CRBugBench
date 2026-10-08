#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uucore/src/lib/features/pipes.rs`:

This pull request introduces the defect later reported as "tests/uucore: build failure". The
problem a user observed, and its root cause:

```sh
cargo +stable build --workspace --tests
```

```log
error[E0425]: cannot find function `pipe` in module `pipes`
  --> src/uucore/src/lib/features/buf_copy.rs:73:54
   |
73 |         let (mut pipe_read, mut pipe_write) = pipes::pipe().unwrap();
   |                                                      ^^^^ not found in `pipes`
   |
note: found an item that was configured out
  --> src/uucore/src/lib/features/pipes.rs:22:8
   |
21 | #[cfg(any(target_os = "linux", target_os = "android"))]
   |          -------------------------------------------- the item is gated here
22 | pub fn pipe() -> std::io::Result<(File, File)> {
   |        ^^^^
help: consider importing one of these functions
   |
26 +     use std::io::pipe;
   |
26 +     use libc::pipe;
   |
26 +     use nix::unistd::pipe;
   |
26 +     use rustix::pipe::pipe;
   |
help: if you import `pipe`, refer to it directly
   |
73 -         let (mut pipe_read, mut pipe_write) = pipes::pipe().unwrap();
73 +         let (mut pipe_read, mut pipe_write) = pipe().unwrap();
   |

error[E0282]: type annotations needed
  --> src/uucore/src/lib/features/buf_copy.rs:76:13
   |
76 |             pipe_write.write_all(data).unwrap();
   |             ^^^^^^^^^^ cannot infer type
```

This same root cause must be fixed before merging.
REVIEW_EOF
