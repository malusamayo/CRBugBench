#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `frigate/http.py` (around line 1109): I think it's better to check frame, width, and height for invalid values. We should also update the frontend code to prevent the negative values from being passed in the first place.
REVIEW_EOF
