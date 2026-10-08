# Code Review Task

You are a maintainer reviewing a pull request to the `vectordotdev/vector` repository.

**PR title:** enhancement(observability): GraphQL client (#3778)

**PR description / commit message:**

enhancement(observability): GraphQL client (#3778)

* wip

Signed-off-by: Lee Benson <lee@leebenson.com>

* API v2

Signed-off-by: Lee Benson <lee@leebenson.com>

* -println

Signed-off-by: Lee Benson <lee@leebenson.com>

* happy clippy

Signed-off-by: Lee Benson <lee@leebenson.com>

* copyable playground url

Signed-off-by: Lee Benson <lee@leebenson.com>

* loop

Signed-off-by: Lee Benson <lee@leebenson.com>

* ohNo

* fix conflicts

Signed-off-by: Lee Benson <lee@leebenson.com>

* fix config tests

Signed-off-by: Lee Benson <lee@leebenson.com>

* stop breaking things

Signed-off-by: Lee Benson <lee@leebenson.com>

* separate metrics

Signed-off-by: Lee Benson <lee@leebenson.com>

* 3x metrics

Signed-off-by: Lee Benson <lee@leebenson.com>

* health and playground tests

Signed-off-by: Lee Benson <lee@leebenson.com>

* graphql client; health test

Signed-off-by: Lee Benson <lee@leebenson.com>

* start server

Signed-off-by: Lee Benson <lee@leebenson.com>

* required-features

Signed-off-by: Lee Benson <lee@leebenson.com>

* Update Cargo.lock

* server shutdown

Signed-off-by: Lee Benson <lee@leebenson.com>

* fix API server scope

Signed-off-by: Lee Benson <lee@leebenson.com>

* drop(server)

Signed-off-by: Lee Benson <lee@leebenson.com>

* fix events/mod

* minor cleanup

Signed-off-by: Lee Benson <lee@leebenson.com>

* lint

Signed-off-by: Lee Benson <lee@leebenson.com>

* wip

* heartbeat

Signed-off-by: Lee Benson <lee@leebenson.com>

* retry_until

* check-internal-events

Signed-off-by: Lee Benson <lee@leebenson.com>

* working client

* check-fmt

Signed-off-by: Lee Benson <lee@leebenson.com>

* heartbeat assertions

Signed-off-by: Lee Benson <lee@leebenson.com>

* gen newline

* drop moot helper

* close -> stop

Signed-off-by: Lee Benson <lee@leebenson.com>

* uptime metrics

Signed-off-by: Lee Benson <lee@leebenson.com>

* events processed test

Signed-off-by: Lee Benson <lee@leebenson.com>

* parallel subscriptions

Signed-off-by: Lee Benson <lee@leebenson.com>

* minor use

Signed-off-by: Lee Benson <lee@leebenson.com>

* extra commentary

Signed-off-by: Lee Benson <lee@leebenson.com>

* fix tests

Signed-off-by: Lee Benson <lee@leebenson.com>

## Working environment

The repository is checked out at `/app/vector` at this PR's **base commit**
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
