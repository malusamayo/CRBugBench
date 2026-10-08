#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `openbb_terminal/helpers_denomination.py`:

This pull request introduces the defect later reported as "[Bug] Error loading economy/macro TOYA parameter". The
problem a user observed, and its root cause:

On previous version worked fine.

2022 Oct 01, 15:22 (🦋) /economy/ $ macro -t **TOYA** -p CPI -c Netherlands
pandas\core\frame.py:10037: FutureWarning: Dropping of nuisance columns in DataFrame reductions (with 'numeric_only=None') is deprecated; in a future version this will raise TypeError.  Select only valid columns before calling the reduction.
pandas\core\frame.py:10037: FutureWarning: Dropping of nuisance columns in DataFrame reductions (with 'numeric_only=None') is deprecated; in a future version this will raise TypeError.  Select only valid columns before calling the reduction.
Error: 'value' must be an instance of str or bytes, not a float

![Figure_3](https://user-images.githubusercontent.com/402399/193425279-8bc23b4c-77ec-4cf9-bae1-9289287b7c6f.png)

OpenBB Terminal v1.8.0 (https://openbb.co)
Windows 11
Python 3.10.7
pandas-1.5.0-cp310-cp310-win_amd64.whl
pytz-2022.2.1-py2.py3-none-any.whl
numpy-1.23.3-cp310-cp310-win_amd64.whl
six-1.16.0-py2.py3-none-any.whl

This same root cause must be fixed before merging.
REVIEW_EOF
