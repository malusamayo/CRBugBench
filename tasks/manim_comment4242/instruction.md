# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Fix duplicate references in `Scene.mobjects` after `ReplacementTransform` with existing target mobject

**PR description:**

<!-- Thank you for contributing to Manim! Learn more about the process in our contributing guidelines: https://docs.manim.community/en/latest/contributing.html -->

## Overview: What does this pull request change?
Fix https://github.com/ManimCommunity/manim/issues/4238

Fix duplicate mobject reference issue when using `ReplacementTransform` if the target mobject is already in the scene.

## Motivation and Explanation: Why and how do your changes improve the library?
Previously, if the target mobject was already in the scene, `ReplacementTransform` would replace the source mobject in the `scene.mobjects` list without removing the existing reference to the target mobject. This caused `scene.mobjects` to contain two references to the same object (i.e., the target mobject), leading to unexpected behavior in #4238.

Before this fix:
```python
from manim import Circle, ReplacementTransform, Scene, Square
scene = Scene()
c = Circle()
sq = Square()
scene.add(c, sq)
print(scene.mobjects)    # [Circle, Square]
scene.play(ReplacementTransform(c, sq))
print(scene.mobjects)    # [Square, Square]  <- Duplicate reference to Square
mob = scene.mobjects
print(mob[0] is mob[1])  # True
```

After this fix:
```python
from manim import Circle, ReplacementTransform, Scene, Square
scene = Scene()
c = Circle()
sq = Square()
scene.add(c, sq)
print(scene.mobjects)    # [Circle, Square]
scene.play(ReplacementTransform(c, sq))
print(scene.mobjects)    # [Square]  <- Only one reference remains
```

<!-- Thank you again for contributing! Do not modify the lines below, they are for reviewers. -->
## Reviewer Checklist
- [ ] The PR title is descriptive enough for the changelog, and the PR is labeled correctly
- [ ] If applicable: newly added non-private functions and classes have a docstring including a short summary and a PARAMETERS section
- [ ] If applicable: newly added functions and classes are tested

## Working environment

The repository is checked out at `/app/manim` at this PR's **base commit**
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
