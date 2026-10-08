#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `osu.Game/Utils/ModUtils.cs` (around line 42): This hashset is added to, but never queried. (Weird that there's no inspection on this?)

In fact I'm not even sure I understand what the two hashsets are supposed to be tracking...
REVIEW_EOF
