#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/react-reconciler/src/ReactFiberWorkLoop.new.js` (around line 3173): The nearestMountedAncestor is by definition a parent of the thing that threw. So why are we starting by checking one level above that? It seems to me that this would target the wrong ancestor if the thing being deleted is a direct child of the error boundary itself. Your tests doesn't seem to test this case because they all use the `Conditional` wrapper.
REVIEW_EOF
