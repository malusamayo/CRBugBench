#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/calibre/gui2/main.py` (around line 403): shlex.quote is not available in python 2. And the sleep is done via the shell not time.sleep() so that it does not block the main thread. Although, since this is macOS specific, one could use preexec_fn instead.
REVIEW_EOF
