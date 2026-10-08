#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `core/src/main/java/bisq/core/api/model/PaymentAccountForm.java`:

This pull request introduces the defect later reported as "extraData in PaymentAccount needs to be excluded in PaymentAccountForm". The
problem a user observed, and its root cause:

currently this field is causing the payment account form to fail completely
reason is its included in all forms (since it's part of PaymentAccount), but not handled at invokeSetterMethod:
https://github.com/bisq-network/bisq/blob/6db1c9e21b6ffa0ecf2ae09134d9b3168ee47786/core/src/main/java/bisq/core/api/model/PaymentAccountTypeAdapter.java#L261-L270

since this is a map, and form only supports string or int right now, I assume this is field needs to be excluded

This same root cause must be fixed before merging.
REVIEW_EOF
