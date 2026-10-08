#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `openbb_terminal/helper_funcs.py` (around line 1988): You probably want to use total_seconds here instead.  Seconds will only give you a number from 0-60 based on the timestamps.
REVIEW_EOF
