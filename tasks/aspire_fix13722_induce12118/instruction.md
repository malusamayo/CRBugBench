# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/aspire` repository.

**PR title:** Add `aspire update --self` command for CLI self-updates (#12118)

**PR description / commit message:**

Add `aspire update --self` command for CLI self-updates (#12118)

* Initial plan

* Add aspire self update command implementation

Co-authored-by: mitchdenny <513398+mitchdenny@users.noreply.github.com>

* Add documentation for aspire self update command

Co-authored-by: mitchdenny <513398+mitchdenny@users.noreply.github.com>

* Use File.GetUnixFileMode/SetUnixFileMode instead of chmod command

Co-authored-by: davidfowl <95136+davidfowl@users.noreply.github.com>

* Display version after update and hide self command for dotnet tool

Co-authored-by: davidfowl <95136+davidfowl@users.noreply.github.com>

* Update quality names to match existing channels and add interactive prompt

Co-authored-by: davidfowl <95136+davidfowl@users.noreply.github.com>

* Change command from 'aspire self update' to 'aspire update --self'

Co-authored-by: davidfowl <95136+davidfowl@users.noreply.github.com>

* Use ShowStatusAsync for CLI download operation

Co-authored-by: davidfowl <95136+davidfowl@users.noreply.github.com>

* Fix tests.

* Update emojis.

* Emoji fixes.

* Move CLI download URLs from CliDownloader to PackagingService

Co-authored-by: mitchdenny <513398+mitchdenny@users.noreply.github.com>

* PR feedback.

* Apply PR feedback: use Directory.CreateTempSubdirectory, singleton HttpClient, Path.PathSeparator, and log warnings

Co-authored-by: davidfowl <95136+davidfowl@users.noreply.github.com>

---------

Co-authored-by: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
Co-authored-by: mitchdenny <513398+mitchdenny@users.noreply.github.com>
Co-authored-by: davidfowl <95136+davidfowl@users.noreply.github.com>
Co-authored-by: Mitch Denny <mitch@mitchdeny.com>
Co-authored-by: Mitch Denny <midenn@microsoft.com>

## Working environment

The repository is checked out at `/app/aspire` at this PR's **base commit**
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
