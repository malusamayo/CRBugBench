#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_input_focus/src/directional_navigation.rs`:

This pull request introduces the defect later reported as "`bevy_input_focus`: Auto navigation ignores camera targets". The
problem a user observed, and its root cause:

## Bevy version and features

Bevy main

## Problem

Auto directional navigation ignores camera targets. Even nodes that are rendered to different windows are added to the same navigation graph as though there is only a single UI layout.

This same root cause must be fixed before merging.
REVIEW_EOF
