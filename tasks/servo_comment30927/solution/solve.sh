#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `components/devtools/actors/network_event.rs` (around line 384): This doesn't seem like the right way to calculate the local time. You are creating a `Local` from the start time. You are creating a local time here and subtracting the timestamp of the start time. I think that you should look into `Local::timestamp_opt` in order to create the `Local`. In addition, I think that millisecond accuracy would be a better fit here.
REVIEW_EOF
