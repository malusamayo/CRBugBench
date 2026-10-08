# Code Review Task

You are a maintainer reviewing a pull request to the `bisq-network/bisq` repository.

**PR title:** Refactor option parsing configuration

**PR description / commit message:**

Refactor option parsing configuration

This change eliminates the BisqExecutable.description method and
replaces it with proper use of the `describedAs` and `defaultsTo`
methods in the JOptSimple API. This removes the concern of formatting
option argument descriptions and default values from the BisqExecutable
class, and delegates it to the new BisqHelpFormatter (see previous
commit), which is designed for the purpose.

For example, prior to this commit, the help text for the --banList
option read as follows:

    --banList=<value>
            Nodes to exclude from network connections. (default: )

Now it reads as follows:

    --banList=<host:port[,...]>
            Nodes to exclude from network connections.

Likewise, previous to this commit, the --logLevel option read as
follows:

    --logLevel=<value>
            Log level [OFF, ALL, ERROR, WARN, INFO, DEBUG, TRACE]
            (default: INFO)

And now it reads like this:

    --logLevel=<OFF|ALL|ERROR|WARN|INFO|DEBUG|TRACE> (default: INFO)
            Log level

There are a number of further improvements that can and should be made
to the description text of the various options, the types specified for
their arguments, etc, but these will be handled in subsequent commits.
This commit is strictly about refactoring existing parser configuration
to take advantage of the new BisqHelpFormatter.

## Working environment

The repository is checked out at `/app/bisq` at this PR's **base commit**
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
