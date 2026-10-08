# Code Review Task

You are a maintainer reviewing a pull request to the `thingsboard/thingsboard` repository.

**PR title:** Fixed time series table widgets tab style

**PR description:**

## Pull Request description

Before:
<img width="1465" height="676" alt="Знімок екрана 2026-03-18 о 17 00 13" src="https://github.com/user-attachments/assets/be75252b-2dce-48a0-9a22-492e6ad0fabf" />

After:
<img width="1472" height="661" alt="Знімок екрана 2026-03-19 о 17 11 38" src="https://github.com/user-attachments/assets/b54735f7-7886-4482-9d79-2683270ad380" />

## General checklist

- [x] You have reviewed the guidelines [document](https://docs.google.com/document/d/1wqcOafLx5hth8SAg4dqV_LV3un3m5WYR8RdTJ4MbbUM/edit?usp=sharing).
- [x] [Labels](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels#about-labels) that classify your pull request have been added.
- [x] The [milestone](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/about-milestones) is specified and corresponds to fix version.  
- [ ] Description references specific [issue](https://github.com/thingsboard/thingsboard/issues).
- [ ] Description contains human-readable scope of changes.
- [ ] Description contains brief notes about what needs to be added to the documentation.
- [x] No merge conflicts, commented blocks of code, code formatting issues.
- [x] Changes are backward compatible or upgrade script is provided.
- [ ] Similar PR is opened for PE version to simplify merge. Crosslinks between PRs added. Required for internal contributors only.
  
## Front-End feature checklist

- [x] Screenshots with affected component(s) are added. The best option is to provide 2 screens: before and after changes;
- [ ] If you change the widget or other API, ensure it is backward-compatible or upgrade script is present.
- [ ] Ensure new API is documented [here](https://github.com/thingsboard/thingsboard-ui-help)

## Back-End feature checklist

- [ ] Added corresponding unit and/or integration test(s). Provide written explanation in the PR description if you have failed to add tests.
- [ ] If new dependency was added: the dependency tree is checked for conflicts.
- [ ] If new service was added: the service is marked with corresponding @TbCoreComponent, @TbRuleEngineComponent, @TbTransportComponent, etc.
- [ ] If new REST API was added: the RestClient.java was updated, issue for [Python REST client](https://github.com/thingsboard/thingsboard-python-rest-client) is created.
- [ ] If new yml property was added: make sure a description is added (above or near the property).

## Working environment

The repository is checked out at `/app/thingsboard` at this PR's **base commit**
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
