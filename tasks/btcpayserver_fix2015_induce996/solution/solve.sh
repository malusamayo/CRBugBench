#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/Views/Invoice/Checkout.cshtml`:

This pull request introduces the defect later reported as "Payment Request redirect unviewable page". The
problem a user observed, and its root cause:

**Describe the bug**
When the store settings policy "redirect invoice to redirect url automatically after paid" policy is enabled, it takes you to an unviewable page. Reloading the page will return to the payment request.

**To Reproduce**
Steps to reproduce the behavior:
1. Store Settings > Checkout Experience > Enable: Redirect invoice to redirect url automatically after paid
2. Create & pay invoice in Payment Request
3. See can't open page error
4. Refresh page, Payment Request shows

**Expected behavior**
It does not take reload to view the payment request, or disable this for feature for payment request invoices.

**Screenshots**
![image](https://user-images.githubusercontent.com/39231115/97070044-3d225200-1592-11eb-8124-0904d8c0585d.png)


**Your BTCPay Environment (please complete the following information):**
- BTCPay Server Version: Regtest master, v1.0.5.8
- Deployment Method: Local Dev & LunaNode
- Browser: Firefox, chrome

This same root cause must be fixed before merging.
REVIEW_EOF
