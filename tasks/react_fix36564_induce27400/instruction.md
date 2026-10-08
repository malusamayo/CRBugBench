# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** [Fizz][Float] Refactor Resources  (#27400)

**PR description / commit message:**

[Fizz][Float] Refactor Resources  (#27400)

Refactors Resources to have a more compact and memory efficient
struture. Resources generally are just an Array of chunks. A resource is
flushed when it's chunks is length zero. A resource does not have any
other state.

Stylesheets and Style tags are different and have been modeled as a unit
as a StyleQueue. This object stores the style rules to flush as part of
style tags using precedence as well as all the stylesheets associated
with the precedence. Stylesheets still need to track state because it
affects how we issue boundary completion instructions. Additionally
stylesheets encode chunks lazily because we may never write them as html
if they are discovered late.

The preload props transfer is now maximally compact (only stores the
props we would ever actually adopt) and only stores props for
stylesheets and scripts because other preloads have no resource
counterpart to adopt props into. The ResumableState maps that track
which keys have been observed are being overloaded. Previously if a key
was found it meant that a resource already exists (either in this render
or in a prior prerender). Now we discriminate between null and object
values. If map value is null we can assume the resource exists but if it
is an object that represents a prior preload for that resource and the
resource must still be constructed.

## Working environment

The repository is checked out at `/app/react` at this PR's **base commit**
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
