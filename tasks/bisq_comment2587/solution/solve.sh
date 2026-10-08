#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/main/java/bisq/core/dao/governance/voteresult/VoteResultService.java` (around line 392): This needs to be an `else if`, `entry.getValue()` is checked in the previous `if`but code execution continues.
REVIEW_EOF
