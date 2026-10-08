#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/design-system/src/components/N8nButton/Button.vue` (around line 3): Does the destructuring here work properly? Classes is a `string`, not an array, and would normally be turned into an array of characters. I would've expected this to be `['n8n-button', classes]`.
REVIEW_EOF
