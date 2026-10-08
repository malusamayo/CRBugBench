# Code Review Task

You are a maintainer reviewing a pull request to the `QuantConnect/Lean` repository.

**PR title:** Allow LeanDataWriter to create zip files for futures data

**PR description:**

`LeanDataWriter` is able to create data files in the expected QC format for all symbols, except futures where multiple contracts exist in the file.  This is a format supported by the `LeanDataReader`, but there isn't a writer equivalent.

#### Description
The approach I took was to add a `boolean` value that controls whether a file should be appended to or not.
If the ZIP entry exists, it will be replaced in its entirity.
However, any existing entries will be maintained.

This may not be the best approach, and there are potential issues - such as retention of stale data.
I'd be happy to hear suggestions on how it can be improved / a better approach.

I've also included 2 fixes that I found while trying to use this class.
* I couldn't override the output location when using the end-to-end retrieve & write function.  It always wrote to the global data directory.
* Data wasn't grouped if the input had a time portion attached.

#### Related Issue
<!--- This project only accepts pull requests related to open issues -->
<!--- If suggesting a new feature or change, please discuss it in an issue first -->
<!--- If fixing a bug, there should be an issue describing it with steps to reproduce -->
<!--- Please link to the issue here: -->

#### Motivation and Context
Unable to generate futures data zips without any custom code, as the file was always overridden.

#### Requires Documentation Change
N/A

#### How Has This Been Tested?
I have included unit tests for the futures change.
I also have tested it locally, generating ~5 years of data across a set of futures, with each output file containing multiple contracts.

#### Types of changes
<!--- What types of changes does your code introduce? Put an `x` in all the boxes that apply: -->
- [x] Bug fix (non-breaking change which fixes an issue)
- [ ] Refactor (non-breaking change which improves implementation)
- [ ] Performance (non-breaking change which improves performance. Please add associated performance test and results)
- [x] New feature (non-breaking change which adds functionality)
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
