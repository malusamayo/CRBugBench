#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `server/src/repositories/asset.repository.ts` (around line 476): Facial recognition shouldn't queue anything that hasn't gone through metadata extraction and thumbnail generation, so there's no reason for this to be a left join.
REVIEW_EOF
