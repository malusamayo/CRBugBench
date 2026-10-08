#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty/src/renderer/mod.rs`:

This pull request introduces the defect later reported as "Unbounded recursion while printing error message". The
problem a user observed, and its root cause:

Note: This issue is not about the actual issue that causes alacritty to not start, but about the crash during printing the error message.

### System

OS: Linux (Alpine Edge), running on a Raspberry Pi 4
Version: alacritty 0.4.1 (a0403c7a16)
Linux/BSD: Wayland, sway
Windows: -- (doesn't apply)

### Logs

Stdout (cropped, the details part of the message is apparently printed recursively):

```
Alacritty encountered an unrecoverable error:

There was an error initializing the shaders: There was an error initializing the shaders: There  was an error initializing the shaders: There was an error initializing the shaders: [...]
```

Stderr (after the stack overflowed):

```
Segmentation fault
```

### Additional Info

https://github.com/alacritty/alacritty/blob/c84cd0fdb0335fa873f397e95a0a728be0fe15f5/alacritty/src/main.rs#L111-L115

The `println!()` in line 113 is the last line I can reach in GDB.

This same root cause must be fixed before merging.
REVIEW_EOF
