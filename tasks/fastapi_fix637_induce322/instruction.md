# Code Review Task

You are a maintainer reviewing a pull request to the `fastapi/fastapi` repository.

**PR title:** :sparkles: Implement support for Pydantic's ORM mode (#322)

**PR description / commit message:**

:sparkles: Implement support for Pydantic's ORM mode (#322)

* :sparkles: Implement support for Pydantic's ORM mode

* :building_construction: Re-structure/augment SQL tutorial source using ORM mode

* :memo: Update SQL docs with SQLAlchemy, ORM mode, relationships

* :fire: Remove unused util in tutorial

* :memo: Add tutorials for simple dict bodies and responses

* :fire: Remove old SQL tutorial

* :white_check_mark: Add/update tests for SQL tutorial

* :white_check_mark: Add tests for simple dicts (body and response)

* :bug: Fix cloning field from original field

## Working environment

The repository is checked out at `/app/fastapi` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
