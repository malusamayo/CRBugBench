#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/renderer/renderElement.ts` (around line 128): let's floor it, too. Seems there's a rounding error that often overflows just above the pixel, if we really think that safari limit (whatever we'll end up with) is the true ceiling.
REVIEW_EOF
