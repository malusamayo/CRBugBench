# Code Review Task

You are a maintainer reviewing a pull request to the `supabase/supabase` repository.

**PR title:** Add settings for queues: toggle expose through postgrest + permissions via table privileges (#30564)

**PR description / commit message:**

Add settings for queues: toggle expose through postgrest + permissions via table privileges (#30564)

* Add settings for queues: toggle expose through postgrest + permissions via table privileges

* Ensure appropriate grants are granted when toggling, and revoked when disabling

* Update to use queues_public schema

* Update queue schema to pgmq_public and add/remove from data api when enabling/disabling

* Fix query for retrieving toggle state

* Add schema invalidation

* Remove hard code

* Use QueuesSettings from Queues folder, remove from NewQueues

* Update SQL for toggling exposure + support RLS enabling

* Support toggling RLS for a queue

* Update admonition copy in queues for enabling/disable postgrest exposure

* Add custom RLS policy for queue

* Minor style fixes

* Fix

* Remove hard code

* Update RLS to add message regarding relevancy only if exposure to PostgREST is enabled

* Update message in exposing queues to postgREST

* Address feedback

* Address feedback

* Don't revoke postgres role stuff

* Remove hard code

* Update copy

* Update

* Address Oli's feedback, ensure that queues ALL have RLS enabled prior to allowing exposure to PostgREST

* Address remaining feedback

* Remove hardcode

* Update

* Address feedback

## Working environment

The repository is checked out at `/app/supabase` at this PR's **base commit**
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
