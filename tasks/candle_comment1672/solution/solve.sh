#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `candle-core/src/pickle.rs` (around line 762): I think this would only work for tensors that have a "symmetrical" shape. If the shape using the fortran layout is `[d1, d2, d3]`, we should first reshape the tensor that was read assuming C layout to shape `[d3, d2, d1]` and then permute the dimensions.
REVIEW_EOF
