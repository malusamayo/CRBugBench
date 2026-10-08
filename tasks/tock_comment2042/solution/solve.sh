#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `chips/stm32f4xx/src/fsmc.rs` (around line 149): I don't like this practice of treating an arbitrary memory location as though it is an `FsmcBank`. This could easily lead to memory unsafety if these slots were used. If empty slots are needed in the FSMC array, the array should hold `Option<StaticRef<FsmcBank>>`
REVIEW_EOF
