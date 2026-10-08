# Code Review Task

You are a maintainer reviewing a pull request to the `pydantic/pydantic` repository.

**PR title:** refactor: change pydantic dataclass decorator (#2557)

**PR description / commit message:**

refactor: change pydantic dataclass decorator (#2557)

* refactor: rewrite the whole pydantic dataclass logic

* test: add tests for issue 2162

* test: add tests for issue 2383

* test: add tests for issue 2398

* test: add tests for issue 2424

* test: add tests for issue 2541

* test: add tests for issue 2555

* refactor: polish

* change default and support 3.6

* fix coverage

* fix mypy and text

* typos

* test: add tests for issue 2594

* fix: forward doc for schema description

* add change

* chore: small changes from review

* refactor: avoid extra __pydantic_run_validation__ parameter

* small tweaks

* remove wrapper

* support 3.6

* fix: mypy

* rewrite doc

* add docs

* wrapper is removed now

* a bit more docs

* code review

* faster dict update

* add test for issue 3162

* add test for issue 3011

* feat: add `Config.post_init_after_validation`

* allow config via dict

* fix cython and TypedDict

* chore: typo

* move `compiled` in `version.py`

* refactor: switch from `Config.post_init_after_validation` to \'post_init_call`

* add dataclass isinstance support

* avoid multi paragraphs in change file

* feat: support `Config.extra`

* refactor: simplify a bit code

* refactor: avoid creating useless functions

* refactor: simplify `is_builtin_dataclass`

* support extra in post_init

* docs: add warning on config extra

* fix #3713 compatibility

* update docs

Co-authored-by: Samuel Colvin <s@muelcolvin.com>

## Working environment

The repository is checked out at `/app/pydantic` at this PR's **base commit**
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
