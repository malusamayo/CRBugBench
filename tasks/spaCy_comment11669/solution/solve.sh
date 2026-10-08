#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `spacy/pipeline/entity_linker.py` (around line 497): On the topic of empty Docs, is the iteration here OK?

If I understand correctly, `all_ent_cands` has one element per Doc. Those elements (lists) can be empty if a Doc has no entities, but they are always present.

Here the input Docs and `all_ent_cands` are iterated separately. Because of the early `continue` for Docs with no tokens, wouldn't that result in a misalignment, because the `all_ent_cands` generator wouldn't be advanced?
REVIEW_EOF
