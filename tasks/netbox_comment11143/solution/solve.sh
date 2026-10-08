#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `netbox/netbox/tables/columns.py` (around line 57): For `value()`, we want to return the raw ISO-standard date regardless of how the UI display is configured. Instead, this should be applied to the column's `render()` method.
REVIEW_EOF
