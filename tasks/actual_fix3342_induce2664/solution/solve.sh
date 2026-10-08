#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/desktop-client/src/components/common/Tooltip.tsx`:

This pull request introduces the defect later reported as "[Bug]: Budget note field doesn't vanish on touch devices". The
problem a user observed, and its root cause:

### Verified issue does not already exist?

- [X] I have searched and found no existing issue

### What happened?

When I was finished entering a note on the budget screen (within a category), I tapped somewhere else because that's how I close the note field when I work with a trackpad. The bug is that with touch input (finger) the note stayed there and didn't vanish.

When I later used my trackpad, it worked as it should. When I proceed with touch, the note field stays there again. It has to do with touch input/latency(?) I think.


### What error did you receive?

Didn't receive an error, the note field just stayed and was sort of "freezed".
![Screenshot 2024-09-01 204846](https://github.com/user-attachments/assets/3ea0371b-df56-4fd2-8646-45ec6132f964)



### Where are you hosting Actual?

Locally via Yarn

### What browsers are you seeing the problem on?

Microsoft Edge

### Operating System

Windows 11

This same root cause must be fixed before merging.
REVIEW_EOF
