#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `main/webapp/modules/core/scripts/index/open-project-ui.js`:

This pull request introduces the defect later reported as "OpenRefine opens the "Open project" tab by default". The
problem a user observed, and its root cause:

Until recently, when starting OpenRefine, one would be presented with the first panel ("Create project").
In the current development version (master branch), the "Open project" tab opens instead.

### To Reproduce
Steps to reproduce the behavior:
1. First, do `./refine`
2. Then, observe the panel that appears in the browser.


### Current Results
The "Open project" panel is shown.

### Expected Behavior
The "Create project" panel is shown.

### Versions<!--  (please complete the following information)-->
 - Operating System: Debian
 - Browser Version: both firefox and chromium
 - OpenRefine:  3.8-SNAPSHOT [9042ff7]

This same root cause must be fixed before merging.
REVIEW_EOF
