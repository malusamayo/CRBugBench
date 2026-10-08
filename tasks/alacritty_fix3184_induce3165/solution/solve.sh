#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty/src/event.rs`:

This pull request introduces the defect later reported as "Alacritty reverts the font change after moving across the monitors". The
problem a user observed, and its root cause:

I'm not sure that it's a desired behavior, however I feel like if a user changed font size from `X` to `Y` on a monitor `1` and then moved a window from a monitor `1` to a monitor `2` we should speculate with the updated font size and not with the default one. So the font size on a monitor `2` should be `Y * scale_factor` and not `X * scale_factor`.

In addition to this the next update after moving alacritty from `1` to `2` will be based on `Y` and not `X`, so it seems like a bug to me.

This same root cause must be fixed before merging.
REVIEW_EOF
