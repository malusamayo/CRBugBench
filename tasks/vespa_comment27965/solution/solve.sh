#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `searchsummary/src/vespa/juniper/sumdesc.cpp` (around line 762): I don't understand this could end up taking a reference to nullptr, but if size() is 0 then s[0] is certainly illegal.  Are you saying string's internal char buffer is initialized to nullptr?  Because c_str() could be called on a newly initialized string I thought the internal buffer always had at least length 1 to include the '\0'.
REVIEW_EOF
