#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/adapters/xhr.js`:

This pull request introduces the defect later reported as "XHR adapter returns a resolved config on errors". The
problem a user observed, and its root cause:

### Describe the bug

Behaviour introduced in #6371 for example here https://github.com/axios/axios/pull/6371/files#diff-2175f7ecc915e8b17c9831b9bbcd0a681759f7227a424964b04ab68e8166dd77R98

### To Reproduce

_No response_

### Code snippet

_No response_

### Expected behavior

XHR adapter returns initial config on errors

### Axios Version

1.7.0-1.7.2

### Adapter Version

XHR

### Browser

_No response_

### Browser Version

_No response_

### Node.js Version

_No response_

### OS

_No response_

### Additional Library Versions

_No response_

### Additional context/Screenshots

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
