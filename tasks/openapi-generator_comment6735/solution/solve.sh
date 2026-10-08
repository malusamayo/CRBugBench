#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `modules/openapi-generator/src/main/resources/JavaSpring/apiController.mustache` (around line 39): If `jdk8` *and* `useOptional` are enabled, this will lead to a compile error because of the duplicate import.
REVIEW_EOF
