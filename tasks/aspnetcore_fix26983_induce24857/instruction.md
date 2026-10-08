# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/aspnetcore` repository.

**PR title:** Add support delegating requests in HttpSysServer (#24857)

**PR description / commit message:**

Add support delegating requests in HttpSysServer (#24857)

* Add new ctors for RequestQueue and UrlGroup

* Add DelegateRequest pinvokes

* Add Request Transfer Feature

* Fix accessibility of feature

* Test cleanup

* Update ref assembly

* hack: Make HttpSysServer packable

* Cleanup based on PR feedback

* Avoid sending headers after transfer

* Fix ref assembly

* Fix rebase conflict

* Switch to DelegateRequestEx

* Add feature detection

* Delete ref folder

* Add server feature

* s/RequestQueueWrapper/DelegationRule

* Fix UrlGroup was null issue

* Add light-up for ServerDelegationPropertyFeature

* Revert changes to sample

* Revert changes to sample take 2

* PR feedback

* s/Transfered/Transferred

* DelegateAfterRequestBodyReadShouldThrow

* Make DelegationRule disposable

* More license headers

* Incomplete XML doc

* PR feedback

* Fix broken test

* PR feedback

* Fixup test

* s/Transfer/Delegate

* s/transfer/delegate

* PR feedback

## Working environment

The repository is checked out at `/app/aspnetcore` at this PR's **base commit**
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
