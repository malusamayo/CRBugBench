#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/hoppscotch-sh-admin/src/components/settings/ServerRestart.vue` (around line 101): We'll have to return early after emitting the event. Currently, the control flow will proceed with the timer resulting in a page reload after `30s`.
REVIEW_EOF
