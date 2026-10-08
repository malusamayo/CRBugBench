#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uu/mv/src/mv.rs`:

This pull request introduces the defect later reported as "mv: shouldn't panic when xattr application fails". The
problem a user observed, and its root cause:

```rust
#[cfg(all(unix, not(any(target_os = "macos", target_os = "redox"))))]
fsxattr::apply_xattrs(to, xattrs).unwrap();
```

https://github.com/uutils/coreutils/blob/main/src/uu/mv/src/mv.rs#L676-L677

This code panics when "moving" (copying) a file to a different filesystem, and applying the extended attrs fails. This can happen for many reasons:
- TOCTOU races (e.g. file was moved/deleted)
- destination filesystem doesn't support xattrs
- user doesn't have permissions to set xattrs

`mv` should not panic in those cases. Instead, it should probably output some form of warning message and continue moving the other files, or whatever GNU `mv` does.

Discovered while reviewing https://github.com/uutils/coreutils/pull/6632#discussion_r1772306054

This same root cause must be fixed before merging.
REVIEW_EOF
