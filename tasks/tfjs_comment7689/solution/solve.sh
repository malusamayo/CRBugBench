#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tfjs-backend-wasm/src/cc/sin_cos_workaround.cc` (around line 45): [SinFixedImpl is missing](https://source.cloud.google.com/results/invocations/80cf68bf-f174-42b0-a8d6-d7c31381f6ad/targets/%2F%2Ftfjs-backend-wasm:tfjs-backend-wasm_pkg/log). Is there a missing file in this PR?
REVIEW_EOF
