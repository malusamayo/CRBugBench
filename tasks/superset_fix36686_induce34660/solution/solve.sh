#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `superset-frontend/src/dashboard/util/activeAllDashboardFilters.ts`:

This pull request introduces the defect later reported as "Table charts reloading non-stop". The
problem a user observed, and its root cause:

### Bug description

Pull from master and run Superset. Table charts keep reloading and firing database queries.

### Screenshots/recordings

https://github.com/user-attachments/assets/4e37d6fe-36a5-44c4-8ff7-4accda0abbaf

### Superset version

master / latest-dev

### Python version

3.11.14

### Node version

v20.19.5

### Browser

Chrome

### Additional context

_No response_

### Checklist

- [ ] I have searched Superset docs and Slack and didn't find a solution to my problem.
- [ ] I have searched the GitHub issue tracker and didn't find a similar bug report.
- [ ] I have checked Superset's logs for errors and if I found a relevant Python stacktrace, I included it here as text in the "additional context" section.

This same root cause must be fixed before merging.
REVIEW_EOF
