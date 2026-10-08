#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `app/src/main/java/org/schabi/newpipe/ReCaptchaActivity.java` (around line 159): This looks like it would break urls like `www.host.com/?pbj=1&otherparam=2` by turning it to `www.host.com/otherparam=2`
REVIEW_EOF
