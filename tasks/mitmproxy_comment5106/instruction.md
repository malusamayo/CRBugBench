# Code Review Task

You are a maintainer reviewing a pull request to the `mitmproxy/mitmproxy` repository.

**PR title:** Support async hooks. Fixes #4207.

**PR description:**

#### Description

Add support for async hooks to AddonManager, enabling the proxy server to call hooks asynchronously. Uses `inspect.isawaitable` to ensure that existing sync hooks continue to work without any change. Fixes #4207.

The forking of `invoke_addon` and `trigger` is a little unfortunate, but both of these get called from sync contexts throughout mitmproxy (in particular, `trigger`s are often called from `command.command` handlers, which are all sync). To ensure that we don't accidentally invoke an async handler in such cases, this patch adds a check to throw an exception if an async handler gets invoked synchronously.

This is a first stab at async hook support. There are more things that *could* be done here, and I'd love to hear if either of them makes sense for this PR, or left for future work:

- ~Eliminate `concurrent` entirely, and possibly even the entire `reply` mechanism. This would be a significant, breaking API change. However, in almost every case, `async` hooks are better: async hooks are properly sequenced (even with respect to other sync hooks), races are essentially eliminated, and the behaviour is much more predictable. (It might be better to just deprecate `concurrent` now for future removal).~ Basically done: `concurrent` is kept, but made async. `reply` is gone.
- Eliminate the sync versions of `trigger` and `invoke_addon` to allow async hooks in all contexts. This is trickier than it seems because of the number of places in which hooks are triggered in a synchronous context; a lot of code would probably need to be updated to be async. While this probably should happen eventually, I'm hoping this much smaller patch can serve 80% of use cases immediately.

There are also a few easier things that could be done:

- Document which contexts will permit async hooks. Lifecycle hooks like `start`, `done`, etc. don't look like they should be async, for example, since they're often called synchronously.
- Add tests, and/or modify existing tests to use async hooks instead.

#### Checklist

 - [x] I have updated tests where applicable.
 - [x] I have added an entry to the CHANGELOG.

## Working environment

The repository is checked out at `/app/mitmproxy` at this PR's **base commit**
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
