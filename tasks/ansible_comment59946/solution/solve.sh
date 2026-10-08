#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `lib/ansible/utils/display.py` (around line 113): shouldn't we keep the previous check also (make it an `and`) to avoid `None` values instead of list or list of empty items?
REVIEW_EOF
