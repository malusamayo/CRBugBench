#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `redis/client.py` (around line 2747): MAXLEN and MINID are mutually exclusive strategies, should this be an elif? Or raise a DataError, like we do here: https://github.com/andymccurdy/redis-py/blob/master/redis/client.py#L1619 ?
REVIEW_EOF
