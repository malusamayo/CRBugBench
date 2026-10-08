#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/Controllers/AppsPublicController.cs`:

This pull request introduces the defect later reported as "Automatic app label gives 404". The
problem a user observed, and its root cause:

**Describe the bug**
When you click on an `i` tooltip for the automatic labels added in #1916 for the `app` it gives 404, because the URL goes to 
apps/xyz instead apps/xyz/pos for example, so app type is not included which leads to 404.


**To Reproduce**
Steps to reproduce the behavior:
1. Receive a payment through the pos app
2. Go to Wallets and click on the `i` for the app
4. See 404 page

**Expected behavior**
It should open a link from the app.

**Screenshots**
![image](https://user-images.githubusercontent.com/36959754/96374872-c6dab580-1175-11eb-9515-4391c144d8d6.png)

**Your BTCPay Environment (please complete the following information):**
- BTCPay Server Version [available in the right bottom corner of footer]  1.0.5.8
- Deployment Method: [e.g. Docker, Manual, Third-Party-hoist]: Docker

**Logs (if applicable)**
Basic logs can be found in Server Settings > Logs. More logs https://docs.btcpayserver.org/Troubleshooting/#2-looking-through-the-logs

**Additional context**
I'm not sure what's expected behavior here. The `x` (remove the label) doesn't work (if the expected behavior is to not remove this then we shouldn't have the `x`.

This same root cause must be fixed before merging.
REVIEW_EOF
