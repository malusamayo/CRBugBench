#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/better-auth/src/plugins/api-key/routes/create-api-key.ts` (around line 410): I think this will ignore `opts.rateLimit.enabled` when it's set to false
REVIEW_EOF
