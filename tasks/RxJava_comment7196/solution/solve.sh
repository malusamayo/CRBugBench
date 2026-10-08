#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/main/java/io/reactivex/rxjava3/internal/operators/maybe/MaybeZipArray.java` (around line 105): This should go inside the condition.

2. In `src/main/java/io/reactivex/rxjava3/internal/operators/maybe/MaybeZipArray.java` (around line 121): This should also be in the catch block above, between the `throwIfFatal` and `onError` calls. Similarly, `innerError` should be updated.
REVIEW_EOF
