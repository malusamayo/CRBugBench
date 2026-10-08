#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `scrapy/__init__.py` (around line 36): I think the reason for this line is to be executed before any Scrapy code, so that the user doesn't see those warnings. It was there before `from twisted import version` was even added.
REVIEW_EOF
