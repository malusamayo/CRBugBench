#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty/src/message_bar.rs`:

This pull request introduces the defect later reported as "Message bar text shouldn't be computed based on byte length". The
problem a user observed, and its root cause:

There are some string length checks for the message bar which use the byte length (see [here](https://github.com/alacritty/alacritty/blob/62c300c14ce7a96373e0094763e9fd035b6b9b6d/alacritty/src/display.rs#L419)). Generally I don't think unicode and fullwidth characters have been considered much for the message bar. However since it's possible for user config to show up inside the message bar, it's possible to have these unicode symbols present here.

This same root cause must be fixed before merging.
REVIEW_EOF
