#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/polars-stream/src/nodes/rle.rs` (around line 62): This isn't right. If your input transitioned from `Ready` to `Blocked` you might still have `self.last.is_some()` but you won't be ready to send stuff.

You should put this inside the `if recv[0] == PortState::Done` branch.
REVIEW_EOF
