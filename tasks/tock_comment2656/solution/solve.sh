#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `kernel/src/process_standard.rs` (around line 226): This discards the result of `tasks.enqueue` and always increments the work counter, which -- if I understand correctly -- effectively prevent the chip from going to sleep once a task has failed to be enqueued. Fixed in ce9c08498a22fb341c91945797dc7e4a9f59c60a.
REVIEW_EOF
