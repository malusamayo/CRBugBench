#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tabby-core/src/services/commands.service.ts` (around line 112): doesn't this make it impossible to know whether a profile was selected or not on the caller side?

2. In `tabby-core/src/services/profiles.service.ts` (around line 326): same (swallows modal dismissal)
REVIEW_EOF
