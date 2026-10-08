#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/polars-plan/src/client/check.rs` (around line 48): This isn't sufficient. `AnonymousFunction` isn't completely serde. I think we should extend the `dyn GetOutput` with a `try_serialize`, like we did for the for input function `dyn SeriesUdf` .


After that we can implement `serde` similarly. The `try_serialize` ensures we still fail client side if we cannot serialize the udf.
REVIEW_EOF
