#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uu/date/src/date.rs`:

This pull request introduces the defect later reported as "Military timezone parsing shows incorrect date (1 day ahead)". The
problem a user observed, and its root cause:

GNU:
```
  $ TZ=UTC-5 /usr/bin/date -d "B" "+%F %T %Z"
  2025-12-22 03:00:00 UTC
```

  Rust:
  ```
$ TZ=UTC-5 ./target/debug/date -d "B" "+%F %T %Z"
  2025-12-23 03:00:00 UTC
```

  - GNU date: Shows December 22 with military timezone "B"
  - Rust date: Shows December 23 (1 day ahead) with same input
  - Pattern consistent across military timezones A, B, C - all show +1 day in Rust
  - Times are correct (04:00, 03:00, 02:00) but date is wrong

  Found with a fuzzer

This same root cause must be fixed before merging.
REVIEW_EOF
