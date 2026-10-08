#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/VisualStudio/Core/Def/Indentation/VisualStudioInferredIndentationService.cs` (around line 20): This type needs to be moved to EditorFeatures, since this needs to still be active in VS for Mac.
REVIEW_EOF
