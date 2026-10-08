# Code Review Task

You are a maintainer reviewing a pull request to the `ionic-team/ionic-framework` repository.

**PR title:** fix(input): add disabled state to the ionic theme

**PR description:**

Issue number: internal
---------

<!-- Please do not submit updates to dependencies unless it fixes an issue. -->

<!-- Please try to limit your pull request to one type (bugfix, feature, etc). Submit multiple pull requests if needed. -->

## What is the current behavior?
<!-- Please describe the current behavior that you are modifying. -->

The disabled state for the `ionic` theme does not match design.

## What is the new behavior?
<!-- Please describe the behavior or changes that are being added by this PR. -->

- Matched `ion-input` to the design for disabled: background, border, bottom, etc.
- valid/invalid/color will have a slightly different design: apply 60% opacity to border, help message, and use current disabled colors for label, text, and counter text
- Added tests

## Does this introduce a breaking change?

- [ ] Yes
- [x] No

<!--
  If this introduces a breaking change:
  1. Describe the impact and migration path for existing applications below.
  2. Update the BREAKING.md file with the breaking change.
  3. Add "BREAKING CHANGE: [...]" to the commit description when merging. See https://github.com/ionic-team/ionic-framework/blob/main/docs/CONTRIBUTING.md#footer for more information.
-->


## Other information

<!-- Any other information that is important to this PR such as screenshots of how the component looks before and after the change. -->

DM if you need the link for the design.

[Preview](https://ionic-framework-git-fw-6093-ionic1.vercel.app/src/components/input/test/states?ionic:theme=ionic)

## Working environment

The repository is checked out at `/app/ionic-framework` at this PR's **base commit**
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
