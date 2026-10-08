#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `superset-frontend/src/features/home/Menu.tsx`:

This pull request introduces the defect later reported as "Weird focus indicator on navigation header". The
problem a user observed, and its root cause:

### Bug description

Superset is showing a weird focus indicator on the navigation header. I'm not sure if this was intended for accessibility but it gets activated only if you click on the Superset logo. If you click on Dashboard, it will not activate the focus.

### How to reproduce the bug

1. Click on the Superset logo
2. Use tab to navigate to other menu option
3. Check that if you click on Dashboard the focus is not activated

### Screenshots/recordings

https://github.com/user-attachments/assets/1759c9bf-c4f1-4527-be4c-2201f403eb77



### Superset version

master / latest-dev

### Python version

3.9

### Node version

16

### Browser

Chrome

### Additional context

Also present in 4.1.0 RC2

### Checklist

- [X] I have searched Superset docs and Slack and didn't find a solution to my problem.
- [X] I have searched the GitHub issue tracker and didn't find a similar bug report.
- [X] I have checked Superset's logs for errors and if I found a relevant Python stacktrace, I included it here as text in the "additional context" section.

This same root cause must be fixed before merging.
REVIEW_EOF
