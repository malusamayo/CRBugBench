#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uucore/src/lib/mods/error.rs`:

This pull request introduces the defect later reported as "Many utils: command subcommand --arg > /dev/full panics". The
problem a user observed, and its root cause:

```
cat --version > /dev/full

thread 'main' (13171) panicked at src/uucore/src/lib/mods/error.rs:751:28:
called `Result::unwrap()` on an `Err` value: Os { code: 28, kind: StorageFull, message: "No space left on device" }
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

This same root cause must be fixed before merging.
REVIEW_EOF
