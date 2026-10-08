#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `mods/ra/maps/monster-tank-madness/monster-tank-madness.lua`:

This pull request introduces the defect later reported as "The helicopter not appear when Dr.Demitri rescued in RA Monster Tank Madness playtest20170304.". The
problem a user observed, and its root cause:

In the RedAlert mod, solo mission: Monster Tank Madness
All The primary and secondary mission done, but the helicopter never arrive, the bug also in bleed branch.

This same root cause must be fixed before merging.
REVIEW_EOF
