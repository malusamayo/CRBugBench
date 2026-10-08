# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/aspire` repository.

**PR title:** Clear terminal input buffer before sending Aspire commands

**PR description:**

## Description

When the Aspire terminal has pre-existing text in its input buffer (e.g., a partially typed command), clicking **Stop**, **Restart**, or **Start** on a code lens or tree view appends the Aspire CLI command to the existing text, producing an invalid command that fails.

This fix sends a line-clearing control sequence before each command:
- **Unix (bash/zsh):** `Ctrl+U` (`\x15`) — clears the current input line
- **Windows (PowerShell):** `Escape` (`\x1b`) — clears the current input line

Fixes #15587

## Checklist

- Is this feature complete?
  - [x] Yes. Ready to ship.
  - [ ] No. Follow-up changes expected.
- Are you including unit tests for the changes and scenario tests if relevant?
  - [ ] Yes
  - [x] No
- Did you add public API?
  - [ ] Yes
    - If yes, did you have an API Review for it?
      - [ ] Yes
      - [ ] No
    - Did you add `<remarks />` and `<code />` elements on your triple slash comments?
      - [ ] Yes
      - [ ] No
  - [x] No
- Does the change make any security assumptions or guarantees?
  - [ ] Yes
    - If yes, have you done a threat model and had a security review?
      - [ ] Yes
      - [ ] No
  - [x] No
- Does the change require an update in our Aspire docs?
  - [ ] Yes
    - Link to `aspire.dev` issue:
      - [New issue](https://github.com/microsoft/aspire.dev/issues/new)
  - [x] No

## Working environment

The repository is checked out at `/app/aspire` at this PR's **base commit**
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
