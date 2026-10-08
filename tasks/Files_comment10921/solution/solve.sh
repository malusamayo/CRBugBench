#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Files.App/Helpers/ContextFlyoutItemHelper.cs` (around line 998): I don't think we want this one, this is about items contained in the recycle bin not the recycle bin folder (an exe inside the bin should not be pinnable to start). Same for the one above.
REVIEW_EOF
