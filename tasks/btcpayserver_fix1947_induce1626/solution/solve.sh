#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/Hosting/BTCpayMiddleware.cs`:

This pull request introduces the defect later reported as "Checkout URL incompatible with .onion". The
problem a user observed, and its root cause:

Having issue with .onion address for website. 
User loads a cart in tor browser and proceeds to checkout then our btcpayserver is selected. 
URL loads with invoice?id=
User selects the .onion redirect and 404 error is produced. 
When manually pulling the invoice up from the server side it uses a URL with /i/ in place of above. 
Copying this into tor brower and selecting .onion correctly displays the invoice.

This same root cause must be fixed before merging.
REVIEW_EOF
