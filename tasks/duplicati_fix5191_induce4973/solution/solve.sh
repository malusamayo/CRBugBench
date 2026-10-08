#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Duplicati/Server/webroot/ngax/scripts/services/EditUriBuiltins.js`:

This pull request introduces the defect later reported as "Not working anymore auth_username ignored OpenStack v3 Infomaniak  (2.0.8.1_beta_2024-05-07)". The
problem a user observed, and its root cause:

- [x] I have searched open and closed issues for duplicates.
- [x] I have searched the [forum](https://forum.duplicati.com) for related topics.

----------------------------------------

## Environment info
<!-- For "Backend", please indicate the backup destination (e.g. Amazon S3, OneDrive, FTP, WebDAV, local). -->
- **Duplicati version**: 2.0.8.1_beta_2024-05-07
- **Operating system**: Windows 11 23H2
- **Backend**: Infomaniak

## Description
Using Duplicati 2.0.7.1 with Infomaniak without issues.
**Process**: always using the user and password provided by Infomaniak
**After the update**, I wanted to change the filters and now it seems Duplicati is not able to save auth-username and auth-password anymore. Testing connextion displays **_"Failed to connect: Missing required option: auth-username"_**. I've decided to add the missing fields in _Advanced options_ but the test cx replies _(502) invalid gateway_.
**Please note**

- if I use the command line (from a backup config file), everything is OK
- if I use OneDrive with token, everything is OK

## Steps to reproduce
1. upgrade from  2.0.7.1 to 2.0.8.1_beta
2. Just edit the Backup task and go on Test connexion: failed.

- **Actual result**:
The connection is KO (according to the process I've described)
- **Expected result**:
The connection should be OK, ofc

## Debug log
Where are the logs ?
Nothing in %LOCALAPPDATA%\Duplicati

Thank you for your investigation

Best regards
EJB

This same root cause must be fixed before merging.
REVIEW_EOF
