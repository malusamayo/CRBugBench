#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Indexers/CardigannIndexer.cs`:

This pull request introduces the defect later reported as "[bug] hardcoded size broken". The
problem a user observed, and its root cause:

Bug caused by https://github.com/Jackett/Jackett/commit/f2c760ce8c278f07d732ef9efefdf3e8c0d77473 (v0.18.686 anyway) - hardcoded size with additional optional size selector no longer works, just shows `0 B`

Example - search using OnceSearch on v0.18.686 (0 B) vs v0.18.666 (256 MB)

https://github.com/Jackett/Jackett/blob/0841f453bfa466dfa5a81ea196011301915e04f8/src/Jackett.Common/Definitions/oncesearch.yml#L129-L133

Hardcoded size on its own works, it's only when there's also an optional size selector that it fails.

This same root cause must be fixed before merging.
REVIEW_EOF
