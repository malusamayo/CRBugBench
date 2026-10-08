#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/nodes-base/nodes/Stripe/Stripe.node.ts`:

This pull request introduces the defect later reported as "Stripe's "Get All" charges operation always returns 10 items". The
problem a user observed, and its root cause:

**Describe the bug**
Apparently this is because n8n does not pass the "limit" parameter to the HTTP request.
![image](https://user-images.githubusercontent.com/17855450/138441216-230ab4de-8857-46f6-b30d-780af2bb13e7.png)

**To Reproduce**
Steps to reproduce the behavior:
1. Add a stripe node
2. In resource, select "Charge"
3. In operation, select "Get All"
4. Run node

**Expected behavior**
It should return 50 items, but instead it always returns 10 items.

**Environment (please complete the following information):**
 - Ubuntu
 - n8n Version: 0.144.0
 - Node.js Version: 14.16.0
 - Database system: SQlite
 - Operation mode: own

**This will probably happen in other Get All operations too**

This same root cause must be fixed before merging.
REVIEW_EOF
