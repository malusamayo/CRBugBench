#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/react-reconciler/src/ReactFiberHooks.js` (around line 2446): Does the order of executing the callback and setting the flag matter? Mostly asking because this order is changed now even with the feature flag turned off.
REVIEW_EOF
