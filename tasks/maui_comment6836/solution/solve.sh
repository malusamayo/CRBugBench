#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Controls/src/Core/VisualElement.cs` (around line 704): Is this intentional? It seems that the flow is now different with the if block controlling the InvalidateStateTriggers when it would hav always run?
REVIEW_EOF
