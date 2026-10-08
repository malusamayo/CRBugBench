#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Duplicati/Server/webroot/ngax/less/style.less`:

This pull request introduces the defect later reported as "Restore file tree icon problem". The
problem a user observed, and its root cause:

<!-- Thank you for taking the time to submit an issue using this template. By following the instructions and filling out the sections below, you will help the developers get the necessary information to fix your issue. You may remove sections that aren't relevant to your particular case. You can also preview your report before submitting it. -->
<!-- Love Duplicati? Please consider supporting our collective at https://opencollective.com/duplicati/donate. -->

<!-- Please search to see if an issue has already been created for your report. -->
<!-- Replace the empty checkbox [ ] below with a checked one [x] if you already searched for duplicate bugs. -->
- [X] I have searched open and closed issues for duplicates.

----------------------------------------

## Environment info
<!-- Please include some relevant information about your environment. -->
<!-- For "Backend", please indicate the backup destination (e.g. Amazon S3, OneDrive, FTP, WebDAV, local). -->
- **Duplicati version**: 2.0.5.110

## Description
<!-- Describe the issue that you are experiencing below. -->
When browsing for files to restore, the "wait" animated icon (while the tree is loading) s now not shown properly.  Looks like it's the wrong scale perhaps.

I first noticed this when I installed 2.0.5.110, but it's possible it was present in earlier builds.

## Screenshots
![Untitled](https://user-images.githubusercontent.com/39164691/91103539-90266a00-e620-11ea-89c5-fcf708b92f78.png)

This same root cause must be fixed before merging.
REVIEW_EOF
