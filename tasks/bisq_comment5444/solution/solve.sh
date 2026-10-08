#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/main/java/bisq/core/dao/monitoring/BlindVoteStateMonitoringService.java` (around line 261): I think it would be better to reverse the order of the filters to filter out null txid before using it.

Otherwise it looks correct.
REVIEW_EOF
