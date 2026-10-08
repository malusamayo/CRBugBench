#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/main/java/io/reactivex/rxjava3/internal/operators/flowable/FlowableThrottleFirstTimed.java` (around line 128): This will hang the sequence because the error is swallowed. Also there is no cleanup of the worker.
REVIEW_EOF
