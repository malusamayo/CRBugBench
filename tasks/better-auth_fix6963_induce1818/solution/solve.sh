#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docs/content/docs/reference/options.mdx`:

This pull request introduces the defect later reported as "accountLinking is NOT disabled by default". The
problem a user observed, and its root cause:

### To Reproduce

1. Do NOT add any `accountLinking` option in your auth instance
2. Perform a social sign in on the client (not OneTap, as that plugin handles it properly, explained more below)
3. See that account linking happens automatically

### Current vs. Expected behavior

I expect the oauth callback to block the sign in request because `accountLinking.enabled` is mentioned to be `false` by default. 

### What version of Better Auth are you using?

1.4.6

### Additional context

`accountLinking.enabled` will return `undefined` if the user doesn't explicitly set it. In several areas throughout the codebase, `accountLinking.enabled` is checked like this `accountLinking?.enabled === false` which will return false. But in OneTap, they just check if enabled is truthy, which is why the OneTap plugin properly honors the default false setting.

Also I will note, the typehint `@default` for `accountLinking.enabled` is `true` but in the docs it says false, this is misleading and confusing.

This same root cause must be fixed before merging.
REVIEW_EOF
