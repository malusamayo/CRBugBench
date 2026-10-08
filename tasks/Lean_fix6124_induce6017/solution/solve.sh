#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Common/Data/LeanDataWriter.cs`:

This pull request introduces the defect later reported as "Random Data Generator Date Mismatch for Futures". The
problem a user observed, and its root cause:

#### Expected Behavior
The date in zip file name and in the content are the same. `OpenInterest` files are generated.

#### Actual Behavior
The date in zip file name is different from the date in the content. I ran an algorithm with this data and it doesn't trigger `OnData`. Also, there are no `OpenInterest` files (see #5871).

#### Reproducing the Problem
```
lean data generate --start 20210101 --security-type Future --resolution Minute --symbol-count 1 --market cme
```
![Capture](https://user-images.githubusercontent.com/6889033/146585464-24583628-2098-4bf6-b706-d2519ef1748b.png)

I have renamed the zip files to match the dates and the algorithm starts calling `OnData`.

#### Checklist
- [x] I have completely filled out this template
- [x] I have confirmed that this issue exists on the current `master` branch
- [x] I have confirmed that this is not a duplicate issue by searching [issues](https://github.com/QuantConnect/Lean/issues)
- [x] I have provided detailed steps to reproduce the issue

This same root cause must be fixed before merging.
REVIEW_EOF
