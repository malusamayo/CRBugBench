#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `server/src/repositories/album.repository.ts` (around line 168): There's no index on this so not much benefit to the type casts here. The app probably expects the order to be correct with high precision, not just at the date level, so we should maintain the same behavior for this field.
REVIEW_EOF
