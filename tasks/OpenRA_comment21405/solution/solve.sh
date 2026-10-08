#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `OpenRA.Mods.Common/Widgets/ViewportControllerWidget.cs` (around line 199): The player should still be able to scroll when the game is paused. That's a separate issue #18464
REVIEW_EOF
