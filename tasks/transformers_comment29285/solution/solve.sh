#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/transformers/models/gemma/modeling_gemma.py` (around line 116): ```suggestion
        with torch.autocast(device_type=self.inv_freq.device.type, enabled=False):
```
the failing torch fx test are most probably because we use input device ( `The failing test is for torch fx, the device to use should `)
REVIEW_EOF
