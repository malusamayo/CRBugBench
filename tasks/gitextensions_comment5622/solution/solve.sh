#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `GitUI/CommandsDialogs/FormBrowse.cs` (around line 1676): Please use `RemoveInvalidRepositoriesAsync` instead.

Deleting each individual repo in current fashion is quite inefficient, as it will be opening and closing the underlying config for each deletion.
It may also introduce racing conditions - multiple threads would attempt to modify the same file. It
REVIEW_EOF
