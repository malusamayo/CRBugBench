#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Files.App/Actions/Open/OpenRepoInVSCodeAction.cs` (around line 22): I think we should disable this action when not in a git repo. At the moment a user can execute it in any folder from the command palette. In this case, the action may not work as expected
REVIEW_EOF
