#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `main/webapp/modules/core/MOD-INF/controller.js` (around line 251): This should be kept: here, "binary/text/xml/xls/xlsx" serves as an internal identifier for the format, and does not need to be an official MIME type. The correct place to add the mapping is further down, with `IM.registerMimeType`.
REVIEW_EOF
