# Code Review Task

You are a maintainer reviewing a pull request to the `redis/redis-py` repository.

**PR title:** MINID and LIMIT support for xtrim

**PR description:**

Part of the new commands in #1434

Fixed #1454 

### Pull Request check-list

_Please make sure to review and check all of these items:_

- [X] Does `$ tox` pass with this change (including linting)?
- [X] Do the CI tests pass with this change (enable it first in your forked repo and wait for the github action build to finish)?
- [X] Is the new or changed code fully tested?
- [X] Is a documentation update included (if this change modifies existing APIs, or introduces new ones)?

_NOTE: these things are not required to open a PR and can be done
afterwards / while the PR is open._

### Description of change

Adds support for the new minid, and limit args to xtrim.  To ensure no API changes broke anything both minid and limit arguments were added to the end of the function.

## Working environment

The repository is checked out at `/app/redis-py` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
