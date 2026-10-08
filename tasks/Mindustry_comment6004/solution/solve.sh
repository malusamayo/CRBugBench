#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/mindustry/ui/dialogs/MapsDialog.java` (around line 184): `mapList.size` can be non-zero, but the displayed list can still be empty. Add a boolean flag that is set to true after the `continue` in the loop, and check for that.
REVIEW_EOF
