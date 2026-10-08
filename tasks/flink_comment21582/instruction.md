# Code Review Task

You are a maintainer reviewing a pull request to the `apache/flink` repository.

**PR title:** [FLINK-28655][SQL gateway] Support show jobs operation in SqlGateway

**PR description:**

## What is the purpose of the change

Support show jobs statement in SqlGatewayService. Subtask of FLIP-222.


## Brief change log

- Add show jobs statement in SQL parser.
- Add show jobs operation support in the table planner.
- Add show jobs operation support in SQL gateway.

## Verifying this change

This change added tests and can be verified as follows:

- Extend FlinkSqlParserImplTest to validate the parsing of show-jobs statements.
- Extend SqlGatewayServiceITCase to validate the execution of show-jobs statements.

## Does this pull request potentially affect one of the following parts:

  - Dependencies (does it add or upgrade a dependency): no
  - The public API, i.e., is any changed class annotated with `@Public(Evolving)`: no
  - The serializers: no
  - The runtime per-record code paths (performance sensitive): no
  - Anything that affects deployment or recovery: JobManager (and its components), Checkpointing, Kubernetes/Yarn, ZooKeeper: no
  - The S3 file system connector: no

## Documentation

  - Does this pull request introduce a new feature? yes
  - If yes, how is the feature documented? (not applicable / docs / JavaDocs / not documented)

## Working environment

The repository is checked out at `/app/flink` at this PR's **base commit**
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
