#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `flink-runtime/src/main/java/org/apache/flink/runtime/metrics/filter/DefaultMetricFilter.java` (around line 98): This means "numRecordsIn*" does no match "numRecordsIn" but "numRecordsInPerSecond". Is this a common approach for `*`? I know that for globbing `*` means any sequence of characters (incl none). I would replace it by `".*"` (and also above) or consider using `+` instead.
REVIEW_EOF
