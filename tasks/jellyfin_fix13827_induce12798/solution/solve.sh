#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Jellyfin.Server.Implementations/Item/BaseItemRepository.cs`:

This pull request introduces the defect later reported as "[EfJellyfin.db] Episodes will not show under the Season UI". The
problem a user observed, and its root cause:

### This issue respects the following points:

- [x] This is a **bug**, not a question or a configuration issue; Please visit our forum or chat rooms first to troubleshoot with volunteers, before creating a report. The links can be found [here](https://jellyfin.org/contact/).
- [x] This issue is **not** already reported on [GitHub](https://github.com/jellyfin/jellyfin/issues?q=is%3Aopen+is%3Aissue) _(I've searched it)_.
- [x] I'm using an up to date version of Jellyfin Server stable, unstable or master; We generally do not support previous older versions. If possible, please update to the latest version before opening an issue.
- [x] I agree to follow Jellyfin's [Code of Conduct](https://jellyfin.org/docs/general/community-standards.html#code-of-conduct).
- [x] This report addresses only a single issue; If you encounter multiple issues, kindly create separate reports for each one.

### Description of the bug

After applying the EFCore upgrade Episodes will now longer show:

- episodes dont show under season view.
- related: in the series view, seasons also don't show the number of episodes. they show a "tick" instead.
- this persists even after deleting the libraries and trying to re-scan in the content

### Reproduction steps

1. Migrate to library.db with a database that contains a series
2. open webUI for that series and select any Season

### What is the current _bug_ behavior?

The UI shows no episodes for the selected Season

### What is the expected _correct_ behavior?

UI shows episodes of the selected Season

### Jellyfin Server version

Unstable

### Specify commit id

_No response_

### Specify unstable release number

_No response_

### Specify version number

_No response_

### Specify the build version

EFCore

### Environment

```markdown
- OS:
- Linux Kernel:
- Virtualization:
- Clients:
- Browser:
- FFmpeg Version:
- Playback Method:
- Hardware Acceleration:
- GPU Model:
- Plugins:
- Reverse Proxy:
- Base URL:
- Networking:
- Storage:
```

### Jellyfin logs

```shell
TDB
```

### FFmpeg logs

```shell

```

### Client / Browser logs

_No response_

### Relevant screenshots or videos

_No response_

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
