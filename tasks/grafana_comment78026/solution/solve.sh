#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `public/app/features/transformers/timeSeriesTable/timeSeriesTableTransformer.ts` (around line 175): You're correct in that this check should not be `|| null`. But looking at the implementation of `reduceField` it seems to return undefined if the field has no values and [`reducer.emptyInputResult`](https://github.com/grafana/grafana/blob/b607a4e0a2ee2a9b368c6ebcf4021249768b347e/packages/grafana-data/src/transformations/fieldReducer.ts#L90C19-L90C19) is undefined. It could be that the check in reduceField is wrong, and it should really check if emptyInputResult is undefined.

In any case, I think the change here should be to check if the FieldCalc is undefined. Adding a test with a field that has no values would also be a good idea.
REVIEW_EOF
