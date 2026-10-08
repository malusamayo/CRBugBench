#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `homeassistant/components/statistics/sensor.py` (around line 185): This can't be right, `dict.get` may return `None` and we don't want to stringify that.

In this case, `CONF_ENTITY_ID` is not optional though, so we should do `[]`, not `.get()`

Same comment for the other constructor parameters.
REVIEW_EOF
