#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `Emby.Server.Implementations/Library/DefaultAuthenticationProvider.cs` (around line 50): For security reasons, I suggest to not be as specific : It avoids an attacker to find usernames.
"Invalid username or password" should be reused.
REVIEW_EOF
