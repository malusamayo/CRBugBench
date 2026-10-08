# Code Review Task

You are a maintainer reviewing a pull request to the `alacritty/alacritty` repository.

**PR title:** Migrate CLI config to structopt

**PR description / commit message:**

Migrate CLI config to structopt

While structopt also uses clap under the hood, the configuration through
annotations allows for significantly more maintainable and concise CLI
definition.

This will also make it far easier to have platform-specific options,
which is problematic with clap since no individual methods can be
removed from its builder.

The change in Alacritty's CLI has been kept to a minimum with the only
significant changes being the `--version` flag listed before the
`-v` flag and the authors all on the same line.

## Working environment

The repository is checked out at `/app/alacritty` at this PR's **base commit**
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
