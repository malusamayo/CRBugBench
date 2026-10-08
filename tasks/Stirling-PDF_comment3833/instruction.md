# Code Review Task

You are a maintainer reviewing a pull request to the `Stirling-Tools/Stirling-PDF` repository.

**PR title:** Feature/react backend config access

**PR description:**

# Description of Changes

Please provide a summary of the changes, including:

added config controller so that the frontend react can get the appConfig and EEAppConfig as json.
Also added endpoints for checking availble tools. 


---

## Checklist

### General

- [ ] I have read the [Contribution Guidelines](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/CONTRIBUTING.md)
- [ ] I have read the [Stirling-PDF Developer Guide](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/DeveloperGuide.md) (if applicable)
- [ ] I have read the [How to add new languages to Stirling-PDF](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/HowToAddNewLanguage.md) (if applicable)
- [ ] I have performed a self-review of my own code
- [ ] My changes generate no new warnings

### Documentation

- [ ] I have updated relevant docs on [Stirling-PDF's doc repo](https://github.com/Stirling-Tools/Stirling-Tools.github.io/blob/main/docs/) (if functionality has heavily changed)
- [ ] I have read the section [Add New Translation Tags](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/HowToAddNewLanguage.md#add-new-translation-tags) (for new translation tags only)

### UI Changes (if applicable)

- [ ] Screenshots or videos demonstrating the UI changes are attached (e.g., as comments or direct attachments in the PR)

### Testing (if applicable)

- [ ] I have tested my changes locally. Refer to the [Testing Guide](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/DeveloperGuide.md#6-testing) for more details.

## Working environment

The repository is checked out at `/app/Stirling-PDF` at this PR's **base commit**
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
