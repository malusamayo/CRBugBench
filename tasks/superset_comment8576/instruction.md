# Code Review Task

You are a maintainer reviewing a pull request to the `apache/superset` repository.

**PR title:** [db migration] change datasources-clusters foreign key to cluster_id

**PR description:**

### CATEGORY
Choose one

- [ ] Bug Fix
- [ ] Enhancement (new features, refinement)
- [ ] Refactor
- [ ] Add tests
- [ ] Build / Development Environment
- [ ] Documentation
- [X] Schema change

### SUMMARY
Change the foreign key for `datasources`->`clusters` from `cluster_name` to `cluster_id` (the primary key of `clusters`).

### TEST PLAN
`tox` passes.

### ADDITIONAL INFORMATION
<!--- Check any relevant boxes with "x" -->
<!--- HINT: Include "Fixes #nnn" if you are fixing an existing issue -->
- [ ] Has associated issue:
- [ ] Changes UI
- [X] Requires DB Migration.
- [X] Confirm DB Migration upgrade and downgrade tested.
- [ ] Introduces new feature or API
- [ ] Removes existing feature or API

### REVIEWERS
@john-bodley @mistercrunch

## Working environment

The repository is checked out at `/app/superset` at this PR's **base commit**
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
