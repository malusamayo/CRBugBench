#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tabby-settings/src/components/settingsTab.component.pug` (around line 103): should exclude Linux as well since it's excluded in the backend

also, the setting should be in the Window settings tab
REVIEW_EOF
