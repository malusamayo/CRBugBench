# Code Review Task

You are a maintainer reviewing a pull request to the `btcpayserver/btcpayserver` repository.

**PR title:** Make Sync Modal remember collapsed state (#1929)

**PR description / commit message:**

Make Sync Modal remember collapsed state (#1929)

* Make Sync Modal remeber collapsed state

This makes the sync modal use the bootstrap collapse component instead of animatecss. It also removed animatecss as it seemed to be only used there.  Also, it will now remember if you collapsed it between page loads which since the new eth stuff keeps asking to configure it on my dev env.

* Sync modal improvements

- Use chevron icon and indicate toggle state
- Smooth opening animation by toggling element without padding
- Better modal content padding
- Run JS immediately to prevent flickering

Co-authored-by: Dennis Reimann <mail@dennisreimann.de>

## Working environment

The repository is checked out at `/app/btcpayserver` at this PR's **base commit**
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
