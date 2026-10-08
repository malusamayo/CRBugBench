#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/react-devtools-shared/src/backend/console.js` (around line 23): Hm. This will only match if the very last line has a line number but that's not always true since we sometimes bail out and just print the component name for that line. It's also possible that the root is a built-in component. E.g. `<Suspense>`. Those won't have a line number. It's probably likely that at least one of the frames has one but not guaranteed.
REVIEW_EOF
