#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/utils/animation/test/animation.spec.ts` (around line 8): Is `describe.only` intentional here? I'm less familiar with this function, but after reading the docs, this would prevent other test suites outside of the describe from executing.
REVIEW_EOF
