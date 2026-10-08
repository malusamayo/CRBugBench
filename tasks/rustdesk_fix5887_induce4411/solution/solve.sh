#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `flutter/lib/desktop/widgets/remote_toolbar.dart`:

This pull request introduces the defect later reported as "Pressing the display button shows screen sharing window. It persists as long as the dropdown is visible and goes away once dropdown is hidden.". The
problem a user observed, and its root cause:

### Bug Description

Pressing the display button shows screen sharing window. It persists as long as the dropdown is visible and goes away once dropdown is hidden.




### How to Reproduce

Pressing the display button shows screen sharing window. It persists as long as the dropdown is visible and goes away once dropdown is hidden.



### Expected Behavior

it should happen only once 

### Operating system(s) on local side and remote side

Linux

### RustDesk Version(s) on local side and remote side

Windows

### Screenshots

![image](https://github.com/rustdesk/rustdesk/assets/11899221/f505629d-df8c-483d-9776-fe0382339737)


### Additional Context

Confirmed only happens on Wayland. X11 is fine.

This same root cause must be fixed before merging.
REVIEW_EOF
