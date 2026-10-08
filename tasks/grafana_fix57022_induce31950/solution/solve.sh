#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `public/app/features/dashboard/components/AnnotationSettings/AnnotationSettingsList.tsx`:

This pull request introduces the defect later reported as "PO: Unable to select existing annotation via keyboard". The
problem a user observed, and its root cause:

Note the outline skipping over the name of the annotation.
![annotation-keyboard](https://user-images.githubusercontent.com/1048831/194582677-4fc57ead-49ac-434d-9494-14f898843d7f.gif)

This same root cause must be fixed before merging.
REVIEW_EOF
