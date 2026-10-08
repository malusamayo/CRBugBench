#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/polars-plan/src/dsl/mod.rs` (around line 392): I don't want the the column to be upcasted to string. The arguments should cast lossless to the type of the column we are searching. I have prepared the Flags for that in #20394
REVIEW_EOF
