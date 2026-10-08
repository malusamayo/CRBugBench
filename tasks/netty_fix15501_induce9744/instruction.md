# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Avoid extra Runnable allocs when scheduling tasks outside event loop (#9744)

**PR description / commit message:**

Avoid extra Runnable allocs when scheduling tasks outside event loop (#9744)


Motivation

Currently when future tasks are scheduled via EventExecutors from a
different thread, at least two allocations are performed - the
ScheduledFutureTask wrapping the to-be-run task, and a Runnable wrapping
the action to add to the scheduled task priority queue. The latter can
be avoided by incorporating this logic into the former.

Modification

- When scheduling or cancelling a future task from outside the event
loop, enqueue the task itself rather than wrapping in a Runnable
- Have ScheduledFutureTask#run first verify the task's deadline has
passed and if not add or remove it from the scheduledTaskQueue depending
on its cancellation state
- Add new outside-event-loop benchmarks to ScheduleFutureTaskBenchmark

Result

Fewer allocations when scheduling/cancelling future tasks

## Working environment

The repository is checked out at `/app/netty` at this PR's **base commit**
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
