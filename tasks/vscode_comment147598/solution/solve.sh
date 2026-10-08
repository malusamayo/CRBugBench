#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/vs/workbench/contrib/debug/browser/breakpointEditorContribution.ts` (around line 283): This should also work for breakpoints with conditions and logpoints, in the block above.
REVIEW_EOF
