#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `lib/adapters/http.js` (around line 967): `delete redirectOptions.headers[header]` only deletes the lower-case key from `sensitiveHeaders.map(...)`. Axios/follow-redirects header objects can preserve user casing, such as `X-API-Key`, so the PR’s primary example will still leak. Delete by iterating `Object.keys(redirectOptions.headers)` and comparing `name.toLowerCase()` against the sensitive set.
REVIEW_EOF
