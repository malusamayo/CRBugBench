#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Files.Launcher/Helpers/ShellFolderHelpers.cs`:

This pull request introduces the defect later reported as "Empty Network". The
problem a user observed, and its root cause:

### Description

No shared folders, computers or devices are showing up in Network
![unknown](https://user-images.githubusercontent.com/97712407/149433659-dbd9d2a2-e232-4d27-8642-c257714f84dd.png)


### Steps To Reproduce

1. Open Files
2. Go to Network
3. Nothing Appearing.

### Expected behavior

Not sure what is supposed to happen but I assume you would at least see the available shared locations on the network.

### Files Version

Version: 2.1.0.0

### Windows Version

Windows 11 Pro Version	21H2 OS build 22000.434 Windows Feature Experience Pack 1000.22000.434.0

### Relevant Assets/Logs

[debug.log](https://github.com/files-community/Files/files/7866929/debug.log)
[debug_fulltrust.log](https://github.com/files-community/Files/files/7866930/debug_fulltrust.log)

This same root cause must be fixed before merging.
REVIEW_EOF
