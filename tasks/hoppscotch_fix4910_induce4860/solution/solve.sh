#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/hoppscotch-common/src/platform/std/kernel-interceptors/proxy/index.ts`:

This pull request introduces the defect later reported as "[bug]: Proxy interceptor broken since 2025.2". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched existing issues and this bug hasn't been reported yet

### Current behavior

Since version 2025.2 proxy interceptor is not working anymore.

### Steps to reproduce

- Go to https://hoppscotch.io/
- Select proxy interceptor in settings
- Send a request to any URL (except echo.hoppscotch.io)
- It fails with network_fail


### Logs and Screenshots

```shell

```

### Environment

Production

### Hoppscotch Version

Cloud

### Interceptor

Proxy - Web App

### Browsers Affected

Not browser-specific

### Operating System

MacOS

### Additional Information

It seems to fail because RESTResponse.toResponse expects a Uint8Array and gets an ArrayBuffer.

This same root cause must be fixed before merging.
REVIEW_EOF
