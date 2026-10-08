#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/renderers/common/Sampler.js` (around line 73): I understand now why this line fails. When the remove is eventually executed, `onDispose` represents a different listener, not the one that was originally added.
REVIEW_EOF
