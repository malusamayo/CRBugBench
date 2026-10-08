# Code Review Task

You are a maintainer reviewing a pull request to the `hoppscotch/hoppscotch` repository.

**PR title:** chore: add sslmode support to PrismaService database URL parser

**PR description:**

<!--
Thanks for creating this pull request 🤗

Please make sure that the pull request is limited to one type (docs, feature, etc.) and keep it as small as possible. You can open multiple prs instead of opening a huge one.
-->

<!-- If this pull request closes an issue, please mention the issue number below -->
<!-- Issue # here -->
Closes BE-680

<!-- Add an introduction into what this PR tries to solve in a couple of sentences -->

### What's changed
<!-- Describe point by point the different things you have changed in this PR -->

This pull request primarily refactors the `PrismaService` to improve parsing and handling of the `DATABASE_URL` environment variable, with additional minor formatting improvements in the `MockServerService` test suite. The most significant change is enhanced support for connection options (like `sslmode`) in the database connection logic.

**Database connection improvements:**

* Refactored `PrismaService` constructor and `parseDatabaseUrl` to more robustly extract and handle options from the `DATABASE_URL`, including `schema`, `connection_limit`, `connect_timeout`, and `sslmode`. Now, SSL is configured based on `sslmode` and all relevant options are parsed with safer type handling. [[1]](diffhunk://#diff-ccbdbf98ee64a256fef89bb52ac57b5d38f1907477754b69af0e51b13aff0410L16-R34) [[2]](diffhunk://#diff-ccbdbf98ee64a256fef89bb52ac57b5d38f1907477754b69af0e51b13aff0410R48-R84)

<!-- You can also choose to add a list of changes and if they have been completed or not by using the markdown to-do list syntax
- [ ] Not Completed
- [x] Completed
-->

### Notes to reviewers
<!-- Any information you feel the reviewer should know about when reviewing your PR -->
Ass sslmode in the DATABASE_URL and see, if the backend server able to connect with DB or not
```
DATABASE_URL='postgresql://user:password@localhost:5432/hoppscotch?sslmode=require'
```









<!-- This is an auto-generated description by cubic. -->
---
## Summary by cubic
Add sslmode support to PrismaService’s DATABASE_URL parsing and connection setup. SSL is now configured per sslmode, addressing BE-680.

- **New Features**
  - Parse sslmode, connection_limit, connect_timeout, and schema from DATABASE_URL (connect_timeout default is now 10s).
  - Configure pg Pool SSL per sslmode (require/prefer/allow -> rejectUnauthorized: false; verify-ca/verify-full -> true; disable/absent -> false).
  - Remove sslmode from the connection string and apply SSL via pg Pool options.

- **Refactors**
  - Safer number parsing and minor formatting cleanups in mock-server tests.

<sup>Written for commit 948a46d97f2cb9b956887c560a8c77bc851769bc. Summary will update automatically on new commits.</sup>

<!-- End of auto-generated description by cubic. -->

## Working environment

The repository is checked out at `/app/hoppscotch` at this PR's **base commit**
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
