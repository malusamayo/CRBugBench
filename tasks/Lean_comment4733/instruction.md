# Code Review Task

You are a maintainer reviewing a pull request to the `QuantConnect/Lean` repository.

**PR title:** Historical data requests start & time fix

**PR description:**

<!--- Provide a general summary of your changes in the Title above -->

#### Description
<!--- Describe your changes in detail -->
Fix calculation `Time.GetStartTimeForTradeBars`, should round down in data timezone because the data timezone rounded down, converted into exchange time zone will be the datas Time.

![image](https://user-images.githubusercontent.com/3648114/93654512-8aa51f80-fa26-11ea-91f1-6d8cb01e5a01.png)



#### Related Issue
<!--- This project only accepts pull requests related to open issues -->
<!--- If suggesting a new feature or change, please discuss it in an issue first -->
<!--- If fixing a bug, there should be an issue describing it with steps to reproduce -->
<!--- Please link to the issue here: -->
Closes #4035 

#### Motivation and Context
<!--- Why is this change required? What problem does it solve? -->
History start and end time are wrong, as a result we

#### Requires Documentation Change
<!--- Please indicate if these changes will require updates to documentation, and if so, specify what changes are required -->
N/A

#### How Has This Been Tested?
<!--- Please describe in detail how you tested your changes. -->
<!--- Include details of your testing environment, and the tests you ran to -->
<!--- see how your change affects other areas of the code, etc. -->
- manual testing
- add regression tests
- add unit tests for new implementation of `Time.GetStartTimeForTradeBars`

Fix existing test: `OpenInterestFutureUniverseSelectionModelTests.Can_Sort_By_Open_Interest` distory should return Sunday if market open

#### Types of changes
<!--- What types of changes does your code introduce? Put an `x` in all the boxes that apply: -->
- [x] Bug fix (non-breaking change which fixes an issue)
- [ ] Refactor (non-breaking change which improves implementation)
- [ ] Performance (non-breaking change which improves performance. Please add associated performance test and results)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [ ] Non-functional change (xml comments/documentation/etc)

#### Checklist:
<!--- The following is a checklist of items that MUST be completed before a PR is accepted -->
<!--- If you're unsure about any of these, don't hesitate to ask. We're here to help! -->
- [x] My code follows the code style of this project.
- [x] I have read the **CONTRIBUTING** [document](https://github.com/QuantConnect/Lean/blob/master/CONTRIBUTING.md).
- [x] I have added tests to cover my changes. <!--- If not applicable, please explain why -->
- [x] All new and existing tests passed.
- [x] My branch follows the naming convention `bug-<issue#>-<description>` or `feature-<issue#>-<description>`

<!--- Template inspired by https://www.talater.com/open-source-templates/#/page/99 -->

## Working environment

The repository is checked out at `/app/Lean` at this PR's **base commit**
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
