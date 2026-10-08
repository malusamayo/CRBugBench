#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react-devtools-inline/webpack.config.js`:

This pull request introduces the defect later reported as "Bug(react-devtools-inline@4.11.0): publish artifact points to /Users/bvaughn/Documents/git/react.devtools/". The
problem a user observed, and its root cause:

Published `react-devtools-inline@4.11.0` has the following piece of code in `react-devtools-inline/dist/backend.js`:

```js
module.exports = require("/Users/bvaughn/Documents/git/react.devtools/packages/react-devtools-shared/src/config/DevToolsFeatureFlags.default");
```
:roll_eyes:

This same root cause must be fixed before merging.
REVIEW_EOF
