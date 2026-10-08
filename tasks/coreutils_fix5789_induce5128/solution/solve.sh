#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uucore/src/lib/features/format/num_format.rs`:

This pull request introduces the defect later reported as "seq: different output for `seq --format=d%030g 12`". The
problem a user observed, and its root cause:

With our:
```
$ ./target/debug/coreutils seq --format=d%030g 15
d000000000000000000000000000001
[...]
d000000000000000000000000000009
d00000000000000000000000001e+01
d00000000000000000000000001e+01
d00000000000000000000000001e+01
```

with GNU:
```
/usr/bin/seq --format=d%030g 15
d000000000000000000000000000001
[...]
d000000000000000000000000000009
d000000000000000000000000000010
d000000000000000000000000000011
d000000000000000000000000000012
d000000000000000000000000000013
d000000000000000000000000000014
d000000000000000000000000000015
```

it causes tests/cp/link-heap to fail

This same root cause must be fixed before merging.
REVIEW_EOF
