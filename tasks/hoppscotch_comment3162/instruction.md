# Code Review Task

You are a maintainer reviewing a pull request to the `hoppscotch/hoppscotch` repository.

**PR title:** [feat] : Allow admins to revoke a team invite (HBE-230)

**PR description:**

<!--
Thanks for creating this pull request 🤗

Please make sure that the pull request is limited to one type (docs, feature, etc.) and keep it as small as possible. You can open multiple prs instead of opening a huge one.
-->

<!-- If this pull request closes an issue, please mention the issue number below -->
Closes # HBE-233

### Description
Currently Admins can view pending invitations for a team, but they can't revoke an invitation. This PR introduces a mutation to revoke a team invite by invite ID that will be used from the admin dashboard.

<!-- You can also choose to add a list of changes and if they have been completed or not by using the markdown to-do list syntax
- [ ] Not Completed
- [x] Completed
-->

### Checks
<!-- Make sure your pull request passes the CI checks and do check the following fields as needed - -->
- [x] My pull request adheres to the code style of this project
- [ ] My code requires changes to the documentation
- [ ] I have updated the documentation as required
- [x] All the tests have passed

### Additional Information
<!-- Any additional information like breaking changes, dependencies added, screenshots, comparisons between new and old behaviour, etc. -->
Testing Instructions:
- Create a team and invite users by email
- get pending invitations for the team by team ID
- use `revokeTeamInviteByAdmin` mutation with a invite ID

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
