#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `openmetadata-ui/src/main/resources/ui/src/components/nav-bar/NavBar.tsx`:

This pull request introduces the defect later reported as "UI: Profile picture is different in the user menu". The
problem a user observed, and its root cause:

**Affected module**
Does it impact the UI, backend or Ingestion Framework?
UI

**Describe the bug**
Notice the color of profile picture background being different in the User menu in the top right corner.
<img width="1728" alt="Screen Shot 2022-09-13 at 12 19 58 PM" src="https://user-images.githubusercontent.com/1051198/189990963-a1d84a3b-5e2c-4c16-8c14-9d1f585c83cd.png">

**Expected behavior**
Profile picture is the same everywhere

This same root cause must be fixed before merging.
REVIEW_EOF
