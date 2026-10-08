#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/EFCore/Internal/ConcurrencyDetector.cs` (around line 72): Also null-out `_threadId` as there is a race condition when a new thread enters critical section, then the old thread enters the critical section and the `_threadId` hasn't been updated yet so no exception would be thrown.
REVIEW_EOF
