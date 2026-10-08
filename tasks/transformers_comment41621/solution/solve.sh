#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/transformers/models/lighton_ocr/modular_lighton_ocr.py` (around line 688): Should those really be tied? I see `tie_word_embeddings` to be False by default in the text config, so just want to make sure.
Note that the text config will not control it, since it is part of the main model, `LightOnOcrConfig` is the one controlling it. 
If it should not be tied, let's remove this mapping
REVIEW_EOF
