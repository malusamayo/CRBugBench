#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `e2e/benchmarks/local-benchmark/index.html` (around line 107): Should be profileTimes. I don't think we need to get parameters from url twice. Please clean up this part of code.
REVIEW_EOF
