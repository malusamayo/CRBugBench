#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/milli/src/update/new/indexer/mod.rs` (around line 540): It seems you are doing the opposite of what the comment is saying. You clear the cellulite database when the geojson support is still there.
REVIEW_EOF
