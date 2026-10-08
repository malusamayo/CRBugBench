# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/vscode` repository.

**PR title:** Prompt user with info about terminal config, add settings search by @id, and add sendToShell setting

**PR description:**

Use @id: to search for one or more comma separated settings ids

Use keyboard shortcuts on the terminal corresponding to `terminal.integrated.commandsToSkipShell` commands and see an alert to configure terminal settings. Clicking `Configure` or `Don't show again` should result in never seeing the prompt again as the same user. Clicking the x on the prompt will show the prompt again the next time it's triggered.

Set `terminal.integrated.sendToShell`: true and use any key-bindings that trigger something to happen in the terminal. They should work and not be handled by the workbench. For example, Ctrl+E should jump to the end of the line instead of opening the quick pick. 

You should still be able to use Ctrl+1-9 to navigate around the editor groups.

## Working environment

The repository is checked out at `/app/vscode` at this PR's **base commit**
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
