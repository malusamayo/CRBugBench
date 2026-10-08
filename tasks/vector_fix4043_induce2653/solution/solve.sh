#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/sources/kubernetes_logs/mod.rs`:

This pull request introduces the defect later reported as "`kubernetes_logs` source should have `start_at_beginning` set to `false` internally". The
problem a user observed, and its root cause:

In the internal file source use, we set `start_at_beginning` to `true`. This essentially disables the checkpointing mechanism and makes old logs reappear and processed multiple times.

This same root cause must be fixed before merging.
REVIEW_EOF
