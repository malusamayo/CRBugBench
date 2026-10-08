#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Duplicati/Server/webroot/ngax/scripts/services/EditUriBackendConfig.js`:

This pull request introduces the defect later reported as "Translation of description on warning dialog on a backup task with Microsoft Office 365 Group is only partially applied". The
problem a user observed, and its root cause:

<!-- Thank you for taking the time to submit an issue using this template. By following the instructions and filling out the sections below, you will help the developers get the necessary information to fix your issue. You may remove sections that aren't relevant to your particular case. You can also preview your report before submitting it. -->
<!-- Please note that the issues are a tool for Duplicati developers. If you post here, you are supposed to want to help the project by providing timely information on your problem so it can be fixed. If this is not the case, please use the forum instead -->


<!-- Please search to see if an issue has already been created for your report. -->
<!-- Replace the empty checkbox [ ] below with a checked one [x] if you already searched for duplicate bugs. -->
- [x] I have searched open and closed issues for duplicates.
- [ ] I have searched the [forum](https://forum.duplicati.com) for related topics.

----------------------------------------

## Environment info
<!-- Please include some relevant information about your environment. -->
<!-- For "Backend", please indicate the backup destination (e.g. Amazon S3, OneDrive, FTP, WebDAV, local). -->
- **Duplicati version**: Debug
- **Operating system**: irrelevant
- **Backend**: Microsoft Office 365 Group

## Description
<!-- Describe the issue that you are experiencing below. -->
As title says, translation of description on warning dialog on a backup task with Microsoft Office 365 Group is only partially applied.

## Steps to reproduce
<!-- List the steps to reproduce the bug if possible. -->
1. Set up a backup task with Microsoft Office 365 Group
2. Change the UI language into Dutch
3. Select the task
4. Click "Bewerken..."
5. Select "Doel"
6. Select "Microsoft Office 365 Groep"
7. Input something to the AuthID field
8. Click "Test verbindung"
9. Confirm the warning message is displayed

<!-- For "Actual result", describe what happens after you run the steps above (i.e. buggy behavior). -->
<!-- For "Expected result", describe what should happen after you run the steps above (i.e. corrected behavior). -->
- **Actual result**: the warning message is partially displayed in Dutch.

- **Expected result**: it should be completely displayed in Dutch, as translated here: https://github.com/duplicati/duplicati/blob/2569f94de8b3d1427554c8aeb381579560945603/Localizations/webroot/localization_webroot-nl_NL.po#L3260

## Screenshots
<!-- Make it easier to get your point across with screenshots. -->
<!-- You can drag & drop or paste your images below. -->

![1](https://github.com/user-attachments/assets/8a13e4fd-3df8-4aca-b2b6-29f72b9de0b3)

## Debug log
<!-- Posting a debug log helps the developers find and fix your particular issue more easily. -->
<!-- Please wrap your code in code blocks with triple back-ticks to increase readability. -->

This same root cause must be fixed before merging.
REVIEW_EOF
