# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** Initial (client-only) async actions support

**PR description:**

Implements initial (client-only) support for async actions behind a flag. This is an experimental feature and the design isn't completely finalized but we're getting closer. It will be layered alongside other features we're working on, so it may not feel complete when considered in isolation.

The basic description is you can pass an async function to `startTransition` and all the transition updates that are scheduled inside that async function will be grouped together. The `isPending` flag will be set to true immediately, and only set back to false once the async action has completed (as well as all the updates that it triggers).

The ideal behavior would be that all updates spawned by the async action are automatically inferred and grouped together; however, doing this properly requires the upcoming (stage 2) Async Context API, which is not yet implemented by browsers. In the meantime, we will fake this by grouping together all transition updates that occur until the async function has terminated. This can lead to overgrouping between unrelated actions, which is not wrong per se, just not ideal.

If the `useTransition` hook is removed from the UI before an async action has completed — for example, if the user navigates to a new page — subsequent transitions will no longer be grouped with together with that action.

Another consequence of the lack of Async Context is that if you call `setState` inside an action but after an `await`, it must be wrapped in `startTransition` in order to be grouped properly. If we didn't require this, then there would be no way to distinguish action updates from urgent updates caused by user input, too. This is an unfortunate footgun but we can likely detect the most common mistakes using a lint rule.

Once Async Context lands in browsers, we can start warning in dev if we detect an update that hasn't been wrapped in `startTransition`. Then, longer term, once the feature is ubiquitous, we can rely on it for real and allow you to call `setState` without the additional wrapper.

Things that are _not_ yet implemented in this PR, but will be added as follow ups:

- Support for non-hook form of `startTransition`
- Canceling the async action scope if the `useTransition` hook is deleted from the UI
- Anything related to server actions

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
