# Code Review Task

You are a maintainer reviewing a pull request to the `PowerShell/PowerShell` repository.

**PR title:** Make approved features non-experimental

**PR description:**

<!-- Anything that looks like this is a comment and can't be seen after the Pull Request is created. -->

# PR Summary

As discussed in @PowerShell/powershell-committee, these features will be out of Experimental status:

```none
PSCoalescingOperators
PSErrorView
PSForEachObjectParallel
PSPipelineChainOperators
PSTernaryOperator
PSUpdatesNotification
PSWindowsPowerShellCompatibility
Microsoft.PowerShell.Utility.PSGetError
```

Code marking them as Experimental has been removed.

## PR Context

Fix https://github.com/PowerShell/PowerShell/issues/11302
Fix https://github.com/PowerShell/PowerShell/issues/11081

## PR Checklist

- [x] [PR has a meaningful title](https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md#pull-request---submission)
    - Use the present tense and imperative mood when describing your changes
- [x] [Summarized changes](https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md#pull-request---submission)
- [x] [Make sure all `.h`, `.cpp`, `.cs`, `.ps1` and `.psm1` files have the correct copyright header](https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md#pull-request---submission)
- [x] This PR is ready to merge and is not [Work in Progress](https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md#pull-request---work-in-progress).
    - If the PR is work in progress, please add the prefix `WIP:` or `[ WIP ]` to the beginning of the title (the `WIP` bot will keep its status check at `Pending` while the prefix is present) and remove the prefix when the PR is ready.
- **[Breaking changes](https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md#making-breaking-changes)**
    - [x] None
    - **OR**
    - [ ] [Experimental feature(s) needed](https://github.com/MicrosoftDocs/PowerShell-Docs/blob/staging/reference/6/Microsoft.PowerShell.Core/About/about_Experimental_Features.md)
        - [ ] Experimental feature name(s): <!-- Experimental feature name(s) here -->
- **User-facing changes**
    - [x] Not Applicable
    - **OR**
    - [ ] [Documentation needed](https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md#pull-request---submission)
        - [ ] Issue filed: <!-- Number/link of that issue here -->
- **Testing - New and feature**
    - [ ] N/A or can only be tested interactively
    - **OR**
    - [x] [Make sure you've added a new test if existing tests do not effectively test the code changed](https://github.com/PowerShell/PowerShell/blob/master/.github/CONTRIBUTING.md#before-submitting)
- **Tooling**
    - [x] I have considered the user experience from a tooling perspective and don't believe tooling will be impacted.
    - **OR**
    - [ ] I have considered the user experience from a tooling perspective and enumerated concerns in the summary. This may include:
        - Impact on [PowerShell Editor Services](https://github.com/PowerShell/PowerShellEditorServices) which is used in the [PowerShell extension](https://github.com/PowerShell/vscode-powershell) for VSCode (which runs in a different PS Host).
        - Impact on Completions (both in the console and in editors) - one of PowerShell's most powerful features.
        - Impact on [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) (which provides linting & formatting in the editor extensions).
        - Impact on [EditorSyntax](https://github.com/PowerShell/EditorSyntax) (which provides syntax highlighting with in VSCode, GitHub, and many other editors).

## Working environment

The repository is checked out at `/app/PowerShell` at this PR's **base commit**
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
