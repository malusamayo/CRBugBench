# Code Review Task

You are a maintainer reviewing a pull request to the `n8n-io/n8n` repository.

**PR title:** :sparkles: Add Stripe regular node (#1470)

**PR description / commit message:**

:sparkles: Add Stripe regular node (#1470)

* :tada: Register node

* :art: Add SVG icon

* :zap: Add preliminary node stub

* :zap: Add resource description stubs

* :art: Fix SVG size and position

* :zap: Implement charge operations

* :zap: Implement customer operations

* :art: Apply cosmetic changes

* :zap: Fix customer address fields

* :zap: Add stub and fields for invoice

* :zap: Add invoice item stubs

* :zap: Implement source operations

* :zap: Reduce scope per feedback

* :zap: Add continueOnFail functionality

* :art: Prettify error thrown

* :fire: Remove unused resource

* :zap: Replace source in card with token

* :hammer: Remove logging

* :wrench: Fix shipping address in charge:create

* :wrench: Load update fields for charge:update

* :zap: Implement token:create to ease testing

* :zap: Simplify card token fields

* :zap: Update description parameters

* :wrench: Fix field adjusters

* :zap: Remove unused source options

* :wrench: Fix shipping fields adjuster

* :fire: Remove PNG icon

* :fire: Remove logging

* :hammer: Reorder address fields

* :bug: Fix shipping field in charge:update

* :lipstick: Apply cosmetic change

* :zap: Small improvements

* :zap: Fix lintings in main file

* :zap: Lint all descriptions

* :zap: Add target="_blank" attribute

* :zap: Fix various lintings for charge

* :zap: Fix lintings for coupon

* :zap: Fix lintings for customer

* :zap: Fix lintings for source

* :zap: Fix lintings for token

* :zap: Reorder address fields

* :zap: Fix casing in credentials

* :hammer: Place recipient name above address in shipping

* :zap: Remove references to string in descriptions

* :zap: Apply minor renamings

* :fire: Remove logging

* :hammer: Simplify error handling

* :zap: Fix indentation

* :zap: Move cardFields to root level for Token creation

Co-authored-by: ricardo <ricardoespinoza105@gmail.com>
Co-authored-by: Jan Oberhauser <jan.oberhauser@gmail.com>

## Working environment

The repository is checked out at `/app/n8n` at this PR's **base commit**
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
