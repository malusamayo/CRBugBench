#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `meilisearch/src/extractors/payload.rs` (around line 59): Unfortunately, as you can see, we decrease the `limit` we previously stored in the `Payload` struct. You'll probably have to rename the `limit` field into `remaining` and decrement it. But also introduce a new `limit` field that is never modified and that you'll have to use in the error variant (as you have already done).
REVIEW_EOF
