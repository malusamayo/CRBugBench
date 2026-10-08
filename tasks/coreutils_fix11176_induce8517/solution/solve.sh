#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uucore/src/lib/features/safe_traversal.rs`:

This pull request introduces the defect later reported as "0.6.0 release broken on NetBSD". The
problem a user observed, and its root cause:

Hi,

`coreutils` v0.5.0 builds fine on NetBSD, while v0.6.0 fails to build `uucore` with:

```
error[E0609]: no field `st_atime_nsec` on type `FileStat`
   --> /usr/pkgsrc/wip/nushell/work/vendor/uucore-0.6.0/src/lib/features/safe_traversal.rs:482:23
    |
482 |             self.stat.st_atime_nsec
    |                       ^^^^^^^^^^^^^ unknown field
    |
help: a field with a similar name exists
    |
482 -             self.stat.st_atime_nsec
482 +             self.stat.st_atimensec
    |

error[E0609]: no field `st_mtime_nsec` on type `FileStat`
   --> /usr/pkgsrc/wip/nushell/work/vendor/uucore-0.6.0/src/lib/features/safe_traversal.rs:504:23
    |
504 |             self.stat.st_mtime_nsec
    |                       ^^^^^^^^^^^^^ unknown field
    |
help: a field with a similar name exists
    |
504 -             self.stat.st_mtime_nsec
504 +             self.stat.st_mtimensec
    |

error[E0609]: no field `st_ctime_nsec` on type `FileStat`
   --> /usr/pkgsrc/wip/nushell/work/vendor/uucore-0.6.0/src/lib/features/safe_traversal.rs:526:23
    |
526 |             self.stat.st_ctime_nsec
    |                       ^^^^^^^^^^^^^ unknown field
    |
help: a field with a similar name exists
    |
526 -             self.stat.st_ctime_nsec
526 +             self.stat.st_ctimensec
    |
```

This was observed while building `nushell` v0.111.0 see, https://github.com/nushell/nushell/issues/17695#issuecomment-3984104778

The same happens building `coreutils` standalone with cargo.

The reason is rather obvious,
```
~> grep -r "st_atime_nsec" libc-0.2.178/src/unix/bsd/netbsdlike/netbsd
Exception: grep exited with 1
~> grep -r "st_mtime_nsec" libc-0.2.178/src/unix/bsd/netbsdlike/netbsd
Exception: grep exited with 1
~> grep -r "st_ctime_nsec" libc-0.2.178/src/unix/bsd/netbsdlike/netbsd
Exception: grep exited with 1
~> grep -r "st_atimensec" libc-0.2.178//src/unix/bsd/netbsdlike/netbsd
libc-0.2.178/src/unix/bsd/netbsdlike/netbsd/mod.rs:        pub st_atimensec: c_long,
~> grep -r "st_mtimensec" libc-0.2.178//src/unix/bsd/netbsdlike/netbsd
libc-0.2.178/src/unix/bsd/netbsdlike/netbsd/mod.rs:        pub st_mtimensec: c_long,
~> grep -r "st_ctimensec" libc-0.2.178//src/unix/bsd/netbsdlike/netbsd
libc-0.2.178/src/unix/bsd/netbsdlike/netbsd/mod.rs:        pub st_ctimensec: c_long,
```

And the same output is valid for the latest `libc`, v0.2.182.

Any reason for this regression and are you willing to fix it?

This same root cause must be fixed before merging.
REVIEW_EOF
