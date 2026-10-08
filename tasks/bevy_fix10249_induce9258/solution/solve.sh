#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `examples/3d/deferred_rendering.rs`:

This pull request introduces the defect later reported as "Fog in deferred doesn't work.". The
problem a user observed, and its root cause:

## Bevy version fb5588413f9438592ebf81cc2820408ffcdcb759

Bisect shows 51c70bc98cd9c71d8e55a4656f22d0229a0ef06e / https://github.com/bevyengine/bevy/pull/10226 introduced the issue.

Before 51c70bc98cd9c71d8e55a4656f22d0229a0ef06e showing fog:
![before](https://github.com/bevyengine/bevy/assets/33357138/97efbb67-efb0-4103-a0a4-e378fc9d5527)

After 51c70bc98cd9c71d8e55a4656f22d0229a0ef06e missing fog:
![after](https://github.com/bevyengine/bevy/assets/33357138/b22e2a74-f61d-4502-8f35-f1f23245c671)

This same root cause must be fixed before merging.
REVIEW_EOF
