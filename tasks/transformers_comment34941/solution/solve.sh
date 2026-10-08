#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/transformers/models/beit/modeling_beit.py` (around line 369): It would be great to add a fallback to `eager` attention if `output_attentions=True`, see other models for details, e.g. CLIP/SigLIP.
REVIEW_EOF
