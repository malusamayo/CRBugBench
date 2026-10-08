#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `kernel/src/process.rs`:

This pull request introduces the defect later reported as "Process faults". The
problem a user observed, and its root cause:

When I comment out lines 246, 247 and 251 of sched.rs (i.e. never enable the mpu), and flash the rng test app, I get normal output from the app, which is expected.

https://github.com/tock/tock/blob/d67c9d5e70ace179134bbf918525f85384985d33/kernel/src/sched.rs#L241-L251

However, when I now additionally comment out the body of setup_mpu in process.rs, a function which is not called anywhere else, the rng app faults with [this](https://drive.google.com/file/d/1v1Cq1_CzI_5DjZfXRBpUqSmxIx4ZdfJf/view?usp=sharing) error message.

The expected behaviour was normal output from the app. This test was performed on a Hail.

I did a git bisect, and found that "kernel: move chip specific print to arch crate" (part of PR #1115) is the first commit that introduces this issue. Also, @hudson-ayers has mentioned that he gets the same panic message when running certain test apps after he merged commits from master including or past "Merge #1113" into his IP Userland branch.

This same root cause must be fixed before merging.
REVIEW_EOF
