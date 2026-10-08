#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `spacy/gold.pyx` (around line 145): ```suggestion
            elif path.parts[-1].endswith((".json", ".jsonl")):
```

I have no idea if this matters but I think it typically takes a tuple instead of a list. So we might as well do it here for consistency.
REVIEW_EOF
