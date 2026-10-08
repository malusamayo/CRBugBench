#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `examples/jsm/loaders/GLTFLoader.js` (around line 2993): What is this `sourceDef.uri.length > 0` check for? And [`sourceDef.uri` is optional (if image data is defined in `sourceDef.bufferView`)](https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html#reference-image) so accessing `sourceDef.uri.length` can cause an exception in that case.
REVIEW_EOF
