#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `ingestion/src/metadata/ingestion/source/pipeline/spline/metadata.py` (around line 180): since execution plan is an optional field we might need to handle none here or within the model itself same goes for all the other fields like extra & attributes
REVIEW_EOF
