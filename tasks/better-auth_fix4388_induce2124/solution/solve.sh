#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/better-auth/src/plugins/custom-session/custom-session.test.ts`:

This pull request introduces the defect later reported as "customSession with cookieCache enabled not returning Set-Cookie header for session_token". The
problem a user observed, and its root cause:

### Is this suited for github?

- [x] Yes, this is suited for github

### To Reproduce

1. Setup auth with customSession plugin and cookieCache enabled
2. Perform getSession from client side
3. Check the response headers

### Current vs. Expected behavior

Current:
Set-Cookie header is returned for the session_data, but NOT for session_token

Expected:
Set-Cookie header is returned for both session_data and session_token

### What version of Better Auth are you using?

1.3.4

### Provide environment information

```bash
- OS: Ubuntu
- Browser: Chrome
```

### Which area(s) are affected? (Select all that apply)

Client

### Auth config (if applicable)

```typescript
import { betterAuth } from "better-auth"
export const auth = betterAuth({
  session: {
    expiresIn: 120,
    updateAge: 20, // Short update age to test session refresh
    cookieCache: {
      enabled: true,
      maxAge: 10,
    },
  },
  plugins: [
    customSession(async ({ user, session }) => {
      return {
        user: {
          ...user,
          newField: 'newField',
        },
        session,
      };
    }),
  ],
});
```

### Additional context

The session_token cookie gets returned when customSession is NOT used.
The session_token cookie also gets returned if cookieCache is disabled, while customSession is being used.

This issue only happens when both customSession and cookieCache are being used together.

Given that the session_token Set-Cookie header is never returned on getSession, the expiry will not get refreshed and client will eventually be logged out, despite the session expiry getting refreshed on db side.

Could be related to https://github.com/better-auth/better-auth/issues/2106

This same root cause must be fixed before merging.
REVIEW_EOF
