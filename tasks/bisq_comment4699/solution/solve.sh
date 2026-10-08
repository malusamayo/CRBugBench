#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `desktop/src/main/java/bisq/desktop/main/portfolio/pendingtrades/PendingTradesViewModel.java` (around line 218): I think a check for non null Trade would be good here.
REVIEW_EOF
