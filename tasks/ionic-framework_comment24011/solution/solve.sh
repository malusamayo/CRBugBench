#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/components/footer/footer.tsx` (around line 44): Since this can run multiple times on the same component, does the scroll listener added in `checkCollapsibleFooter` need to be removed first to dedupe? Or is that handled through some other mechanism 🤔 (Also applies to `ion-header`)
REVIEW_EOF
