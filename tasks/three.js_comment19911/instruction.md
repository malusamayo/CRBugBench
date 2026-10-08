# Code Review Task

You are a maintainer reviewing a pull request to the `mrdoob/three.js` repository.

**PR title:** Make equirectangular reflections / refractions backwards compatible.

**PR description:**

Continued from #19845 

This turned out to be much harder than I thought but ended up in a good place.

We no longer break user's code and, in the process, I updated `fromEquirectangularTexture()` to use `renderer.renderBufferDirect()` and that way we can generate cubemaps within a render without messing with the state in `renderer.render()`

This PR also adds `EquirectangularReflectionMapping` support to `scene.background`.

I'll leave this is a draft for now as I want to take a second look tomorrow.

## Working environment

The repository is checked out at `/app/three.js` at this PR's **base commit**
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
