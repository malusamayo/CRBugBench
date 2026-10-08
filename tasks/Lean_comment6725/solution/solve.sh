#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `Common/DataMonitor.cs` (around line 172): Cool! we should take a lock here to make sure we start a single one, after the initial null check, there could be multiple threads fetching files at the same time 👍
REVIEW_EOF
