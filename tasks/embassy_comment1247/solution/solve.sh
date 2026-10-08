#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `embassy-stm32/src/eth/mod.rs` (around line 57): creating a `&mut` to uninitialized data is undefined behavior. You have to do all writes to initialize using raw pointers, only after that you can create the `&mut`.
REVIEW_EOF
