#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/player/helper/PlayerHelper.java`:

This pull request introduces the defect later reported as "Fit / Fill / Zoom bug". The
problem a user observed, and its root cause:

### Checklist
<!-- This checklist is COMPULSORY. The first box has been checked for you to show you how it is done. -->

- [x] I am using the latest version - 0.20.10 <!-- Check https://github.com/TeamNewPipe/NewPipe/releases -->
- [x] I checked, but didn't find any duplicates (open OR closed) of this issue in the repo. <!-- Seriously, check. O_O -->
- [x] I have read the contribution guidelines given at https://github.com/TeamNewPipe/NewPipe/blob/HEAD/.github/CONTRIBUTING.md.
- [x] This issue contains only one bug. I will open one issue for every bug report I want to file.

### Steps to reproduce the bug

1. Open a random video
2. Watch the video in fullscreen
3. Choose Fit / Fill or Zoom
4. Go out of fullscreen
5. Close the video
6. Open another random video
7. watch the video in fullscreen
8. Notice that the option u chose changed to another one

### Actual behaviour
The value doesnt stay the same. 
if u choose **Zoom** then it will default to **Fill**
if u choose **Fill** it will default to **Fit**
if u choose **Fit** it will default to **Zoom**

### Expected behavior
Value must stay the same!

### Screenshots/Screen recordings

https://user-images.githubusercontent.com/73130443/108190456-deb54c80-7109-11eb-892b-3498298d06e1.mp4



### Logs


### Device info

 - Android version/Custom ROM version: Android 11 /  Graphene OS
 - Device model: Google Pixel 3a XL

This same root cause must be fixed before merging.
REVIEW_EOF
