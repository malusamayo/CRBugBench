# Code Review Task

You are a maintainer reviewing a pull request to the `tock/tock` repository.

**PR title:** kernel: schedule upcall, bool -> Result

**PR description:**

### Pull Request Overview

Following up on https://github.com/tock/tock/pull/2639#discussion_r664131701, this looks at changing the signature of scheduling upcalls to return a `Result` rather than a simple `bool`.

To start, this just looks at the kernel interfaces (i.e. this introduces 110 "unused Result" warnings in capsule code right now).

One interesting thing surfaced is that IPC does use the result of upcall scheduling to report to the IPC sender whether the receiver was scheduled successfully or not. Previously, this treated scheduling the null upcall as a failure. I'm not 100% sure that's right though -- a receiver has every right (although it would be odd) to ignore notifications. I used the new error code granularity to separate out this case right now; though maybe the best solution is to simply bubble up the error all the way to userspace for IPC.

---

This commit just changes the kernel interfaces, it does not address
all of the new unused Result warnings at all of the capsule scheduling
call sites.

### Testing Strategy

N/A yet [compiling]

### TODO or Help Wanted

Do these error code assignments make sense?

Should IPC treat scheduling a null upcall as an error or success?

Should I move forward with the rest of the capsules?

### Documentation Updated

- [x] Updated the relevant files in `/docs`, or no updates are required.

### Formatting

- [] Ran `make prepush`.

## Working environment

The repository is checked out at `/app/tock` at this PR's **base commit**
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
