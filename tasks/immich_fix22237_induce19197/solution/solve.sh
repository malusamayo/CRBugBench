#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `mobile/lib/presentation/widgets/timeline/timeline.widget.dart`:

This pull request introduces the defect later reported as "[beta] Resizing timeline with “pinch” on mobile app causes timeline to jump to top.". The
problem a user observed, and its root cause:

### I have searched the existing issues, both open and closed, to make sure this is not a duplicate report.

- [x] Yes

### The bug

When pinching to resize the image tile layout on the iOS app main timeline, the location is reset to the top.

### The OS that Immich Server is running on

Ubuntu 24.01

### Version of Immich Server

v1.139.4

### Version of Immich Mobile App

v1.139.4

### Platform with the issue

- [ ] Server
- [ ] Web
- [x] Mobile

### Device make and model

iPhone 14

### Your docker-compose.yml content

```YAML
# Will provide on request - opening issue on mobile
```

### Your .env content

```Shell
# Will provide on request - opening issue on mobile
```

### Reproduction steps

1. Open iOS app
2. Scroll down to non-top location of timeline
3. Pinch “in” or “out” to resize the timeline grid.

### Relevant log output

```shell

```

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
