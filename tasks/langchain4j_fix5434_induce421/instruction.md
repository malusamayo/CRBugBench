# Code Review Task

You are a maintainer reviewing a pull request to the `langchain4j/langchain4j` repository.

**PR title:** Tencent COS document loader (#421)

**PR description / commit message:**

Tencent COS document loader (#421)

Hi! I make some progress to integrate with [Tencent
COS](https://www.tencentcloud.com/document/product/436) becuase I have
some documents on it to load. The `TencentCosDocumentLoaderIT` works
correctly in my local, but it need Tencent credentials so I disable it.

## Working environment

The repository is checked out at `/app/langchain4j` at this PR's **base commit**
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
