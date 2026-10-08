#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Files.Uwp/ViewModels/ToolbarViewModel.cs` (around line 920): Could you check if this creates issues when browsing an FTP server? (where the path is supposed to contain "/")
REVIEW_EOF
