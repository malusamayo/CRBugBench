#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `extensions/wikidata/src/org/openrefine/wikidata/editing/ReconEntityRewriter.java` (around line 99): According to the error message, the failing cast seems to be happening here, and it makes sense because this line is indeed problematic: there is no reason why the `EntityIdValue` we are passed is an `ItemIdValue` in general.

I think this entire method can actually be removed now that you have added other methods for the other classes that we intend to support in this context.
REVIEW_EOF
