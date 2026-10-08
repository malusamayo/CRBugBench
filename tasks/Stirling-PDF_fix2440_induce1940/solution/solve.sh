#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/resources/static/js/homecard.js`:

This pull request introduces the defect later reported as "[Bug]: Collapsible menus on reload (with state closed saved) don't re-expand correctly". The
problem a user observed, and its root cause:

### Installation Method

Docker

### The Problem

Collapsible menus on reload (with state closed saved) don't re-expand correctly
![Animation2](https://github.com/user-attachments/assets/7bbdb72e-e5d7-4ffc-ab1a-9cfcf40945ae)


### Version of Stirling-PDF

0.33.1

### Last Working Version of Stirling-PDF

_No response_

### Page Where the Problem Occurred

_No response_

### Docker Configuration

_No response_

### Relevant Log Output

_No response_

### Additional Information

_No response_

### Browsers Affected

Chrome

### No Duplicate of the Issue

- [X] I have verified that there are no existing issues raised related to my problem.

This same root cause must be fixed before merging.
REVIEW_EOF
