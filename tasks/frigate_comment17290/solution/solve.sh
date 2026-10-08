#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `web/src/pages/FaceLibrary.tsx` (around line 351): There doesn't seem to be a way to navigate back to the Train section on mobile once you've already navigated to one of the libraries.

I think it'd be fine to always have a Train tab visible if that was easier.
REVIEW_EOF
