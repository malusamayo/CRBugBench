# Code Review Task

You are a maintainer reviewing a pull request to the `apache/superset` repository.

**PR title:** fix(db-engine-spec): execute oracle DML statement bug in sqllab

**PR description:**

when i execute oracle sql statements like update in SQLLAB, get "oracle error: not a query" error. 

Refer https://www.python.org/dev/peps/pep-0249/, superset old version use
`cursor.description` ，because this attribute will be None for operations that do not return rows or if the cursor has not had an operation invoked via the .execute*() method yet.

### SUMMARY
<!--- Describe the change below, including rationale and design decisions -->

### BEFORE/AFTER SCREENSHOTS OR ANIMATED GIF
<!--- Skip this if not applicable -->

### TEST PLAN
<!--- What steps should be taken to verify the changes -->

### ADDITIONAL INFORMATION
<!--- Check any relevant boxes with "x" -->
<!--- HINT: Include "Fixes #nnn" if you are fixing an existing issue -->
- [ ] Has associated issue:
- [ ] Changes UI
- [ ] Requires DB Migration.
- [ ] Confirm DB Migration upgrade and downgrade tested.
- [ ] Introduces new feature or API
- [ ] Removes existing feature or API

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
