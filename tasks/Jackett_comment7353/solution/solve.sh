#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Jackett.Common/Indexers/Abstract/AvistazTracker.cs` (around line 124): `:eq` is not working. => https://github.com/AngleSharp/AngleSharp/issues/183
You can use `nth-of-type(4)` instead. Notice the index + 1
Apply to all occurrences in other PRs too.
REVIEW_EOF
