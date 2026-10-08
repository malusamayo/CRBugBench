#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/components/header/header.tsx` (around line 66): `ion-tab` is not a component thats available, so `this.el.closest('ion-tab')` will always return `null` here.
REVIEW_EOF
