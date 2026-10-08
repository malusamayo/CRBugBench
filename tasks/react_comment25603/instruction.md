# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** Offscreen add attach

**PR description:**

`Offscreen.attach` is imperative API to signal to Offscreen that its updates should be high priority and effects should be mounted. Coupled with `Offscreen.detach` it gives ability to manually control Offscreen. Unlike with mode `visible` and `hidden`, it is developers job to make sure contents of Offscreen are not visible to users.
`Offscreen.attach` only works if mode is `manual`.

Example uses:
```jsx
let offscreenRef = useRef(null);
<Offscreen mode={'manual'} ref={offscreenRef)}>
  <Child />
</Offscreen>

// ------

// Offscreen is attached by default. 
// For example user scrolls away and Offscreen subtree is not visible anymore.
offscreenRef.current.detach();


// User scrolls back and Offscreen subtree is visible again.
offscreenRef.current.attach();
```

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
