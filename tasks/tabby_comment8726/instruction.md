# Code Review Task

You are a maintainer reviewing a pull request to the `Eugeny/tabby` repository.

**PR title:** Various fix/enhancement about Profiles

**PR description:**

Hi @Eugeny, hope you're doing great !

I'm currently working on a small list of issues which are related to Profiles and that I want to try to address. I'm opening this draft to keep track on my progress, and I will probably ask for your opinion on the way to implement some feature if you are ok with that.

Resolve #7057 4dedbbc25a8f09d69630bbe9de81be5824fa0fbf: As `recentProfiles` already are sort by most recent used profile, I simply add weight on the `SelectorOption` based on the profile index in the `recentProfiles` array.


Fix #8709 d57757c66cad3427eb8e11c88f1731fe5326e8a7: I made a small mistake previously. The weight I added on the `Connect to` selector option were not used in the `onFilterChange` function in `selectorModal` component.

Edit 11/08:
Resolve #3999 695c5ba67067fd7f113e3b50af9266964f255040 : allow users to specify settings on profile group for each profile provider

Edit 12/08
Resolve #7265 f369b140c6a0f9cbbf0d2e477f085189654ebd66 : added a button to reset global default profile settings and to restore inherited settings on a group.

Edit 15/08
Fix #8065 a9c63b53059c842e31b52d1226aec78c6372fcc3: This commit fixes the issue #8065. Resolve the returned Promise in [showProfileSelector](https://github.com/Eugeny/tabby/blob/a9c63b53059c842e31b52d1226aec78c6372fcc3/tabby-core/src/services/profiles.service.ts#L242C5-L242C24) when selector modal is dismissed.

## Working environment

The repository is checked out at `/app/tabby` at this PR's **base commit**
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
