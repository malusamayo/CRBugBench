#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `test/parallel/test-experimental-shared-value-conveyor.js` (around line 9): We have a CI job that checks if tests can be run inside a worker so this would not work in that job: https://ci.nodejs.org/job/node-test-commit-custom-suites-freestyle/30713. This can be replaced with something like:

```suggestion
// Do not use isMainThread so that this test itself can be run inside a Worker.
if (!process.env.HAS_STARTED_WORKER) {
  process.env.HAS_STARTED_WORKER = 1;
```
That we've been doing in other tests.
REVIEW_EOF
