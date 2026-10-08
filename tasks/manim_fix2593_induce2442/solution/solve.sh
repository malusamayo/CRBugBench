#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `manim/utils/ipython_magic.py`:

This pull request introduces the defect later reported as "Preview without embed broken in jupyter notebooks.". The
problem a user observed, and its root cause:

## Description

The embed feature seems to have broken preview in jupyter notebooks.

default:
<img width="1115" alt="Screenshot 2022-03-05 at 3 24 09 PM" src="https://user-images.githubusercontent.com/90276965/156878243-224900ac-8da2-46e5-8ee2-cc9f1852bec8.png">

with media embed:
<img width="1115" alt="Screenshot 2022-03-05 at 3 24 30 PM" src="https://user-images.githubusercontent.com/90276965/156878267-b5d77f95-7953-45e9-b155-baac8f19db35.png">

## Expected Behaviour
Should preview images even without `media_embed`


_Originally posted by @Kiran-Raj-Dev in https://github.com/ManimCommunity/manim/issues/2442#issuecomment-1059732017_

This same root cause must be fixed before merging.
REVIEW_EOF
