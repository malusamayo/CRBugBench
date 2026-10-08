#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `mitmproxy/tools/web/app.py`:

This pull request introduces the defect later reported as "`403 Authentication Required` on mitmweb after a short while". The
problem a user observed, and its root cause:

### Problem Description

I'm running mitmweb to observe the requests and responses. After a short while, the UI stops giving new results, and refreshing the page gives "403 Authentication Required" and a password prompt.

It seems whatever default `web_password` is used, it expires the session really fast.

Is there no way to disable the logout?

I tried passing a custom `web_password=foo` but that just resulted in the web UI opening to the password dialog on launch, instead of the flow list, as before, which is frustrating.

### System Information

```raw

```

### Checklist

- [x] This bug affects the [latest mitmproxy release](https://github.com/mitmproxy/mitmproxy/releases).

This same root cause must be fixed before merging.
REVIEW_EOF
