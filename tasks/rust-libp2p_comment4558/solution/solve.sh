#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `protocols/dcutr/src/behaviour_impl.rs` (around line 269): This is not correct I think! :)

`connection_id` should be the direct one.
REVIEW_EOF
