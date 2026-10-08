#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/renderer/renderElement.ts` (around line 674): `prevElementWithCanvas.boundTextElementVersion !== boundTextElementVersion` returns true in most cases due to comparing `undefined` with `null`, making the canvas regenerate every time.
REVIEW_EOF
