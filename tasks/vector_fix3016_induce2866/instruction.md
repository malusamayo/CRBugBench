# Code Review Task

You are a maintainer reviewing a pull request to the `vectordotdev/vector` repository.

**PR title:** enhancement(sinks): Batch buffer rework (#2866)

**PR description / commit message:**

enhancement(sinks): Batch buffer rework (#2866)

* Add new VecBuffer wrapper around Vec

This new buffer type keeps track of its maximum size, and pre-allocates
the buffer.

* Add BatchSettings parameter to all buffers

* Move detection of batch "fullness" to trait Batch

This also drops fn len, as it is no longer necessary.

* Make the Batch::push trait method failable

This requires reworking the logic in BatchSink::start_send, and so
demands some close scrutiny.

* Introduce StatefulBuffer wrapper and clean up BatchSink

* Drop superfluous Batch::is_full trait method

* Merge BatchBytesConfig and BatchEventsConfig and adjust sinks

* Account for the separating "," in JsonArrayBuffer

* Use a simplified fake-ish builder pattern to build BatchSettings

* Split up batch size and timeout settings

* Manually track number of bytes written in Buffer

* Handle individual items that are too large to buffer

If the first event to be added to a buffer is too large, this could
cause a sink pipeline to permanently block. Instead, drop the output
event with an error message but return as if it was added.

* Drop test batch_sink_allows_the_final_item_to_exceed_the_buffer_size

We explicitly do not want batches to exceed the buffer size.

Signed-off-by: Bruce Guenter <bruce@timber.io>

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
