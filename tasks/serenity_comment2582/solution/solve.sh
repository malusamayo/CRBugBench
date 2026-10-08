#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/model/channel/message.rs` (around line 810): I think the conditionals should be swapped in order if you're nesting them like this. Since, we don't care about permissions if we're the author. Also, if `user_has_perms_cache` returns an error that isn't `InvalidPermissions`, we should propagate it up as normal.
REVIEW_EOF
