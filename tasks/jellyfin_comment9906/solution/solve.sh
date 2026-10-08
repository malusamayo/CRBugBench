#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `.github/workflows/openapi.yml` (around line 53): ```suggestion
          ANCESTOR_REF=$(git merge-base upstream/${{ github.base_ref }} origin/$HEAD_REF)
```
REVIEW_EOF
