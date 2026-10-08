#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `osu.Game/Screens/Edit/EditorBeatmap.cs` (around line 237): It looks to me like `PostProcess` ought to be called after processing the batch inserts and deletes, right? Can't seem to find a way to break it, though...
REVIEW_EOF
