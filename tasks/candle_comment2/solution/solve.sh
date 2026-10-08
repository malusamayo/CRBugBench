#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/cpu_backend.rs` (around line 126): This doesn't handle the strided case, we should probably check `tensor.is_contiguous` in the steps above and error out if not the case (or longer term support strides).
REVIEW_EOF
