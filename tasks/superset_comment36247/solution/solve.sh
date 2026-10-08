#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `superset-frontend/plugins/plugin-chart-ag-grid-table/test/buildQuery.test.ts` (around line 504): Why are we adding a group by when `metrics=[]`? Shouldn't we fix that instead?

If we don't want to change it because we're worried we're going to break something, can we at least have `metrics=null` here, instead of `undefined`? Relying on a variable being `undefined` and having to do extra work to not define it is such a brittle flow...
REVIEW_EOF
