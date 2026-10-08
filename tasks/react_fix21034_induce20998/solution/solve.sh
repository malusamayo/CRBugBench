#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react-devtools-shared/src/devtools/views/Components/InspectedElementHooksTree.css`:

This pull request introduces the defect later reported as "Bug: DevTools built-in hook number badges are broken for "light" theme". The
problem a user observed, and its root cause:

I mostly use the "dark" theme which these badges looked good in. The "light" theme is broken though. No contrast.

This same root cause must be fixed before merging.
REVIEW_EOF
