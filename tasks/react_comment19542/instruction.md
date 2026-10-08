# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** Improve error boundary handling for unmounted subtrees

**PR description:**

A passive effect's cleanup function may throw after an unmount. Prior to this commit, such an error would be ignored. (React would not notify any error boundaries.) After this commit, React's behavior varies depending on which reconciler fork is being used.

### Old reconciler fork
React will call `componentDidCatch` for the nearest unmounted error boundary (if there is one). If there are no unmounted error boundaries, React will still "swallow" the error because the return pointer has been disconnected so the normal error handling logic does not know how to traverse the tree to find the nearest still-mounted ancestor. (This behavior is not ideal, but it is temporary and will be replaced by the new fork.)

### New reconciler fork
React will skip any unmounted boundaries and look for a still-mounted boundary. If one is found, it will call `getDerivedStateFromError` and/or `componentDidCatch` (depending on the type of boundary). Unmounted boundaries will be ignored, but as they have been unmounted– this seems appropriate.

Tests have been added for both reconciler variants. Note that **syncing this change to www/fbsource might appear as a regression**, because we may start logging errors that were previously ignored.

### Open questions
- [ ] Is the temporary fix in the old reconciler worth it? Should we just let it swallow errors for now until the new fork gets merged again?
- [ ] Should we call gDSFE after an unmounted tree throws or should we only call cDC?
- [ ] Is this bug (potentially) bad enough to warrant a v16 bugfix release?

## Working environment

The repository is checked out at `/app/react` at this PR's **base commit**
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
