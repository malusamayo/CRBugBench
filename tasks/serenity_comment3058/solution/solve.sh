#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/client/event_handler.rs` (around line 319): This, sadly, is a breaking change. `FullEvent` does not generate `non_exhaustive` on the enum variants therefore code which destructures `FullEvent::ReactionRemoveAll` will break with this.
REVIEW_EOF
