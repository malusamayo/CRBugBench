#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `chips/stm32u5xx/src/usart.rs` (around line 454): Please read the documentation of this, it should return `BUSY` if trying to abort and `Ok(())` if there is nothing to abort.
REVIEW_EOF
