#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `scrapy/extensions/corestats.py` (around line 24): I don't think moving from UTC time to a local time is a good idea, due to the following:
- this is a backwards incompatible change, we can't just change this
- time zone on the server might be different from the user time zone anyway, so using UTC seems less confusing to me - this is just my opinion though
REVIEW_EOF
