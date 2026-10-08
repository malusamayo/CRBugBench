#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uu/seq/src/numberparse.rs`:

This pull request introduces the defect later reported as "seq: zero gets padded if specified with scientific notation". The
problem a user observed, and its root cause:

I noticed that if I specify zero with scientific notation (and without specifying `-w`), the zero gets padded. With GNU `seq`, there is no padding:
```
$ cargo run -q seq 0e15 1
0000000000000000
1
$ seq 0e15 1
0
1
```

This same root cause must be fixed before merging.
REVIEW_EOF
