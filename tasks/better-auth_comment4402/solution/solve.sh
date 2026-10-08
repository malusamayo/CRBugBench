#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/better-auth/src/utils/logger.ts` (around line 97): Please don't read `process` directly. It's not supported in Cloudflare and Vercel Edge runtime.

Please just copy the code I just gave u, and note that we use `getEnvVar` function in our utils
REVIEW_EOF
