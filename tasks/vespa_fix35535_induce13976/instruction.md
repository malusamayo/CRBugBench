# Code Review Task

You are a maintainer reviewing a pull request to the `vespa-engine/vespa` repository.

**PR title:** When allowing weakly consistent get you might try to access attributes that are not yet fully populated. Now we prevent accessing uninitialized memory by guarding each attribute by checking its current commited docid limit. If not we just clear the field. Also avoid doing an inefficient Field -> string -> Field lookup.

**PR description / commit message:**

When allowing weakly consistent get you might try to access attributes that are not yet fully populated.
Now we prevent accessing uninitialized memory by guarding each attribute by checking its current commited docid limit.
If not we just clear the field.
Also avoid doing an inefficient Field -> string -> Field lookup.

## Working environment

The repository is checked out at `/app/vespa` at this PR's **base commit**
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
