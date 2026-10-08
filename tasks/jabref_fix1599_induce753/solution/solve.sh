#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/net/sf/jabref/gui/openoffice/OOBibBase.java`:

This pull request introduces the defect later reported as "LibreOffice: wrong numbers in citation labels". The
problem a user observed, and its root cause:

JabRef version 3.5 on Mac OS X 10.11.5.
LibreOffice 5.1.4.2.

Steps to reproduce:
1. Connect to LibreOffice text document.
2. Select style Default [number].
3. Insert twice the same citation.
4. Click on the update button.

Expected result:

> [1] [1]

Actual result:

> [1] [1; 2]

Example bibliography:

```
@Article{A,
  author  = {A},
  title   = {A},
  journal = {A},
  year    = {2016},
}
```

Screenshot:
![testjabref](https://cloud.githubusercontent.com/assets/5209500/16888553/0bc9600c-4ae1-11e6-8672-8ae4602e4795.png)

This same root cause must be fixed before merging.
REVIEW_EOF
