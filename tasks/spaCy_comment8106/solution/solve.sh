#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `spacy/pipeline/_parser_internals/ner.pyx` (around line 426): should this one have a `break` statement like in `Last` and `Unit` to stop iterating over `gold.negs` once we found one relevant negative example?
REVIEW_EOF
