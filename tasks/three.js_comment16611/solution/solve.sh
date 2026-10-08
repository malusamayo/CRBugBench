#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `examples/js/loaders/GLTFLoader.js` (around line 2616): Instead of checking `skinWeight.array instanceof Float32Array`, could we check `skinWeight.normalized`? I'm worried the first might break for InterleavedBufferAttributes.
REVIEW_EOF
