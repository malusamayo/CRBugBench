#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Directory.Build.targets`:

This pull request introduces the defect later reported as "Component packages are not using their specified icons". The
problem a user observed, and its root cause:

The preview.1 release of the component packages are not using their configured specific icons (Redis for redis, etc.). This was working in `main` but doesn't seem to have worked in the branch/pipeline the official preview.1 packages were built from.

This same root cause must be fixed before merging.
REVIEW_EOF
