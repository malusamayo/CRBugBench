# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/efcore` repository.

**PR title:** Allow cascade delete timing to be configured

**PR description / commit message:**

Allow cascade delete timing to be configured

Fixes #10114

Allows timing cascade delete (i.e. delete of dependent on principal deletion) and delete orphans (i.e. delete of dependent on severing its relationship to the principal) to be configured as:
* Immediate: Dependents changed to Deleted immediately, or at least at the next DetectChanges
* OnSaveChanges: Dependents are not changed to Deleted until SaveChanges is called
* Never: Cascades don't happen automatically. They can be triggered by a new method: `context.ChangeTracker.CascadeChanges()`

The default for both has been changed to `Immediate` which is a breaking change, but likely a better default because:
* Auditing in overridden SaveChanges will now report anything that will be deleted
* Data binding will reflect the changes immediately

However, deleting orphans can be more difficult. This doesn't appear to be a major problem in EF Core because we don't aggressively graph shred, we don't typically have entities that handle their own fixup, and conceptual nulls still exist to allow transitionary states.

Note that EF6 does not support deleting orphans, which means the behavior here with both set to Immediate is not quite the same as the default behavior of EF6.

## Working environment

The repository is checked out at `/app/efcore` at this PR's **base commit**
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
