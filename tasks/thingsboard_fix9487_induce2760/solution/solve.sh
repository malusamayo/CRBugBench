#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ui-ngx/src/app/core/auth/auth.service.ts`:

This pull request introduces the defect later reported as "[Bug] Reflected html injection via login error". The
problem a user observed, and its root cause:

**Describe the bug**
The parameter `loginError` is vulnerable to HTML injection which lead to open redirect

**Your Server Environment**
<!-- 🔅🔅🔅🔅🔅🔅🔅 Choose one of the following or write your own 🔅🔅🔅🔅🔅🔅🔅-->
* demo.thingsboard.io (as example)

**Your Client Environment**
<!-- 🔅🔅🔅🔅🔅🔅🔅 Choose one of the following or write your own 🔅🔅🔅🔅🔅🔅🔅-->
**Desktop (please complete the following information):**

* OS: any
* Browser: any
* Version: latest

**Smartphone (please complete the following information):**
(same results)

**Your Device**
N/A

**To Reproduce**
Steps to reproduce the behavior:
1. Go to 'https://demo.thingsboard.io/login?loginError=%3Ca/href=https://google.fr%3Etest'
2. Login error dialog form will popup with the payload rendered as <a> html element
3. Click it and will redirect to google.fr

**Additional context**
This was reported to us as part of a Bug bounty program by Twitter user wonderu360.

This same root cause must be fixed before merging.
REVIEW_EOF
