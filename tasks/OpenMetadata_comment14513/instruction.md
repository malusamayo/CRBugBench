# Code Review Task

You are a maintainer reviewing a pull request to the `open-metadata/OpenMetadata` repository.

**PR title:** Update cypress workflows

**PR description:**

### Describe your changes:

Fixes [#14483](https://github.com/open-metadata/OpenMetadata/issues/14483)

Since Cypress project ID for workflows triggered by PRs and schedule (including workflow dispatch) should be different, Introduced a new step in the CI workflows `cypress-integration-tests-mysql.yml` and `cypress-integration-tests-postgresql.yml` that would check the type of event and set a new environment variable `PROJECT_ID` which would be passed to `Run Cypress Tests` step.

Also removed scheduled event triggers from the skip workflows as it is not required.

#
### Type of change:
<!-- You should choose 1 option and delete options that aren't relevant -->
- [ ] Bug fix
- [x] Improvement
- [ ] New feature
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation

#
### Checklist:
<!-- add an x in [] if done, don't mark items that you didn't do !-->
- [x] I have read the [**CONTRIBUTING**](https://docs.open-metadata.org/developers/contribute) document.
- [ ] My PR title is `Fixes <issue-number>: <short explanation>`
- [ ] I have commented on my code, particularly in hard-to-understand areas. 
- [ ] For JSON Schema changes: I updated the migration scripts or explained why it is not needed.

## Working environment

The repository is checked out at `/app/OpenMetadata` at this PR's **base commit**
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
