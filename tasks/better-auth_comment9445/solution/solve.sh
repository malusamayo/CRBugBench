#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/sso/src/providers.test.ts` (around line 1192): This locks in silently ignoring an `input: false` field supplied by the caller: `source: "client"` later becomes the default `"system"`. The existing additional-fields contract says `input: false` prevents callers from passing a value, so this should reject the request, or the SSO docs need to explicitly document the silent-ignore behavior.
REVIEW_EOF
