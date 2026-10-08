# Code Review Task

You are a maintainer reviewing a pull request to the `OpenBB-finance/OpenBB` repository.

**PR title:** Polygon stock load

**PR description:**

Adding in load `--source polygon` from polygon.io

The free tier allows 5 calls/minute and it seems that the minute calls give a lotto data, up to 50,000 entries...  We already have polygon API key in the terminal.

More to come :D

I did tests

edit:  I did more

@deeleeramone here are figi and SIK codes from polygon's endpoint
```
            AAPL Codes             
┏━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┓
┃                  ┃              ┃
┡━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━┩
│ CIK              │ 0000320193   │
├──────────────────┼──────────────┤
│ COMPOSITE FIGI   │ BBG000B9XRY4 │
├──────────────────┼──────────────┤
│ SHARE CLASS FIGI │ BBG001S5N8V8 │
├──────────────────┼──────────────┤
│ SIC CODE         │ 3571         │
└──────────────────┴──────────────┘
```

## Working environment

The repository is checked out at `/app/OpenBB` at this PR's **base commit**
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
