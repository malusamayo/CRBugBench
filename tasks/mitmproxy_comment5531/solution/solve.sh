#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `mitmproxy/tools/web/app.py` (around line 314): We should return an HTTP error if the filter is not valid (and add a test for this), so let's not just catch the ValueError here. :)
REVIEW_EOF
