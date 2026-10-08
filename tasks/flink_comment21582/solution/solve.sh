#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `flink-table/flink-sql-parser/src/main/codegen/data/Parser.tdd` (around line 151): I thinks "JOBS" should also be added to the `nonReservedKeywords`
REVIEW_EOF
