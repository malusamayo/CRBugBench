# Code Review Task

You are a maintainer reviewing a pull request to the `elsa-workflows/elsa-core` repository.

**PR title:** LogRecord storage at differents levels (#4911)

**PR description / commit message:**

LogRecord storage at differents levels (#4911)

* Adding PersistenceStrategy and filter mapping for ActivityExecutionRecord

* Add default PersistenceStrategy provider/service

update ActivityMapper Implementation

* Fix Forgot to use the  Default Persistence from the Server configuration

* refactor the configuration of persistence in WorkflowManagementFeature

* rename PersistenceStrategy to LogPersistenceMode

* use const to defined LogPersistence Key in json and rename the key to logPersistenceMode

* Refactor PersistenceTab and update project references

Updated various aspects of the PersistenceTab class and its functionality to improve code quality and readability. Simplified the handling of persistence configurations and simplified the use of properties. Transitioned project reference for Elsa.Api.Client from package reference to direct project reference for better development experience in Elsa.Studio.Core.

* - Change how to get the Default Persistence Mode for an Activity.

/**
Because the entire workflow is considered as an activity, the schema must be the same
ie with
"logPersistenceMode": {
               "default": "default",
}
**/

- fix logic to get the default persistence mode working for the whole activity.

* fix default change value

---------

Co-authored-by: Jérémie DEVILLARD <jdevillard@users.noreply.github.com>
Co-authored-by: Sipke Schoorstra <sipkeschoorstra@outlook.com>

## Working environment

The repository is checked out at `/app/elsa-core` at this PR's **base commit**
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
