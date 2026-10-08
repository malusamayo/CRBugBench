#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `js/apps/account-ui/src/account-security/SigningIn.tsx`:

This pull request introduces the defect later reported as "`My password` string in `Signing in` page not getting translated in `keycloak.v3 account` theme". The
problem a user observed, and its root cause:

### Before reporting an issue

- [ ] I have read and understood the above terms for submitting issues, and I understand that my issue may be closed without action if I do not follow them.

### Area

account/ui

### Describe the bug

`My password` string in `Signing in` page not getting translated to other languages. 

I update account UI language(locale) as Portuguese
add added in `messages_pt_BR.properties` file as  `password=Minha senha` but not reflecting in Account UI.  

<img width="737" alt="keycloak" src="https://github.com/user-attachments/assets/d5ea2ee7-5c92-45a9-b53c-54dd7aa72128">

This issue I faced in all languages.


### Version

v25.0.2

### Regression

- [ ] The issue is a regression

### Expected behavior

Need to convert selected language.

### Actual behavior

Not converting selected language.

### How to Reproduce?

Change `Select a locale` other than English
go to Signing in page and check `Basic authentication` lists

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
