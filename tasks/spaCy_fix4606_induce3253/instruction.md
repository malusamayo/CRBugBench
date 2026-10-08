# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** Add split one token into several (resolves #2838) (#3253)

**PR description / commit message:**

Add split one token into several (resolves #2838) (#3253)

* Add split one token into several (resolves #2838)

* Improve error message for token splitting

* Make retokenizer.split() tests use a Token object

Change retokenizer.split() to use a Token object, instead of an index.

* Pass Token into retokenize.split()

Tweak retokenize.split() API so that we pass the `Token` object, not the index.

* Fix token.idx in retokenize.split()

* Test that token.idx is correct after split

* Fix token.idx for split tokens

* Fix retokenize.split()

* Fix retokenize.split

* Fix retokenize.split() test

## Working environment

The repository is checked out at `/app/spaCy` at this PR's **base commit**
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
