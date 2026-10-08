#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `services/src/main/java/org/keycloak/services/resources/admin/RealmLocalizationResource.java`:

This pull request introduces the defect later reported as "Admin console throwing 403 error when logged in for sub realm using local admin user". The
problem a user observed, and its root cause:

### Before reporting an issue

- [X] I have searched existing issues
- [X] I have reproduced the issue with the [latest nightly release](https://github.com/keycloak/keycloak/releases/tag/nightly)

### Area

admin/ui admin/console

### Describe the bug

Login into admin console using user which is not having admin role into sub realm, throws {"error":"unknown_error"} with rendering issues on console.

Request URL:
https://<host>/auth/admin/realms/master/localization/en
Request Method:
GET
Status Code:
403


![image](https://github.com/keycloak/keycloak/assets/46847027/09597aea-7db3-4981-8a3e-6b9a4df35afa)


### Version

22.0.1

### Expected behavior

Earlier we were on 18.0.2 version and this issue was not present. After changing to 22.0.1 image resulted this issue.
Even it is replicable on base image provided  from keycloak.
It should not result into any exception after logging into console with non admin roles user.

### Actual behavior

Console is in incorrect format and throwing network error.

![image](https://github.com/keycloak/keycloak/assets/46847027/eb577249-bfd2-4a6c-84ad-48628e9b8b1a)

![image](https://github.com/keycloak/keycloak/assets/46847027/f4601869-998a-45ad-9113-8dc544963856)



### How to Reproduce?

1)Create a realm other than master
2)Add user as testadmin in master realm and in other created realm as well.
3)Assign realm-admin role to testadmin user in other realm.
4)Try to login into console using testadmin.
5)It will show up console with incorrect format
6)Inspect page and you can observe the error mentioned above.

### Anything else?

Have searched for this issue in keycloak community but didn't find any issue related to this. If someone finds it or knows if it is already fixed, please comment here with details.

This same root cause must be fixed before merging.
REVIEW_EOF
