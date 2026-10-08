#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `embassy-rp/src/uart/mod.rs`:

This pull request introduces the defect later reported as "panic in embassy-rp's uartrx.read_to_break". The
problem a user observed, and its root cause:

I've got a panic in embassy-rp's uartrx.read_to_break.
[Line 608](https://github.com/embassy-rs/embassy/blob/main/embassy-rp/src/uart/mod.rs#L608) returns a usize that is calculated through doing `(next_addr - 1) - sval`, however in my case it appears that both `next_addr` and `sval` are the same value meaning that with the minus one we try to return `-1` as usize.
There is a check [a few lines above](https://github.com/embassy-rs/embassy/blob/main/embassy-rp/src/uart/mod.rs#L588) which checks if `next_addr` is smaller than `sval` but it doesn't check if they are the same

This same root cause must be fixed before merging.
REVIEW_EOF
