#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/desktop-client/src/components/spreadsheet/format.ts` (around line 56): Since `getNumberFormat` returns an object literal, this will return a different value on every render and cause excessive rerendering. I would recommend fetching each of the state values separately, then using `useMemo` to construct the number format.
REVIEW_EOF
