# Code Review Task

You are a maintainer reviewing a pull request to the `servo/servo` repository.

**PR title:** devtools: Create source actors from Debugger API notifications

**PR description:**

currently our devtools impl creates source actors in script, when executing scripts in HTMLScriptElement or DedicatedWorkerGlobalScope. this approach is cumbersome, and it means that many pathways to running scripts are missed, such as imported ES modules.

with the [SpiderMonkey Debugger API](https://firefox-source-docs.mozilla.org/js/Debugger/), we can pick up all of the scripts and all of their sources without any extra code, as long as we tell it about every global we create (#38333, #38551). this patch adds a [Debugger#onNewScript() hook](https://firefox-source-docs.mozilla.org/js/Debugger/Debugger.html#onnewscript-script-global) to the debugger script, which calls DebuggerGlobalScope#notifyNewSource() to notify our script system when a new script runs. if the source is relevant to the file tree in the Sources tab, script tells devtools to create a source actor.

Testing: adds several new automated devtools tests
Fixes: part of #36027

## Working environment

The repository is checked out at `/app/servo` at this PR's **base commit**
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
