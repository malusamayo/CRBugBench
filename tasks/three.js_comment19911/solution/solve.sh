#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/renderers/WebGLRenderer.js` (around line 908): This change is problematic since `WebGLObjects.update()` should only be called for instance of `Mesh`, `Points`, `Line` and `Sprite`. So objects that have a geometry.

Right now, it's called for all 3D objects in a scene.
REVIEW_EOF
