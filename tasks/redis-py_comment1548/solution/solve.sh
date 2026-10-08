#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `redis/commands.py` (around line 1656): Maxlen and minid are mutually exclusive. This would allow us to specify both in the command.
https://redis.io/commands/XADD
REVIEW_EOF
