#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `ingestion/src/metadata/profiler/metrics/hybrid/histogram.py` (around line 118): @ksirmons we'll need to do `if res_iqr is not None`, otherwise using `if res_iqr` will yield `False` if res_iqr=0.0`
REVIEW_EOF
