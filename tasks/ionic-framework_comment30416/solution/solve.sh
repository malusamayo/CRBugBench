#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/components/datetime/datetime.ionic.scss` (around line 182): I don't think this is the right approach. This is the desired height in the figma, removing it will make it no longer align with the designs. You may have to try something else to resolve this one, or get a designer to agree with this change.
REVIEW_EOF
