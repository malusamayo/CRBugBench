#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Duplicati/Library/Main/Operation/DeleteHandler.cs`:

This pull request introduces the defect later reported as "Custom retention - backup set timestamps no longer shown in logs". The
problem a user observed, and its root cause:

<!-- Thank you for taking the time to submit an issue using this template. By following the instructions and filling out the sections below, you will help the developers get the necessary information to fix your issue. You may remove sections that aren't relevant to your particular case. You can also preview your report before submitting it. -->
<!-- Love Duplicati? Please consider supporting our collective at https://opencollective.com/duplicati/donate. -->

<!-- Please search to see if an issue has already been created for your report. -->
<!-- Replace the empty checkbox [ ] below with a checked one [x] if you already searched for duplicate bugs. -->
- [x] I have searched open and closed issues for duplicates.

----------------------------------------

## Environment info
<!-- Please include some relevant information about your environment. -->
<!-- For "Backend", please indicate the backup destination (e.g. Amazon S3, OneDrive, FTP, WebDAV, local). -->
- **Duplicati version**: 2.0.5.103
- **Operating system**: Windows 7
- **Backend**: Local disk

## Description
<!-- Describe the issue that you are experiencing below. -->
When a custom retention rule is in effect, backup set timestamps are no longer shown in the logs. Now only `Duplicati.Library.Main.ListResultFileset` is shown.  Example:

```
"2020-02-18 14:54:53 -08 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-BackupList]: Backups to consider: Duplicati.Library.Main.ListResultFileset, Duplicati.Library.Main.ListResultFileset, Duplicati.Library.Main.ListResultFileset",
"2020-02-18 14:54:53 -08 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-BackupsToDelete]: Backups outside of all time frames and thus getting deleted: ",
"2020-02-18 14:54:53 -08 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-AllBackupsToDelete]: All backups to delete: Duplicati.Library.Main.ListResultFileset, Duplicati.Library.Main.ListResultFileset",
```

2.0.5.1 beta and earlier versions did not have this issue:

```
"2020-02-18 11:02:51 -08 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-BackupList]: Backups to consider: 2/18/2020 7:00:00 AM, 2/18/2020 3:00:00 AM, 2/17/2020 11:00:00 PM, 2/17/2020 7:00:00 PM, 2/17/2020 3:00:00 PM, 2/17/2020 11:00:00 AM",
"2020-02-18 11:02:51 -08 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-BackupsToDelete]: Backups outside of all time frames and thus getting deleted: ",
"2020-02-18 11:02:51 -08 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-AllBackupsToDelete]: All backups to delete: 2/11/2020 11:00:00 AM",
```

Not sure if the problem started with 2.0.5.103 or if it was one of the earlier canaries after 2.0.5.1.

This same root cause must be fixed before merging.
REVIEW_EOF
