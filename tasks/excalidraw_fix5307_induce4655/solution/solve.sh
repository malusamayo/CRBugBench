#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/components/App.tsx`:

This pull request introduces the defect later reported as "Can't add text to second container if first container has text and second container is centered around the first one". The
problem a user observed, and its root cause:

Create a container with some text
position a second container centered around the first one
select the second container and press enter to start editing text in the second container
you can only edit text in the first container unless you move the second container so it is not centered around the first one.

https://user-images.githubusercontent.com/14358394/173408917-23f69588-8967-4cdb-a690-d0ce3887bbbc.mp4

This same root cause must be fixed before merging.
REVIEW_EOF
