#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/packages/excalidraw/index.tsx`:

This pull request introduces the defect later reported as "public path fallback doesn't work". The
problem a user observed, and its root cause:

since https://github.com/excalidraw/excalidraw/pull/5078

culprit release: https://codesandbox.io/s/sweet-hamilton-k4vkjb?file=/src/App.tsx (Virgil font doesn't load)
commit before: https://codesandbox.io/s/romantic-franklin-4jorjz?file=/src/App.tsx (Virgil font loads)

This same root cause must be fixed before merging.
REVIEW_EOF
