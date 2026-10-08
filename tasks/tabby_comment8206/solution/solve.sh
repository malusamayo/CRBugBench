#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tabby-ssh/src/components/sshTab.component.ts` (around line 162): Did this functionality get lost here? For SSH, there's an important distinction: you never want to keep the session open after you explicitly kill it with Ctrl-D or `exit`
REVIEW_EOF
