# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Optimize capacity bumping for adaptive ByteBufs (#15080)

**PR description / commit message:**

Optimize capacity bumping for adaptive ByteBufs (#15080)

Motivation:
It is quite common in downstream code to not specify a buffer size when
allocating.
People instead rely on the ByteBuf ability to increase its size
automatically.
The ByteBufs allocated by the adaptive allocator also support this, but
has thus far required a round-trip through the allocator every time.
In contrast, the pooled allocator is reserving the chunk run-size when
allocating buffers, and very cheaply allow smaller buffers to bump up to
the run-size limit.
This is an important performance optimisation in practice.
We can do something similar in the adaptive allocator, because we keep
statistics about the buffer sizes that we allocate.

Modification:
The adaptive allocator now reserves space equal to the 99-percentile
buffer size (though with some reasonable heuristic limits for smaller buffers),
when allocating buffers, and allow its ByteBufs to cheaply
bump their capacities up to this limit.
We already compute this percentile during histogram rotation, so it is
simply a matter of storing this value in the magazine, and then using it
when reserving space out of chunks.

The collection of buffer size statistics is now also delayed and moved
to when the `ByteBuf` instances are reused. This way, we collect
statistics about the _final_ buffer size, rather than the requested
sizes or the sizes of capacity bumps.
This prevents oscillations that would otherwise be caused by undersized
buffers producing a lot of statistics as they resize to their final
size, and then no statistics being produced for the final buffer sizes
if they are correctly predicted at allocation time.

Result:
Calls like `ByteBuf.ensureWritable()` will now on average be much
cheaper when using the adaptive allocator.

Based on https://github.com/netty/netty/pull/15062

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
