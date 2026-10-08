#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `alacritty_terminal/src/grid/tests.rs` (around line 357): Might be good to add a couple edgecases here, like the initial point being beyond the end of the grid (pretty sure that doesn't fail during creation?).
REVIEW_EOF
