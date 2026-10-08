#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `main/webapp/modules/core/styles/util/menu.css`:

This pull request introduces the defect later reported as "Unelegant text wrapping in menu items with icons". The
problem a user observed, and its root cause:

In menu items where the text is too long to fit on one line, the wrapping does not interact very well with the icon:

![screenshot](https://github.com/user-attachments/assets/484ebe90-b7c8-4689-880f-20a7b600f392)
I would rather expect the beginning second line to be horizontally aligned with the first one.

We could also reconsider how those menus are laid out, as it seems that their width could better adapt to their contents.

This same root cause must be fixed before merging.
REVIEW_EOF
