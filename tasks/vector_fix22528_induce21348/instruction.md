# Code Review Task

You are a maintainer reviewing a pull request to the `vectordotdev/vector` repository.

**PR title:** feat(enriching): add `memory` enrichment table (#21348)

**PR description / commit message:**

feat(enriching): add `memory` enrichment table (#21348)

* feat(vrl): add caching feature for VRL

This adds additional VRL functions for reading and storing data into caches that can be configured
in global options. Caches can store any VRL value and are meant to store data for shorter periods.
All data gets TTL (time-to-live) assigned, based on cache configuration and gets removed when that
TTL expires.

* Add reads and writes metrics for VRL cache

* Rename `cache_set` to `cache_put`

* Add `cache_delete` VRL function

* Add key not found test case for `cache_get`

* Add placeholder implementation for fetching TTL using `cache_get`

* Add memory enrichment table

* Add basic sink implementation for memory enrichment table

This implementation is based on `evmap`, for "lock-free" reading and writing. There is still a lock
when data is refreshed, but that can be controlled, to have less interruptions.

* Add ttl, refresh and scan intervals implementation for memory enrichment table

* Add internal events for memory enrichment table

* Remove initial implementation of VRL cache

* Remove table name from memory enrichment table events

* Add `SinkConfig` impl for `MemoryConfig`

This adds a `SinkConfig` implementation for `MemoryConfig`, making it a shared configuration for
both enrichment table component and the sink component. To ensure that the exact same `Memory`
instance is used, created `Memory` is cached inside the config instance and then shared whenever one
of the `build` variants are invoked.

`Memory` is already built with sharing between different instances in mind, since it had to be
shared across different threads and it is cloneable while keeping the same backing structure for
data.

The actual sink building is a placeholder.

* Hook up enrichment tables as sinks when possible

* Fix flushing in memory enrichment table

* Fix failing memory table tests

* Remove enrichment_tables from Graph and use them as sinks

* Wrap memory metadata in a single object for easier mutex usage

* Add byte size limit to memory enrichment table

* Remove unnecessary duplicated key from memory table entries

* Remove debugging log from memory table

* Ensure `ConfigDiff` takes tables into account

* Implement running topology changes for enrichment_tables like sinks

* Make memory tables visible in `vector top` as sinks

* Remove unnecessary clone when handling events

* Fix tests after removing clones in `handle_value`

* Reduce key clones when writing to memory table

* Store data in memory table as JSON strings instead of `Value` objects

* Enable configuration for disabling key tag in internal metrics

* Add changelog entry

* Add docs for memory enrichment_table

* Fix typo in memory table docs

* Apply suggestions from code review in documentation

Co-authored-by: May Lee <may.lee@datadoghq.com>

* Apply docs suggestions in code too

* Run scan and flush on intervals and not only on writes

* Ensure `scan_interval` can't be zero and handle zero `flush_interval`

* Rename `sinks_and_table_sinks` to `all_sinks`

* Use `Option` instead of `0` for optional memory config values

* Rename `MemoryTableInternalMetricsConfig` to `InternalMetricsConfig`

* Remove enrichment table `unwrap` from topology running

* Use `expect` instead of `unwrap` when capturing write lock

Co-authored-by: Pavlos Rontidis <pavlos.rontidis@gmail.com>

* Fix typo in `src/enrichment_tables/memory/table.rs`

* Add a how it works section for memory enrichment table

* Add documentation above `as_sink` per discussion on the PR

* Fix enrichment memory table tests

* Fix spellcheck error

* Update LICENSE-3rdparty

* Fix cue formatting

* Use NonZeroU64 new_unchecked to fix MSRV check

---------

Co-authored-by: May Lee <may.lee@datadoghq.com>
Co-authored-by: Pavlos Rontidis <pavlos.rontidis@gmail.com>

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
