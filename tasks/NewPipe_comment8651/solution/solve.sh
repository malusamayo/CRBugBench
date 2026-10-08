#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `app/src/main/java/org/schabi/newpipe/player/ui/PopupPlayerUi.java` (around line 254): Shouldn't it be 
```suggestion
        popupLayoutParams.x = MathUtils.clamp(popupLayoutParams.x, 0, screenWidth - popupLayoutParams.width);
        popupLayoutParams.y = MathUtils.clamp(popupLayoutParams.y, 0, screenHeight - popupLayoutParams.height);
```
REVIEW_EOF
