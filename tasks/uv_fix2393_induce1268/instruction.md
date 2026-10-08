# Code Review Task

You are a maintainer reviewing a pull request to the `astral-sh/uv` repository.

**PR title:** Implement pip compatible `--no-binary` and `--only-binary` options (#1268)

**PR description / commit message:**

Implement pip compatible `--no-binary` and `--only-binary` options (#1268)

Updates our `--no-binary` option and adds a `--only-binary` option for
compatibility with `pip` which uses `:all:`, `:none:` and `<name>` for
specifying packages.

This required adding support for `--only-binary <name>` into our
resolver, previously it was only a boolean toggle.

Retains`--no-build` which is equivalent to `--only-binary :all:`. This
is common enough for safety that I would prefer it is available without
pip's awkward `:all:` syntax.

---------

Co-authored-by: konsti <konstin@mailbox.org>

## Working environment

The repository is checked out at `/app/uv` at this PR's **base commit**
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
