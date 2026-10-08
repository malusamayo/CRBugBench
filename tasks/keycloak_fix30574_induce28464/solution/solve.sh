#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `js/apps/admin-ui/src/realm-settings/GeneralTab.tsx`:

This pull request introduces the defect later reported as "Frontend URL realm setting label incorrectly shows as HTML Display Name". The
problem a user observed, and its root cause:

### Before reporting an issue

- [X] I have read and understood the above terms for submitting issues, and I understand that my issue may be closed without action if I do not follow them.

### Area

admin/ui

### Describe the bug

The label for the Frontend URL realm setting shows as HTML Display Name, duplicating the previous field's label.

![image](https://github.com/keycloak/keycloak/assets/169765328/fe61b015-4cfb-43e2-955d-e9dedf4593bd)


### Version

25.0.0

### Regression

- [ ] The issue is a regression

### Expected behavior

The label should be "Frontend URL"

### Actual behavior

The label is "HTML Display Name"

### How to Reproduce?

View Realm Settings for any realm in the admin console

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
