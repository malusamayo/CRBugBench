#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `GitUI/Avatars/AvatarDownloader.cs`:

This pull request introduces the defect later reported as "Avatar not loading behind a corporate proxy (HTTP 407 Proxy Authentication Required)". The
problem a user observed, and its root cause:

### Environment

- GitExtensions version: 4.2.1
- GIT version: 2.43.2
- OS version: Windows 10 22H2
- .NET version: .NET 6.0.27


### Issue description

Avatars don't load when behind a corporate proxy requiring auth (HTTP 407 Proxy Authentication Required)

### Steps to reproduce

Get behind a corporate proxy
Display avatars, you only get the mystery person and the corporate proxy logs 407 Proxy Authentication Required


### Did this work in previous version of GitExtensions?

Yes, it works at least in v2.51

### Diagnostics

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
