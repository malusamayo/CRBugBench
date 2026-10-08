#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `jabgui/src/main/java/org/jabref/gui/consistency/ConsistencyCheckAction.java`:

This pull request introduces the defect later reported as "Consistency Check Dialog not updating until resizing the window". The
problem a user observed, and its root cause:

When I open the consistency check the list for example does not update when scrolling or clicking etc. until I resize the dialog window. (for other dialogs it works fine, for example integrity check)


<img width="1215" height="643" alt="Image" src="https://github.com/user-attachments/assets/fab96c99-a0bf-4ebf-bfce-5beaa16549da" />

This is the state when trying to click on entries, to scroll or switching the entry type.
After resizing it shows the "update" but does not show anything else until I resize the window again. 

<img width="1287" height="642" alt="Image" src="https://github.com/user-attachments/assets/1401085b-27c9-470a-bc6a-67fcc7085279" />

This same root cause must be fixed before merging.
REVIEW_EOF
