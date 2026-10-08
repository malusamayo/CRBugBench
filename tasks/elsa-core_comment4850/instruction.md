# Code Review Task

You are a maintainer reviewing a pull request to the `elsa-workflows/elsa-core` repository.

**PR title:** Add support for list/array conversion in JavaScript evaluator

**PR description:**

A `StringObjectDictionaryConverter` has been added, which converts all `IList` fields of an object to array fields. This enhances the interaction of JS expressions with list types, allowing common Array methods to be applied directly. Furthermore, defaults have been added to the `ExpressionEvaluatorOptions` parameters to improve usability. Lastly, adjustments were made to ensure variables are correctly set while evaluating expressions.

Closes #4849

## Working environment

The repository is checked out at `/app/elsa-core` at this PR's **base commit**
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
