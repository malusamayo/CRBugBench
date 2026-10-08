#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `candle-core/src/quantized/k_quants.rs` (around line 833): Unwrap doesn't look so good here, if there is an error, we would want to report it properly rather than crashing.
REVIEW_EOF
