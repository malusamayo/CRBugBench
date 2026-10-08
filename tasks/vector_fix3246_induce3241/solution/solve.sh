#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/internal_events/mod.rs`:

This pull request introduces the defect later reported as "Windows compilation is failing". The
problem a user observed, and its root cause:

This look looks like an easy fix:

https://github.com/timberio/vector/runs/921358580

```
 error: unused import: `self::journald::*`
  --> src\internal_events\mod.rs:34:16
   |
34 | pub(crate) use self::journald::*;
   |                ^^^^^^^^^^^^^^^^^
   |
   = note: `-D unused-imports` implied by `-D warnings`

error: unused import: `self::journald::*`
  --> src\internal_events\mod.rs:34:16
   |
34 | pub(crate) use self::journald::*;
   |                ^^^^^^^^^^^^^^^^^
   |
   = note: `-D unused-imports` implied by `-D warnings`

error: aborting due to previous error

error: could not compile `vector`.
```

This same root cause must be fixed before merging.
REVIEW_EOF
