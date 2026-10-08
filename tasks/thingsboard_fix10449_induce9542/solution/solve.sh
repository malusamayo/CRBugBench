#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ui-ngx/src/app/shared/components/image/multiple-gallery-image-input.component.html`:

This pull request introduces the defect later reported as "Browse from gallery - can't select images". The
problem a user observed, and its root cause:

**Describe the bug**
Recently I wanted to add new image to marker images list from Browse from gallery, but selection window does not popup.
I have checked this on Chrome/Edge. Chrome mobile, always same result, small balloon... Any clue ?

**Your Server Environment**
https://thingsboard.cloud

** images **
Screen shot from browser
![browse_from_gallery_error](https://github.com/thingsboard/thingsboard/assets/45353572/933ac0fd-2be9-4cfd-ace4-26831bf3155f)

This same root cause must be fixed before merging.
REVIEW_EOF
