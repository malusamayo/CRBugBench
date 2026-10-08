#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `libs/scrap/src/wayland/pipewire.rs`:

This pull request introduces the defect later reported as "Persist_mode for xdg portal does not work". The
problem a user observed, and its root cause:

### Bug Description

The portal dialog on wayland shows upon connecting but it is not possible to make the remote desktop session persistent.

### How to Reproduce

Connect to a wayland host.

### Expected Behavior

Persistent session 

### Operating system(s) on local side and remote side

wayland -> wayland (Fedora 39)

### RustDesk Version(s) on local side and remote side

nightly

### Screenshots

-

### Additional Context

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
