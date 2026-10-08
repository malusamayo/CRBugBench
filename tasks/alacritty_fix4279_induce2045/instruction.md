# Code Review Task

You are a maintainer reviewing a pull request to the `alacritty/alacritty` repository.

**PR title:** Dynamically resize terminal for errors/warnings

**PR description / commit message:**

Dynamically resize terminal for errors/warnings

The warning and error messages now don't overwrite other terminal
content anymore but instead resize the terminal to make sure that text
can always be read.

Instead of just showing that there is a new error and pointing to the log,
errors will now be displayed fully in multiple lines of text, assuming that
there is enough space left in the terminal.

Explicit mouse click handling has also been added to the message bar,
which made it possible to add a simple `close` button in the form of
`[X]`.

Alacritty's log file location is now stored in the `$ALACRITTY_LOG`
environment variable which the shell inherits automatically.

Previously there were some issues with the log file only being deleted
when certain methods for closing Alacritty were used (like typing
`exit`). This has been reworked and now Ctrl+D, exit and signals should
all work properly.

Before the config is reloaded, all current messages are now dropped.
This should help with multiple terminals all getting clogged up at the
same time when the config is broken.

When one message is removed, all other duplicate messages are
automatically removed too.

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
