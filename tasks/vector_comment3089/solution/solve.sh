#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tests/support/mod.rs` (around line 119): Wouldn't this lead to a bug with dropping the token too soon? I suggest adding an explicit `drop` at the end - this might help with letting clippy (and people) know that it must be held on to until the end.
REVIEW_EOF
