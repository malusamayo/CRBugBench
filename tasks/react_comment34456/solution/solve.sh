#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `scripts/ci/download_devtools_regression_build.js` (around line 28): I don't get it: why are we pushing a version to the packages here?

Isn't it will try to install packages like this:
```
npm install --prefix ... react-dom@x, react@x, react-test-renderer@x 16.3.0@x
```

where x is a `version`?
REVIEW_EOF
