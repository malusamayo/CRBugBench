#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/renderers/webxr/WebXRManager.js`:

This pull request introduces the defect later reported as "WebXR VR Examples are broken since the v130 update on Oculus Quest 2". The
problem a user observed, and its root cause:

**Describe the bug**

A bunch of the three js examples for VR no longer work since v130 and we're seeing the same issue in our application when we upgrade to v130.

**To Reproduce**

Steps to reproduce the behavior:
1. It may require testing a layers enabled example first (or not)
2. Try the following examples:
  - https://threejs.org/examples/?q=webxr#webxr_vr_ballshooter
  - https://threejs.org/examples/?q=webxr#webxr_vr_cubes
  - https://threejs.org/examples/?q=webxr#webxr_vr_panorama
  - https://threejs.org/examples/?q=webxr#webxr_vr_panorama_depth
  - https://threejs.org/examples/?q=webxr#webxr_vr_paint
  - https://threejs.org/examples/?q=webxr#webxr_vr_rollercoaster
  - https://threejs.org/examples/?q=webxr#webxr_vr_sculpt
  - https://threejs.org/examples/?q=webxr#webxr_vr_video

**Expected behavior**

The demos should function as they did before, but currently they just show up totally black in the headset.

**Platform:**

 - Device:  Oculus Quest 2
 - OS:  v30.1
 - Browser: Oculus Quest Browser
 - Three.js version: 130

This same root cause must be fixed before merging.
REVIEW_EOF
