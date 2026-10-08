# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Notify user if they are using an outdated version of Manim

**PR description:**

<!--
Thanks for your contribution to ManimCommunity!

Before filling in the details, ensure:
- Your local changes are up-to-date with ManimCommunity/manim
  
- The title of your PR gives a descriptive summary to end-users. Some examples:
  - Fixed last animations not running to completion
  - Added gradient support and documentation for SVG files
  Examples of what *NOT* to do:
  - "fixed that styling issue" - not descriptive enough
  - "fixed issue #XYZ" - end-user needs to do further research
-->
## Changelog / Overview
<!-- Optional (Recommended): a detailed overview of the PR for the upcoming
release's changelog entry. Useful for when the PR title isn't enough. 

DO NOT REMOVE THE FOLLOWING CHANGELOG LINES, EVEN IF YOU DON'T USE THEM.-->
<!--changelog-start-->
<!--changelog-end-->
Closes #1230 

## Motivation
<!-- In what way do your changes improve the library? -->
Notifies users in a non-obtrusive way if their local version is outdated and if there is an update available.

## Explanation for Changes
<!-- How do your changes improve the library?

For PRs introducing new features, please provide code snippets using the
newly introduced functionality and ideally even the expected rendered output.
-->
After rendering, `manim` will notify the user if their installed version is outdated. This feature is also available as a global option under `manim render -h` named `--notify_outdated_version`.

When the installed version is outdated:
![image](https://user-images.githubusercontent.com/24194862/113528249-0cf1cd00-958e-11eb-81d0-c0232343e219.png)

## Testing Status
<!-- Optional (Recommended): your computer specs and what tests you ran with
their results, if any. This section is also intended for other
testing-related comments. -->
System: WSL Ubuntu-20.04

## Further Comments
<!-- Optional: any further comments that might be useful for reviewers. -->
We can test this non-obtrusive method to see if it improves user experience. If it doesn't, then we can aim for a more aggressive approach.

## Checklist
- [x] I have read the [Contributing Guidelines](https://docs.manim.community/en/latest/contributing.html)
- [x] I have written a descriptive PR title (see top of PR template for examples)
- [x] I have written a changelog entry for the PR or deem it unnecessary
- [x] My new functions/classes either have a docstring or are private
- [x] My new functions/classes have [tests](https://github.com/ManimCommunity/manim/wiki/Testing) added and (optional) examples in the docs
- [x] My new documentation builds, looks correctly formatted, and adds no additional build warnings
<!-- Once again, thanks for contributing to ManimCommunity! -->


<!-- Do not modify the lines below. These are for the reviewers of your PR -->
## Reviewer Checklist
- [ ] The PR title is descriptive enough
- [ ] The PR is labeled correctly
- [ ] The changelog entry is completed if necessary
- [ ] Newly added functions/classes either have a docstring or are private
- [ ] Newly added functions/classes have [tests](https://github.com/ManimCommunity/manim/wiki/Testing) added and (optional) examples in the docs
- [ ] Newly added documentation builds, looks correctly formatted, and adds no additional build warnings

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
