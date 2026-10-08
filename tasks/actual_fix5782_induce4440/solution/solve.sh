#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/sync-server/src/load-config.js`:

This pull request introduces the defect later reported as "[Bug]: cannot use seconds in the `ACTUAL_TOKEN_EXPIRATION` environment variable". The
problem a user observed, and its root cause:

### Verified issue does not already exist?

- [x] I have searched and found no existing issue

### What happened?

Trying to put a number as the `ACTUAL_TOKEN_EXPIRATION` environment variable like [explained in the docs](https://actualbudget.org/docs/config/oauth-auth/#actual_token_expiration) (I'm using a .env file btw), causes the following error as every value is a parsed as string:

```
Error: token_expiration: Invalid token_expiration value: 86400: value was "86400"
     at Object.validate (/app/node_modules/convict/src/main.js:679:17)
     at file:///app/src/load-config.js:254:14
     at ModuleJob.run (node:internal/modules/esm/module_job:325:25)
     at async ModuleLoader.import (node:internal/modules/esm/loader:606:24)
     at async asyncRunEntryPointWithESMLoader (node:internal/modules/run_main:117:5)
```

```env
ACTUAL_TOKEN_EXPIRATION=86400
```

### Where are you hosting Actual?

Docker

This same root cause must be fixed before merging.
REVIEW_EOF
