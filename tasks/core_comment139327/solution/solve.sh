#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `homeassistant/components/qbus/climate.py` (around line 168): Usually the `OFF` mode means that even if the temperature drops, it would not start heating. If it is on a `HEAT` mode but not currently heating, then the ACTION should be `IDLE`, but mode should still be `HEAT`.

if we don't have a way to set mode, maybe we should set it to HEAT only, and keep it fixed.
REVIEW_EOF
