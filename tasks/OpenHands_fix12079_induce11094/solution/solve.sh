#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frontend/src/components/features/conversation-panel/conversation-panel-wrapper.tsx`:

This pull request introduces the defect later reported as "[Bug]: The conversation panel is overlapping the account context menu.". The
problem a user observed, and its root cause:

### Is there an existing issue for the same bug? (If one exists, thumbs up or comment on the issue instead).

- [x] I have checked the existing issues.

### Describe the bug and reproduction steps

As demonstrated in the video below, the conversation panel overlaps the account context menu.

https://github.com/user-attachments/assets/9240fce0-a320-4375-b97b-c21a3f384f39

### OpenHands Installation

Docker command in README

### OpenHands Version

_No response_

### Model Name

_No response_

### Operating System

None

### Logs, Errors, Screenshots, and Additional Context

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
