#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `scrapy/http/request/form.py` (around line 53): I think previously passing method=None explicitly was supported, but now it is not - could you please fix this small backwards compatibility issue?
REVIEW_EOF
