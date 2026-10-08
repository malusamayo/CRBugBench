#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `languagetool-server/src/main/java/org/languagetool/server/LanguageToolHttpHandler.java` (around line 126): workQueueFull actually sends an error, the added case doesn't
refactor that part out and call it in the conditional so that we actually send a response
REVIEW_EOF
