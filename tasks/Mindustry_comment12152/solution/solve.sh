#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/mindustry/entities/effect/NoiseEffect.java` (around line 24): This is run at constructor time, which means that reassigning noisePath doesn't do anything. This may also cause issues on servers. How about `if(tex == null) tex = Core.assets.getOrNull(noisePath, Texture.class);` in render() instead?
REVIEW_EOF
