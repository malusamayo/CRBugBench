#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty/src/config/bindings.rs`:

This pull request introduces the defect later reported as "Can not copy when `Ctrl+Shift+C` is pressed in Vi mode". The
problem a user observed, and its root cause:

### System

OS: Windows
Version: alacritty 0.13.0-rc1 (ada35ae)

### Issue

When I switch to Vi mode in Alacritty 0.13.0-rc1, press `v` to select a portion of text, and then press `Ctrl+Shift+C`, the selected text **cannot** be copied to the clipboard.

And if I set key bindings in `alacritty.toml` as follows, I can copy the selected text successfully in Vi mode:

```
[keyboard]
bindings = [
    { key = "C", mods = "Control|Shift", action = "Copy" },
    { key = "C", mods = "Control|Shift", mode = "Vi|~Search", action = "ClearSelection" },
]
```

This problem did not occur in version 0.12.3, but it first appeared in version 0.13.0-rc1

This same root cause must be fixed before merging.
REVIEW_EOF
