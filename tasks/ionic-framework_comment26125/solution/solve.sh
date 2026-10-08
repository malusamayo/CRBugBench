#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/components/datetime/utils/manipulation.ts` (around line 390): Playing around with this made me notice something. Say you have a datetime with a `min` of 5/1 at 8AM. You select a value of 5/3 at 4:30AM. You then click on 5/1. With the current logic, because the hour and minute are handled separately, the time is auto-adjusted to 8:30AM.

This feels strange to me; from a user perspective, I would expect the time to go to the min (8AM), since that's the closest possible time to my selection. Maybe the times should be compared as a whole instead? (This would also apply to the `max` logic below.)
REVIEW_EOF
