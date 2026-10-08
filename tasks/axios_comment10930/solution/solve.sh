#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `lib/adapters/http.js` (around line 559): The config.socketPath is read directly before the existing own('socketPath') guard. We cannot have that, as it would regress some of our guards against prototype pollution.
REVIEW_EOF
