# Code Review Task

You are a maintainer reviewing a pull request to the `duplicati/duplicati` repository.

**PR title:** Fix code review comments and other minor changes

**PR description / commit message:**

Fix code review comments and other minor changes

- Rename indexVolume to indexVolumeWriter in DataBlockProcessor to reduce
confusion.

- When flushing the remaining uploads, check the tasks for exceptions in
completion order rather than waiting for them all at once. If there is an
exception all other uploads are cancelled anyway.

- Remove setting the operation progress as Backup_WaitForUpload in the
BackendUploader since the BackupHandler sets it.

- Use an exception filter in BackendUploader.

- Use Options property MaxUploadPrSecond instead of getting the raw value.

## Working environment

The repository is checked out at `/app/duplicati` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
