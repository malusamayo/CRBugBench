#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tests/by-util/test_ls.rs`:

This pull request introduces the defect later reported as "test_ls::test_ls_styles failing on  aarch64-apple-darwin". The
problem a user observed, and its root cause:

commit 620a5a5df6b1ca

It fails a regex after running this command.

```bash
coreutils/target/debug/coreutils ls -l --time-style=full-iso
thread 'test_ls::test_ls_styles' panicked at 'assertion failed: re_full.is_match(&result.stdout_str())', 
```
https://github.com/uutils/coreutils/blob/620a5a5df6b1cad6c8279c1b1aef80e401b14c51/tests/by-util/test_ls.rs#L703

I did notice that GNU ls under Linux is giving a different file ordering of AaBbCcDd .. instead of ABCD... abcd ...

This same root cause must be fixed before merging.
REVIEW_EOF
