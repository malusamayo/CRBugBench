#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `qt/aqt/browser/browser.py`:

This pull request introduces the defect later reported as "Card info should perhaps update instead of toggle?". The
problem a user observed, and its root cause:

https://forums.ankiweb.net/t/have-to-select-info-twice-when-the-card-info-window-is-already-open-first-time-just-closes-the-window/38396

This same root cause must be fixed before merging.
REVIEW_EOF
