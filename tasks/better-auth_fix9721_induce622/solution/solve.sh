#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/better-auth/src/plugins/open-api/generator.ts`:

This pull request introduces the defect later reported as "Wrong `/get-session` POST 200 response object in generated OpenAPI spec". The
problem a user observed, and its root cause:

### Is this suited for github?

- [x] Yes, this is suited for github

### Reproduction

1. Add openAPI plugin
2. Download the OpenAPI spec from `/auth/open-api/generate-schema`

### Current vs. Expected behavior

```json
...
"/get-session": {
  "post": {
    ...
    "responses": {
      "200": "[Circular ref-277]",
```

```json
...
"/get-session": {
  "post": {
    ...
    "responses": {
      "200": {
        ...
      },
```

### What version of Better Auth are you using?

1.6.11

### System info

```bash
{
  "system": {
    "platform": "darwin",
    "arch": "arm64",
    "version": "Darwin Kernel Version 25.4.0: Thu Mar 19 19:30:44 PDT 2026; root:xnu-12377.101.15~1/RELEASE_ARM64_T6000",
    "release": "25.4.0",
    "cpuCount": 8,
    "cpuModel": "Apple M1 Pro",
    "totalMemory": "16.00 GB",
    "freeMemory": "0.21 GB"
  },
  "node": {
    "version": "v25.7.0",
    "env": "development"
  },
  "packageManager": {
    "name": "bun",
    "version": "1.2.23"
  },
  "frameworks": null,
  "databases": null,
  "betterAuth": {
    "version": "Unknown",
    "config": null
  }
}
```

### Which area(s) are affected? (Select all that apply)

Other, Backend

### Auth config (if applicable)

```typescript
betterAuth({
    appName: '***',
    baseURL: ***,
    basePath: '/auth',
    database: drizzleAdapter(db, {
      provider: 'pg',
      usePlural: true,
    }),
    user: {
      ***
    },
    secret: ***,
    socialProviders: {
      apple: {
        clientId: ***,
        clientSecret: ***,
        appBundleIdentifier: ***,
        audience: [***],
      },
      google: {
        clientId: ***,
        clientSecret: ***,
      },
    },
    trustedOrigins: ['https://appleid.apple.com'],
    advanced: {
      database: {
        generateId: false,
      },
      cookiePrefix: '***',
      disableCSRFCheck: true,
      ipAddress: {
        ipAddressHeaders: [***],
      },
    },
    plugins: [
      bearer(),
      openAPI(),
      dash({
        apiKey: ***,
      }),
      admin({
        ac,
        roles: {
          ***
        },
      }),
      emailOTP({
        sendVerificationOTP: ***,
        otpLength: 6,
        storeOTP: 'hashed',
      }),
    ],
    telemetry: {
      enabled: false,
    },
  })
```

### Additional context

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
