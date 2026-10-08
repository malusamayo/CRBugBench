#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `requests/compat.py` (around line 34): This is backwards incompatible and needs to be reverted

2. In `requests/models.py` (around line 920): We should probably preserve the original exception instance in this as well and proxy attributes down to it. That way folks can find the original exception. I'm not certain `simplejson` and `json` have the same exception attributes with the same meaning
REVIEW_EOF
