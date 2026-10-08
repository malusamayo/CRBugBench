#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `components/pixels/lib.rs` (around line 216): This doesn't seem to be equivalent to the initial code since r moves from slot 0 to 2, and b to 2 from 0. Is that expected?

Also, you could move these assignments in the `if a > 0 { ... }` block.
REVIEW_EOF
