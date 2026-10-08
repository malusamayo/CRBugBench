# Code Review Task

You are a maintainer reviewing a pull request to the `btcpayserver/btcpayserver` repository.

**PR title:** Plugins: Add authorization hook

**PR description:**

Makes the `PolicyRequirement` available to plugins.
Adds a filter hook to the authorization handlers, so that plugins can extend and leverage the existing authorization policies and permissions. Together with #3975 it also enables plugins to use the `permission` tag helper with custom policies.

Let's think a bit about how we want to name hooks and their argument classes. I opted for a verb-based approach for naming the filter (i.e. `handle-authorization-requirement`), because I think it describes the purpose of the hooks better (vs. something like `authorization-requirement-handler`). Wordpress seems to be inconsistent in that regard and they have a [mix of names](https://codex.wordpress.org/Plugin_API/Filter_Reference) for their filters.

For the argument class (which is also the type of the return value) I think it makes sense to have the type of hook in the name (i.e. `AuthorizationFilterHandle`).

Sidenote: In the long run I think we also need a way of documenting the hooks, their arguments and return values. Same goes for the UI extension points.

## Working environment

The repository is checked out at `/app/btcpayserver` at this PR's **base commit**
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
