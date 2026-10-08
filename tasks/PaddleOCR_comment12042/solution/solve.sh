#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tools/infer/predict_det.py` (around line 37): logger arg needs a default value None, the default behavior should be using logger from `logger = get_logger()`.

otherwise, it will break this: https://github.com/PaddlePaddle/PaddleOCR/blob/1569cfb430dee06b23413b7b0a6d99dc8c84ab70/tools/infer/predict_system.py#L51
REVIEW_EOF
