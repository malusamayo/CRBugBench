#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `GitUI/CommandsDialogs/FormBrowse.cs`:

This pull request introduces the defect later reported as "When default Pull button action is set to "Fetch and prune all", the "Open pull dialog..." entry does a fetch and prune all". The
problem a user observed, and its root cause:

<!--
IMPORTANT

Before creating an issue, be sure to search existing issues, both open AND closed,
to see whether someone else has already reported your issue.

Please also read CONTRIBUTING.md.
-->

**Do you want to request a *feature* or report a *bug*?**
Bug

**What is the current behavior?**

When default Pull button action is set to "Fetch and prune all", the "Open pull dialog..." entry does a fetch and prune all

**If the current behavior is a bug, please provide the steps to reproduce and if possible a minimal demo of the problem.**

1. Set default pull button action to "Fetch and prune all".
2. Click "Open pull dialog...".

**What is the expected behavior?**
The pull dialog opens

**Environment you encounter the issue:**

<!--
Help->About Copy button or Help->Report an issue link will put this info in the clipboard.
-->
- Git Extensions 3.00.00.4433
- Build fca7cf228b481ee8c1b779cf7b882ccdfbdcd1bc
- Git 2.19.1.windows.1
- Microsoft Windows NT 6.1.7601 Service Pack 1
- .NET Framework 4.7.3133.0
- DPI 96dpi (no scaling)

**Did this work in previous version of GitExtensions (which)?**
Yes, Version 2.51.04 .

<!-- Love gitextensions? Please consider supporting our collective:
👉  https://opencollective.com/gitextensions/donate -->

This same root cause must be fixed before merging.
REVIEW_EOF
