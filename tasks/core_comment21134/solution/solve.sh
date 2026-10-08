#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `homeassistant/components/utility_meter/sensor.py` (around line 93): It will check it all because you were first generating a list with all the results, then checking. This will not happen if you remove all uses of `any`, as this is not the right place for an any.
REVIEW_EOF
