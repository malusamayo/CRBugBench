# Code Review Task

You are a maintainer reviewing a pull request to the `OpenRefine/OpenRefine` repository.

**PR title:** Support for file upload to Wikibase instances without structured data support (#5158)

**PR description / commit message:**

Support for file upload to Wikibase instances without structured data support (#5158)

* Disable fetching of the existing entity for some Wikibase edits.

This is a hack to repurpose the Wikibase integration to be able to upload
files on MediaWiki instances which do not use Structured Data (MediaInfo) entities.
I am not proud of it. I apologize to anyone who will suffer from the consequences
in the future.

* Introduce flag to hide structured fields in MediaInfo entities when not supported

* Documentation

* Linting

* Upgrade WDTK to 0.14.1

## Working environment

The repository is checked out at `/app/OpenRefine` at this PR's **base commit**
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
