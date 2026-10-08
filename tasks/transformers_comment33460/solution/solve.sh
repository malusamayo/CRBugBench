#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/transformers/quantizers/quantizer_awq.py` (around line 51): Make sure to also to update  the condition `if device_map is None:`  below now that we also support cpu. 

We need to do a backend check for cuda and ipex but also 
- if version == ipex and device_map is not `None` or device_map != "cpu, then ask the user to make sure to move the model to cpu afterwards 
- elif device_map is None or device_map == "cpu" then ask the user to move it to cuda afterwards.
REVIEW_EOF
