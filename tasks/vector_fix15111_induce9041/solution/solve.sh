#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/app.rs`:

This pull request introduces the defect later reported as "Setting `VECTOR_THREADS=0` exits without notification". The
problem a user observed, and its root cause:

### A note for the community

<!-- Please keep this note for the community -->
* Please vote on this issue by adding a 👍 [reaction](https://blog.github.com/2016-03-10-add-reactions-to-pull-requests-issues-and-comments/) to the original issue to help the community and maintainers prioritize this request
* If you are interested in working on this issue or have submitted a pull request, please leave a comment
<!-- Thank you for keeping this note for the community -->


### Problem

We allow users to pass `--threads` or `VECTOR_THREADS` to set the number of worker threads for the tokio runtime. If you pass `0` here Vector is programmed to emit an error message -- see https://github.com/vectordotdev/vector/blob/0575a3a2b12569de9e561b818760511df9611ea6/src/app.rs#L118-L128 -- but in practice this does not actually print.

### Configuration

```text
data_dir = "/var/lib/vector"

##
## Sources
##

[sources.internal_metrics]
type = "internal_metrics"

##
## Transforms
##


##
## Sinks
##

[sinks.blackhole]
type = "blackhole"
inputs = ["internal_metrics"]
```


### Version

vector 0.21.0 (x86_64-unknown-linux-gnu debug=full)

### Debug Output

```text
➜  vector git:(vector_threads_in_soak) ✗ VECTOR_LOGS="debug" VECTOR_THREADS="0" cargo run --bin vector -- --config /tmp/vector-idle.toml
    Finished dev [unoptimized + debuginfo] target(s) in 0.34s
     Running `target/debug/vector --config /tmp/vector-idle.toml`
➜  vector git:(vector_threads_in_soak) ✗ echo $?
78
```
```


### Example Data

_No response_

### Additional Context

_No response_

### References

Discovered while working on #11891.

This same root cause must be fixed before merging.
REVIEW_EOF
