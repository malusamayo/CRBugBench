#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/wwwroot/checkout/checkout.js`:

This pull request introduces the defect later reported as "Bug: Unable to copy fiat amount in Invoice Checkout". The
problem a user observed, and its root cause:

Clicking on the fiat amount copy `NaN` in the clipboard (Total Fiat and Exchange Rate)

<img width="1247" height="1076" alt="Image" src="https://github.com/user-attachments/assets/3006729e-eff2-46e7-bd8d-c76314276584" />

This same root cause must be fixed before merging.
REVIEW_EOF
