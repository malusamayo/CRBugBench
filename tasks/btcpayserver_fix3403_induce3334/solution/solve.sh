#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/wwwroot/paybutton/paybutton.js`:

This pull request introduces the defect later reported as "Pay Button request failed Please fix following errors: The Currency field is required.". The
problem a user observed, and its root cause:

**Issue:**
When creating a payment button the currency field appears not to be passing along.

**Steps to reproduce:**

1. Go to Payments > Pay button
2. Fill out the following details:
- Price 
- Currency 
- Checkout Description 
- Order ID
3. Click on the preview button or the alternative link
4. See error
<img width="977" alt="Screenshot 2022-01-31 at 15 24 48" src="https://user-images.githubusercontent.com/10710104/151811019-bc7c0e7d-30aa-49c7-8afc-cbeec857ec73.png">

This same root cause must be fixed before merging.
REVIEW_EOF
