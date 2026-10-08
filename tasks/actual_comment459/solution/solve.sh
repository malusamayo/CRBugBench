#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/desktop-client/src/components/SidebarWithData.js` (around line 53): <!-- Warning represent user-facing problems. If possible, it's great to follow this kind of comment with a suggestion.  -->
**🔨 warning:** ‏the `help` link should either be hidden when using the electron app, or it should be made to work (currently it won't work).

To check if the app is electron you can use `!Platform.isBrowser`
REVIEW_EOF
