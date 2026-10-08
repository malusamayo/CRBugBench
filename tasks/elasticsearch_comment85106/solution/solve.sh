#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `x-pack/plugin/sql/src/main/java/org/elasticsearch/xpack/sql/expression/function/scalar/math/BinaryOptionalMathProcessor.java` (around line 54): the `ROUND` docs state that "The returned numeric data type is the same as the data type of numeric_exp." This property does no longer hold with the fallback to double arithmetic.
REVIEW_EOF
