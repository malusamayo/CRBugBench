# Code Review Task

You are a maintainer reviewing a pull request to the `ionic-team/ionic-framework` repository.

**PR title:** fix(datetime): values are adjusted to be in bounds

**PR description:**

<!-- Please refer to our contributing documentation for any questions on submitting a pull request, or let us know here if you need any help: https://ionicframework.com/docs/building/contributing -->

## Pull request checklist

Please check if your PR fulfills the following requirements:
- [x] Tests for the changes have been added (for bug fixes / features)
- [ ] Docs have been reviewed and added / updated if needed (for bug fixes / features)
  - Some docs updates need to be made in the `ionic-docs` repo, in a separate PR. See the [contributing guide](https://github.com/ionic-team/ionic-framework/blob/main/.github/CONTRIBUTING.md#modifying-documentation) for details.
- [x] Build (`npm run build`) was run locally and any changes were pushed
- [x] Lint (`npm run lint`) has passed locally and any fixes were made for failures


## Pull request type

<!-- Please do not submit updates to dependencies unless it fixes an issue. --> 

<!-- Please try to limit your pull request to one type, submit multiple pull requests if needed. --> 

Please check the type of change your PR introduces:
- [x] Bugfix
- [ ] Feature
- [ ] Code style update (formatting, renaming)
- [ ] Refactoring (no functional changes, no api changes)
- [ ] Build related changes
- [ ] Documentation content changes
- [ ] Other (please describe): 


## What is the current behavior?
<!-- Please describe the current behavior that you are modifying. -->


<!-- Issues are required for both bug fixes and features. -->
Issue URL: resolves https://github.com/ionic-team/ionic-framework/issues/25894 resolves https://github.com/ionic-team/ionic-framework/issues/25708

The wheel picker component that datetime uses has a built-in recovery system when `value` is no longer represented in `items`. The picker will scroll to the nearest item and update the value.

This was needed by `ion-datetime` when switching between min or max values such that the selected time become invalid. (i.e. selecting the min date that has a min time of 09:00 even though the previously selected time is 08:00).

This caused multiple render issues and unexpected value updates.

## What is the new behavior?
<!-- Please describe the behavior or changes that are being added by this PR. -->

- Moves the adjustment logic out of the picker component and into datetime. Now the value will be adjusted as the state is being updated (whereas the picker was sometimes updating the state immediately after the state was already updated).
Note: Ultimately, the team would like to move away from this automatic value adjustment and align more closely with the native `datetime-local` input behavior. However, that is a breaking change so we opted to fixing the existing behavior for now while we can evaluate alternatives.

## Does this introduce a breaking change?

- [ ] Yes
- [x] No

<!-- If this introduces a breaking change, please describe the impact and migration path for existing applications below. -->


## Other information

<!-- Any other information that is important to this PR such as screenshots of how the component looks before and after the change. -->

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
