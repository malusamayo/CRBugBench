#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/react-reconciler/src/ReactFiberCommitWork.old.js` (around line 2440): This doesn't look right to me. `_pendingVisibility` is represents the queued state. `_visibility` represents the current state. So it shouldn't be set until the commit phase.
REVIEW_EOF
