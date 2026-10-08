#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/player/Player.java`:

This pull request introduces the defect later reported as "[Regression] Enqueue next doesn't work". The
problem a user observed, and its root cause:

### Checklist

- [x] I am able to reproduce the bug with the latest version given here: [CLICK THIS LINK](https://github.com/TeamNewPipe/NewPipe/releases/latest).
- [x] I made sure that there are *no existing issues* - [open](https://github.com/TeamNewPipe/NewPipe/issues) or [closed](https://github.com/TeamNewPipe/NewPipe/issues?q=is%3Aissue+is%3Aclosed) - which I could contribute my information to.
- [x] I have read the [FAQ](https://newpipe.net/FAQ/) and my problem isn't listed.
- [x] I have taken the time to fill in all the required details. I understand that the bug report will be dismissed otherwise.
- [x] This issue contains only one bug.
- [x] I have read and understood the [contribution guidelines](https://github.com/TeamNewPipe/NewPipe/blob/dev/.github/CONTRIBUTING.md).

### Affected version

dev nightly 1080

### Steps to reproduce the bug

1. Add some streams to a queue
2. Try to do "Enqueue next" on something to add it to the queue

### Expected behavior

Video/track/stream is added to the queue

### Actual behavior

Nothing happens (but the toast appears that says stream enqueued)

### Screenshots/Screen recordings

_No response_

### Logs

_No response_

### Affected Android/Custom ROM version

Android 9

### Affected device model

Samsung Galaxu S8 / Android 9 emulator

### Additional information

Others are able to reproduce on other android versions so I presume this is a regression that affects every version

This same root cause must be fixed before merging.
REVIEW_EOF
