#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `modules/openapi-generator/src/main/resources/python/python-experimental/model_utils.mustache` (around line 897): t could also be a ModelComposed subclass.
How about also recursively calling is_type_nullable on t here?
- this also applies in the below anyOf block
REVIEW_EOF
