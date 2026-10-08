#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/sync-server/src/accounts/openid.js` (around line 147): Tried your code for some openid providers (authelia, google and passwordless.id), this validation breaks `google` and `passwordless`.
If you remove it, it will still work for authelia and the other providers.
REVIEW_EOF
