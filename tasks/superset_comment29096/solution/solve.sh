#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `superset-frontend/src/features/alerts/AlertReportModal.tsx` (around line 812): What happens if this fails? Should we catch it and display an error message?
REVIEW_EOF
