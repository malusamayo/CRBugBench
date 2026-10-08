#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `extensions/wikidata/src/org/openrefine/wikidata/qa/scrutinizers/ItemRequiresScrutinizer.java` (around line 73): The severity should also be adapted depending on whether the the `update.isNew()` or not
REVIEW_EOF
