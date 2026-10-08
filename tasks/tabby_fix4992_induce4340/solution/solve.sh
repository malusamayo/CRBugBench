#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tabby-core/src/services/hotkeys.util.ts`:

This pull request introduces the defect later reported as "Hotkey setter treats backtick as tilde.". The
problem a user observed, and its root cause:

Using a backtick in hotkeys doesn't work because it gets converted into a tilde.

For example, if you want `` Ctrl + ` `` as the toggle key, it will be registered as `Ctrl + ~`.

Editing the config file directly works as a workaround.

This same root cause must be fixed before merging.
REVIEW_EOF
