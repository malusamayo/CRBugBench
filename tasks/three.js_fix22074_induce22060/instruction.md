# Code Review Task

You are a maintainer reviewing a pull request to the `mrdoob/three.js` repository.

**PR title:** Add preliminary support for WebXR Layers (#22060)

**PR description / commit message:**

Add preliminary support for WebXR Layers (#22060)

* Add preliminary support for WebXR Layers

* WebXR Layers: rename sample

* Resolve merge conflicts for WebXR Layers

* Update WebXRManager.js

Clean up.

* Update webxr_vr_layers.html

Correct title.

Co-authored-by: Rik Cabanier <cabanier@fb.com>
Co-authored-by: Michael Herzog <michael.herzog@human-interactive.org>

## Working environment

The repository is checked out at `/app/three.js` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
