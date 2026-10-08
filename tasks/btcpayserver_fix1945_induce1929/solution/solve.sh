#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/Views/Shared/LayoutPartials/SyncModal.cshtml`:

This pull request introduces the defect later reported as "When collapsed, the sync window blocks the version text in the footer". The
problem a user observed, and its root cause:

**Describe the bug**
New collapsible sync window is awesome, but we should just make sure it doesn't block the version in the footer.
While you can still the version via various hacks, sometimes a first-time user whoes node is syncing may have a question or a bug report that would require their version to be futher troubleshoot. 

**To Reproduce**
Steps to reproduce the behavior:
1. Minimize sync window while it's syncing
2. Scroll to the bottom to check version
3. It's hard to see the version

**Expected behavior**
A person should be able to see the version at a bottom even though the node is syncing.

**Screenshots**
![Screenshot 2020-10-05 at 18 41 14](https://user-images.githubusercontent.com/36959754/95107866-c46e6980-073a-11eb-8913-19663a66591a.png)


**Your BTCPay Environment (please complete the following information):** 
- BTCPay Server Version [available in the right bottom corner of footer] Woooot Sir my window is blocking a version 😄  jk it's v1.0.5.6
- Deployment Method: [e.g. Docker, Manual, Third-Party-hoist] Docker
 - Browser [e.g. chrome, safari] - Chrome, 13" MacAir

This same root cause must be fixed before merging.
REVIEW_EOF
