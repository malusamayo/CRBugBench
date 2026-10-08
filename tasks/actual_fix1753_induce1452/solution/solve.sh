#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/loot-core/src/server/budget/goaltemplates.ts`:

This pull request introduces the defect later reported as "[Bug]: Schedules using the amount between option don't work with templates". The
problem a user observed, and its root cause:

### Verified issue does not already exist?

- [X] I have searched and found no existing issue

### What happened?

If I set a schedule amount to be between two values instead of an approximate value, nothing happens when using the schedule template.

### What error did you receive?

_No response_

### Where are you hosting Actual?

None

### What browsers are you seeing the problem on?

_No response_

### Operating System

None

This same root cause must be fixed before merging.
REVIEW_EOF
