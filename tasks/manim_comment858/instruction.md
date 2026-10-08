# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Fix CairoText

**PR description:**

## Overview / Explanation for Changes
CairoText is broken since #783. This PR fixes the problem.

1. Problem: ```color = color ** config``` results in an error
2. Problem: Parameters were missing which resulted in blurry output when scaling CairoText

To see the problems just run this snippet on master:
```python
class Test(Scene):
    def construct(self):
        t = CairoText("This is a test!")
        t.scale(0.3)
        self.add(t)
        self.wait(3)
```
You'll see an error, just remove ```** config```.
If you run it now, you'll see that the text is blurry. This is because arguments were missing. (I think they were just forgotten to include during the config refactor)

## Oneline Summary of Changes
<!-- Please update the lines below with a oneline summary
for your changes. It will be included in the list of upcoming changes at
https://github.com/ManimCommunity/manim/wiki/Changelog-for-next-release -->
```
- Fixed CairoText to work with new config structure
```

## Acknowledgements
- [x] I have read the [Contributing Guidelines](https://docs.manim.community/en/latest/contributing.html)

<!-- Once again, thanks for helping out by contributing to manim! -->


<!-- Do not modify the lines below. -->
## Reviewer Checklist
- [x] Newly added functions/classes are either private or have a docstring
- [x] Newly added functions/classes have [tests](https://github.com/ManimCommunity/manim/wiki/Testing) added and (optional) examples in the docs
- [x] Newly added documentation builds, looks correctly formatted, and adds no additional build warnings
- [x] The oneline summary has been included [in the wiki](https://github.com/ManimCommunity/manim/wiki/Changelog-for-next-release)

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
