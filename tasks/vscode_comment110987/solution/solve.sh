#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/vs/workbench/contrib/terminal/browser/terminalInstance.ts` (around line 551): A possible issue with this. If I have focus in the terminal, and I press a keybinding bound to one of these, and I expect it to go to the terminal but it triggers the command. That's actually the exact scenario we are trying to capture.
REVIEW_EOF
