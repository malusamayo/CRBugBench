#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Duplicati/Library/Main/Database/LocalBugReportDatabase.cs`:

This pull request introduces the defect later reported as ""Create bug report ..." results in syntax error". The
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
- **Duplicati version**: 2.0.4.16
- **Operating system**: Windows 10
- **Backend**: "Local folder or drive" (doesn't matter, I guess)

## Description
<!-- Describe the issue that you are experiencing below. -->
The option "Create bug report ..." doesn't work at all.

## Steps to reproduce
<!-- List the steps to reproduce the bug if possible. -->
1. Open the options for a backup.
2. Click "Create bug report ..."


<!-- For "Actual result", describe what happens after you run the steps above (i.e. buggy behavior). -->
<!-- For "Expected result", describe what should happen after you run the steps above (i.e. corrected behavior). -->
- **Actual result**:
I get an error message:
`Error while running JOBNAME`
`SQL logic error or missing database near ")": syntax error`

Here's the exception I found in the logs:
```
System.Data.SQLite.SQLiteException (0x80004005): SQL logic error or missing database
near ")": syntax error
   at System.Data.SQLite.SQLite3.Prepare(SQLiteConnection cnn, String strSql, SQLiteStatement previous, UInt32 timeoutMS, String& strRemain)
   at System.Data.SQLite.SQLiteCommand.BuildNextCommand()
   at System.Data.SQLite.SQLiteDataReader.NextResult()
   at System.Data.SQLite.SQLiteDataReader..ctor(SQLiteCommand cmd, CommandBehavior behave)
   at System.Data.SQLite.SQLiteCommand.ExecuteReader(CommandBehavior behavior)
   at System.Data.SQLite.SQLiteCommand.ExecuteNonQuery(CommandBehavior behavior)
   at Duplicati.Library.Main.Database.ExtensionMethods.ExecuteNonQuery(IDbCommand self, Boolean writeLog, String cmd, Object[] values)
   at Duplicati.Library.Main.Database.LocalBugReportDatabase.Fix()
   at Duplicati.Library.Main.Operation.CreateBugReportHandler.Run()
   at Duplicati.Library.Main.Controller.RunAction[T](T result, String[]& paths, IFilter& filter, Action`1 method)
   at Duplicati.Library.Main.Controller.CreateLogDatabase(String targetpath)
   at Duplicati.Server.Runner.Run(IRunnerData data, Boolean fromQueue)
```

- **Expected result**:
Something without an error

This same root cause must be fixed before merging.
REVIEW_EOF
