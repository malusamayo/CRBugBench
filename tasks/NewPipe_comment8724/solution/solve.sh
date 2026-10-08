#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `app/src/main/java/org/schabi/newpipe/player/notification/NotificationConstants.java` (around line 183): The array needs to be mutable, as it will be mutated in `NotificationActionsPreference`.
```suggestion
                return new ArrayList<>(SLOT_COMPACT_DEFAULTS);
```

Or remove all `new ArrayList<>` from this function and move them to `NotificationActionsPreference`
REVIEW_EOF
