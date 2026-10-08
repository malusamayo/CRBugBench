#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uu/sort/src/tmp_dir.rs`:

This pull request introduces the defect later reported as "sort is filling /tmp with uutils_sortXXXX directories". The
problem a user observed, and its root cause:

I'm testing ubuntu 26.04 and by default it runs uutils coreutils.  I started seeing message like this:

`write failed: disk quota exceeded`

and after further investigation I noticed there were lots of `/tmp/uutils_sortXXXXX` leftover directories on /tmp.

This is the version present on ubuntu 26.04: `0.7.0-0ubuntu1`.  I've also opened a [bug](https://bugs.launchpad.net/ubuntu/+source/rust-coreutils/+bug/2147580) on ubuntu launchpad reporting this

This same root cause must be fixed before merging.
REVIEW_EOF
