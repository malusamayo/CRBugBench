#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `main/webapp/modules/core/scripts/index.js`:

This pull request introduces the defect later reported as "Unwanted symbol in project version metadata dialogue". The
problem a user observed, and its root cause:

<!-- Describe the bug - Please add a clear and concise description of the bug above this line. You can delete this line if you want. It will be hidden in the final bug report -->
Project about dialogue has a weird symbol ahead of its info in the metadata.
### To Reproduce
Steps to reproduce the behavior:
1. Create a project
2. Then, click on it's about tab
3. Finally, see the bug



### Current Results
<!-- What results occurred or were shown. -->
The weird symbol `$1` appears ahead of it
### Expected Behavior
<!-- A clear and concise description of what you expected to happen or to show. -->
No unwanted characters should be present
### Screenshots
<!-- If applicable, add screenshots to help explain your problem. -->
<img width="1388" alt="Screenshot 2021-01-16 at 11 01 59 PM" src="https://user-images.githubusercontent.com/44091822/104818678-11400100-584f-11eb-8743-7ba053fdd70a.png">

This same root cause must be fixed before merging.
REVIEW_EOF
