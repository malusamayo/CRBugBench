#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `rustls/src/error.rs` (around line 768): This needs to be different in some way. Either we need to write a full set of handling for each variant, and then call `Display` on the value contained in the `Other(_)` variant, or we need to pick out the `Other(_)` variant and keep calling `Debug` on the catch-all case.

At the moment it unconditionally recurses forever.
REVIEW_EOF
