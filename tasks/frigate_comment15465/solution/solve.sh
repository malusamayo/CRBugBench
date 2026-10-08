#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `frigate/events/cleanup.py` (around line 261): Doesn't `.iterator()` always return a single record? So `batch` will never be more than 1 record?
REVIEW_EOF
