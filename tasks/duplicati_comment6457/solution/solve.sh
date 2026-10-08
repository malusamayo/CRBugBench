#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `Tools/RemoteSynchronization/LightWeightBackendManager.cs` (around line 130): I don't think this is the right place to check for retries, because it sticks with the backendmanager. I would instead have the counter in the `RetryWithDelay` method so consecutive failures of the same operation brings the house down, but as soon as the operation has completed the counter is reset for the next operation.

The general idea is that as long as there is progress we ignore past problems.
REVIEW_EOF
