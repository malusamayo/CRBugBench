#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/lib/window.ts`:

This pull request introduces the defect later reported as "Alpha 169 crashes on startup on Windows 7". The
problem a user observed, and its root cause:

<!--
Before submitting an issue, make sure that:
* You're running the latest Tabby version: https://github.com/Eugeny/tabby/releases
* You've searched the existing issues: https://github.com/Eugeny/tabby/issues
* Your problem is not caused by third-party plugins (disable _third-party_ plugins, restart and try to reproduce the problem).

*Reports are accepted in English ONLY.*
-->

**Describe the problem**:
Alpha 169 crashes on startup on Windows 7 machine. "data\log.txt" is empty. Version 168 works normally.

**To Reproduce**:
Crashes every time on app launch.

This same root cause must be fixed before merging.
REVIEW_EOF
