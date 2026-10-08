#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `.github/workflows/stale-issues.yml` (around line 18): Hey @arpitjain099, for this action cursor bot is right - the action doesn't need to read the contents, it needs to be able to read and write the issues and pull-requests objects and additionally for the internal action operations, it also needs to have `actions:write`.
REVIEW_EOF
