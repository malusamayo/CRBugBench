# Code Review Task

You are a maintainer reviewing a pull request to the `vectordotdev/vector` repository.

**PR title:** fix(datadog_traces sink): APM stats payloads are sent independent of trace payloads and at a set interval.

**PR description:**

### **Reviewer notes:**

- To ignore the reorganization changes, focus on these files (~300 LOC):
    - [traces/apm_stats/flusher.rs](https://github.com/vectordotdev/vector/compare/neuronull/apm_stats_fix_payload_flushing?expand=1#diff-eb192ea4d0429e056ed764b842e3f8339ea8bbc3bb1eff3ec620664f6225f26e)
    - [traces/config.rs](https://github.com/vectordotdev/vector/compare/neuronull/apm_stats_fix_payload_flushing?expand=1#diff-8cf2d378a228070ea2b4bda6439163ae8ac74be08b7927302a81b7b48286e659)
    - [traces/request_builder.rs](https://github.com/vectordotdev/vector/compare/neuronull/apm_stats_fix_payload_flushing?expand=1#diff-a64c8c0e582f456b5ff38f8e43c0f06cd70f31481752a9c3410f7f03385476d6)
    - [traces/sink.rs](https://github.com/vectordotdev/vector/compare/neuronull/apm_stats_fix_payload_flushing?expand=1#diff-478e3799975c41ceb5b54800a2967fc79dcc206f120b0f1b6806e77be44a975c)    

### Behavioral changes:

- APM stats are now "flushed" in a separate thread, detached from the sink's stream loop.
- The stats flushing thread flushes the oldest bucket every 10 seconds, and caches the last two 10 second buckets.
- When sink is shutting down, the APM stats thread flushes remaining buckets.

### Refactor (re-organizing only) changes:

- The single file `stats.rs` was up to 1.2k lines of code. That's too much for my sanity. So I reorganized the code to more closely match the Agent's Golang code organization.
- Note that there wasn't any need to create new structures or anything like that as part of the re-org- I simple moved logic from one file to a handful of smaller files.
- Took the opportunity to add some more documentation/comments to the code

    
###  Manual testing results

The two plotted metrics should be "collapsed" into the same line.

// Agent only (base case)

![agent_only_latest](https://user-images.githubusercontent.com/9162534/199610841-f8f4d3d1-512b-4749-b2e8-afeb271810e3.png)

// Agent -> Vector (before fix)

![vector_and_agent_before_fix](https://user-images.githubusercontent.com/9162534/199610909-5c894138-31fc-40b9-8424-67dfda3dba81.png)

// Agent -> Vector (after fix)

![vector_and_agent_with_fix](https://user-images.githubusercontent.com/9162534/199610983-04dc323e-6979-42b5-9441-dad124ea5b63.png)

## Working environment

The repository is checked out at `/app/vector` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
