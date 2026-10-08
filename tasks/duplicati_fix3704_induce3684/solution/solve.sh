#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Duplicati/Library/Main/Operation/Backup/DataBlockProcessor.cs`:

This pull request introduces the defect later reported as "Backups appear to be missing some index files". The
problem a user observed, and its root cause:

## Environment info
<!-- Please include some relevant information about your environment. -->
<!-- For "Backend", please indicate the backup destination (e.g. Amazon S3, OneDrive, FTP, WebDAV, local). -->
- **Duplicati version**: 2.0.4.16
- **Operating system**: All
- **Backend**: All

## Description
It appears that with version 2.0.4.16, not all index files are uploaded in an initial backup.  Version 2.0.4.15 does not exhibit this behavior.  I suspect that this may be related to the new parallel upload code.

## Steps to reproduce
<!-- List the steps to reproduce the bug if possible. -->
1. Configure a new backup to a local backend, where the source contains a single 200MB file with random data.  Use all default options, except enable logging to a file, and capture Information logs.
2. Run the initial backup.  No errors are reported, and the log should contain entries like:
```
2019-03-30 13:25:14 -07 - [Information-Duplicati.Library.Main.Controller-StartingOperation]: The operation Backup has started
2019-03-30 13:25:15 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: List - Started:  ()
2019-03-30 13:25:15 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: List - Completed:  ()
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-bcc55131388134c44b07148a8908335d9.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-b4283dca35de24e339801b3893372ffc3.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-b13c556f0f7ac4b28a926cbe9983d9684.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-bcc55131388134c44b07148a8908335d9.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-b4283dca35de24e339801b3893372ffc3.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-b47aa2ea89dcb4acfbc45a777d8981bd8.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-b13c556f0f7ac4b28a926cbe9983d9684.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-b31e554a197ae4c81909efaeef1e8ff67.dblock.zip.aes (465.47 KB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-b31e554a197ae4c81909efaeef1e8ff67.dblock.zip.aes (465.47 KB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-b47aa2ea89dcb4acfbc45a777d8981bd8.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-i306d21d0761d44f79bcfbdf2e399e960.dindex.zip.aes (65.20 KB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-i306d21d0761d44f79bcfbdf2e399e960.dindex.zip.aes (65.20 KB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-20190330T202514Z.dlist.zip.aes (957 bytes)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-20190330T202514Z.dlist.zip.aes (957 bytes)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-StartCheck]: Start checking if backups can be removed
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-FramesAndIntervals]: Time frames and intervals pairs: 7.00:00:00 / Keep all, 90.00:00:00 / 1.00:00:00, 365.00:00:00 / 7.00:00:00, Unlimited / 31.00:00:00
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-BackupList]: Backups to consider: 
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-BackupsToDelete]: Backups outside of all time frames and thus getting deleted: 
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.Operation.DeleteHandler:RetentionPolicy-AllBackupsToDelete]: All backups to delete: 
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.Operation.DeleteHandler-DeleteResults]: No remote filesets were deleted
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.Database.LocalDeleteDatabase-CompactReason]: Compacting not required
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: List - Started:  ()
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: List - Completed:  (7 bytes)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Get - Started: duplicati-20190330T202514Z.dlist.zip.aes (957 bytes)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Get - Completed: duplicati-20190330T202514Z.dlist.zip.aes (957 bytes)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Get - Started: duplicati-i306d21d0761d44f79bcfbdf2e399e960.dindex.zip.aes (65.20 KB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Get - Completed: duplicati-i306d21d0761d44f79bcfbdf2e399e960.dindex.zip.aes (65.20 KB)
2019-03-30 13:25:27 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Get - Started: duplicati-b13c556f0f7ac4b28a926cbe9983d9684.dblock.zip.aes (50.00 MB)
2019-03-30 13:25:28 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Get - Completed: duplicati-b13c556f0f7ac4b28a926cbe9983d9684.dblock.zip.aes (50.00 MB)
```
3. Without modifying the sources, run another backup.  Now, we can observe entries like the following in the log:

<pre>
2019-03-30 13:16:32 -07 - [Information-Duplicati.Library.Main.Controller-StartingOperation]: The operation Backup has started
2019-03-30 13:16:32 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: List - Started:  ()
2019-03-30 13:16:32 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: List - Completed:  (7 bytes)
<b>2019-03-30 13:16:32 -07 - [Information-Duplicati.Library.Main.Operation.Backup.RecreateMissingIndexFiles-RecreateMissingIndexFile]: Re-creating missing index file for duplicati-bbcef31dce5124b7c98a5807e16bb2c21.dblock.zip.aes
2019-03-30 13:16:32 -07 - [Information-Duplicati.Library.Main.Operation.Backup.RecreateMissingIndexFiles-RecreateMissingIndexFile]: Re-creating missing index file for duplicati-bca6a85b647b348a4871663f0a29f35e6.dblock.zip.aes
2019-03-30 13:16:33 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Started: duplicati-iaef9e53f34674b3b8afda06aae5c20ce.dindex.zip.aes (18.01 KB)
2019-03-30 13:16:33 -07 - [Information-Duplicati.Library.Main.BasicResults-BackendEvent]: Backend event: Put - Completed: duplicati-iaef9e53f34674b3b8afda06aae5c20ce.dindex.zip.aes (18.01 KB)
2019-03-30 13:16:33 -07 - [Information-Duplicati.Library.Main.Operation.Backup.RecreateMissingIndexFiles-RecreateMissingIndexFile]: Re-creating missing index file for du

This same root cause must be fixed before merging.
REVIEW_EOF
