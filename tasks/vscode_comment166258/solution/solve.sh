#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/vs/editor/contrib/links/browser/links.css` (around line 9): The correct value is `--vscode-editorLink-activeForeground`
To get the color name, find the `registerColor` of the color to see the name.
REVIEW_EOF
