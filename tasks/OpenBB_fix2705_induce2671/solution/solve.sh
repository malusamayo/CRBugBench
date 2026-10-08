#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `openbb_terminal/helpers_denomination.py`:

This pull request introduces the defect later reported as "[Bug] Economy/Macro --parameters POP --countries China. Error: 'Tens of thousands'". The
problem a user observed, and its root cause:

This function produces an error when the `parameters` is POP and `--countries` is China. 
<img width="515" alt="Screen Shot 2022-10-03 at 8 38 23 AM" src="https://user-images.githubusercontent.com/85772166/193618725-0db64d0d-7b02-46e1-aa98-c7fe5b4fc6f1.png">

Other countries return a chart as expected.

This same root cause must be fixed before merging.
REVIEW_EOF
