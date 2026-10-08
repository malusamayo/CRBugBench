#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/adapters/fetch.js`:

This pull request introduces the defect later reported as "PATCH requests using fetch adapter". The
problem a user observed, and its root cause:

### Describe the bug

When using the fetch adapter, patch requests are failing

### To Reproduce

https://codesandbox.io/p/sandbox/axios-patch-fetch-adapter-nmxp8t


### Expected behavior

Patch requests should succeed with fetch adapter

### Axios Version

v1.7.0-beta.1

### Adapter Version

fetch

### Additional context/Screenshots

This is because per spec (https://fetch.spec.whatwg.org/#methods) methods are case-sensitive, and only some methods are normalized, but patch is not one of them.

The solution is to call `method.toUpparcase()` on 2 places:
https://github.com/axios/axios/blob/v1.x/lib/adapters/fetch.js#L125
https://github.com/axios/axios/blob/v1.x/lib/adapters/fetch.js#L149


Http and xhr adapters do this, probably because of the same reason mentioned above:
https://github.com/axios/axios/blob/v1.x/lib/adapters/http.js#L164
https://github.com/axios/axios/blob/v1.x/lib/adapters/xhr.js#L33

This same root cause must be fixed before merging.
REVIEW_EOF
