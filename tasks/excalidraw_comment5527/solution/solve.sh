#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/element/linearElementEditor.ts` (around line 179): not sure what the goal here is exactly with filtering out previous selected points? EIther way, this will fail when you click on the same point twice. And since array access isn't type-safe (until we switch the TS compiler flag to make it safe), this will break.
REVIEW_EOF
