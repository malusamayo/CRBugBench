#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `searchlib/src/vespa/searchlib/queryeval/same_element_blueprint.cpp` (around line 170): this may or may not be the field we are looking for. if expose_match_data_for_same_element is true in the query node, this is the correct field. If the flag is false, the match data of the only child is the one being exposes to the ranking framework instead.
REVIEW_EOF
