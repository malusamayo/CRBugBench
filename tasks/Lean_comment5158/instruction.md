# Code Review Task

You are a maintainer reviewing a pull request to the `QuantConnect/Lean` repository.

**PR title:** Refactor Default Benchmark

**PR description:**

<!--- Provide a general summary of your changes in the Title above -->

#### Description
<!--- Describe your changes in detail -->
Have Brokerage models set the default benchmark for their brokerage.

#### Related Issue
<!--- This project only accepts pull requests related to open issues -->
<!--- If suggesting a new feature or change, please discuss it in an issue first -->
<!--- If fixing a bug, there should be an issue describing it with steps to reproduce -->
<!--- Please link to the issue here: -->
Closes #5143 

#### Motivation and Context
<!--- Why is this change required? What problem does it solve? -->
> Since the default benchmark is SPY it causes live trading issue when trading with crypto brokerages or generally brokerages for which the user doesn't have a SPY subscription (like IB)

Instead of using a default benchmark for all brokerages this allows a unique benchmark to be used by any brokerage implementation through overriding `GetBenchmark()` in any `IBrokerageModel`. All it needs to do is return a `IBenchmark` and it will be set for the algorithm. 

Any brokerage model that does not override the function will take on the default benchmark (SPY).

#### Requires Documentation Change
<!--- Please indicate if these changes will require updates to documentation, and if so, specify what changes are required -->

#### How Has This Been Tested?
<!--- Please describe in detail how you tested your changes. -->
<!--- Include details of your testing environment, and the tests you ran to -->
<!--- see how your change affects other areas of the code, etc. -->

All regressions pass as expected.
Added a new regression to test the case of 0 value benchmark for C# and Python

#### Types of changes
<!--- What types of changes does your code introduce? Put an `x` in all the boxes that apply: -->
- [x] Bug fix (non-breaking change which fixes an issue)
- [x] Refactor (non-breaking change which improves implementation)
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
