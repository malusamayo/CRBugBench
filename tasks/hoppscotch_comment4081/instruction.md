# Code Review Task

You are a maintainer reviewing a pull request to the `hoppscotch/hoppscotch` repository.

**PR title:** fix(sh-admin): saving changes to server configurations post a failed attempt will require a page reload in dashboard

**PR description:**

### Ticket
Closes HFE-515

### Description
This PR addresses an issue on the admin dashboard where, when an attempt is made to change server configurations and a mutation error has occurred, after the relevant error toast is displayed, any subsequent attempts to save additional changes to configs fail to trigger the server restart and confirmation modals. This prevents users from making further changes unless they reload the page. This issue is resolved in this PR.

### Checks
<!-- Make sure your pull request passes the CI checks and do check the following fields as needed - -->
- [x] My pull request adheres to the code style of this project
- [ ] My code requires changes to the documentation
- [ ] I have updated the documentation as required
- [x] All the tests have passed

## Working environment

The repository is checked out at `/app/hoppscotch` at this PR's **base commit**
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
