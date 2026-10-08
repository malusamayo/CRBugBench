# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/efcore` repository.

**PR title:** [5.0.2] Stop marking the inverse navigation as loaded when loading a many-to-many navigation

**PR description:**

Fixes #23475

This is a targeted patch fix which special cases many-to-many loading. I will file an issue for a more general solution using an appropriate general update to query. See #22022.

**Description**

This is a bug in many-to-many relationships, a major new feature in EF Core 5.0. When loading a collection navigation property, the inverse navigation property is marked as loaded. This is not correct, since only entities related to the source entity are loaded. This means that attempting to load the inverse is a no-op because it is already marked as loaded, and hence data is missing in the context.

**Customer Impact**

Related entities are not loaded from the database when they should be, leading to possible data corruption in an application that assumes this is working correctly. This will kind of problem is often hard to find since there is no error, just incorrect data.

**How found**

Customer reported on 5.0.0.

**Test coverage**

We did not have test coverage for this case. However, this isn't why we didn't catch this, since I didn't think about the consequences for the IsLoaded flag here, and only investigation of this issue made me realize the mistake. We have added more test coverage in this PR.

**Regression?**

No; new feature in 5.0.

**Risk**

Medium. The underlying problem is that we ere using `Include` in the generated query to do lazy loading. The behavior of Include is to set the collection as loaded, even if filtered, which means we can't change the default behavior of Include. Therefore, we have introduced a new internal `NotQuiteInclude` method that is processed the same as `Include` in the query pipeline, but then changes the final materialization delegate to indicate that the collection should not be loaded. This is new code path has been done in a way that it is only used for this case, and can be disabled with a quirk switch. It has also been reviewed in detail by the team and we have added more testing.

## Working environment

The repository is checked out at `/app/efcore` at this PR's **base commit**
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
