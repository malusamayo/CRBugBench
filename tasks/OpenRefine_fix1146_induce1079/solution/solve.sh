#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `main/src/com/google/refine/model/ColumnModel.java`:

This pull request introduces the defect later reported as "Transpose > Columnize by Key/Value doesn't work in 2.6-rc.2 ". The
problem a user observed, and its root cause:

Newbie report here.  I hope it's helpful.

I _think_ I found a bug in doing a column transpose in version 2.6-rc.2.  I can accomplish the transaction in either 2.6-beta.1 or 2.5

Operating Systems and version:  does not work in 2.6-rc.2 on Windows 7 and Windows 10.  

Browser:  on Win10:  Chrome version is 51.0.2704.84
  on Win7:  Chrome version is 51.0.2704.84
                  Firefox version 29.0.1

Steps followed to create the issues
Transpose > Columnize by Key/Value Columns
    Key Column = Location
    Value Column = Category
        > OK

Current Results:  in 2.6-rc.2 I get the following error:
chrome: Index: 6, Size: 0
firefox:  Index: 6, Size: 0

Expected Results:  two columns transposed in 2.6-rc.2  as it does work in earlier versions  

If this message should go somewhere else, please advise.  

[data-and-operationHistory.zip](https://github.com/OpenRefine/OpenRefine/files/319212/data-and-operationHistory.zip)

This same root cause must be fixed before merging.
REVIEW_EOF
