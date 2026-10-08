#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/better-auth/src/db/schema.ts`:

This pull request introduces the defect later reported as "Input validator saves the values as a json in the database on v1.4.0 and up". The
problem a user observed, and its root cause:

### Is this suited for github?

- [x] Yes, this is suited for github

### To Reproduce

1. add additional fields to your user in configs
2. add something like a bio field
3. add validation to the bio
```javascript
 user: {
    additionalFields: {
      bio: {
        type: "string",
        required: false,
        defaultValue: "",
        validator: {
          input: z.string().max(500),
          output: z.string().max(500),
        },
      },
    },
  }
```
4. save a bio in the user's account

### Current vs. Expected behavior

I was expecting the bio (or any other field with validator) to be saved as is but it saves as a json:
```json 
{"value":"Hi, this bio is supposed to be a string!"}
```

i tried going back to v1.3.28 and it worked perfectly fine. but once i updated to 1.4.0 and up to 1.4.5 (latest) this issue happened.

it happens whenever i use the validator, otherwise it works fine when no validator is used

### What version of Better Auth are you using?

1.4.5

### System info

```bash
{
  "system": {
    "platform": "win32",
    "arch": "x64",
    "version": "Windows 11 Pro",
    "release": "10.0.26100",
    "cpuCount": 12,
    "cpuModel": "AMD Ryzen 5 5600G with Radeon Graphics         ",
    "totalMemory": "15.37 GB",
    "freeMemory": "0.56 GB"
  },
  "node": {
    "version": "v22.18.0",
    "env": "development"
  },
  "packageManager": {
    "name": "pnpm",
    "version": "10.17.1"
  },
  "frameworks": [
    {
      "name": "next",
      "version": "16.0.1"
    },
    {
      "name": "react",
      "version": "19.2.0"
    }
  ],
  "databases": [
    {
      "name": "postgres",
      "version": "^3.4.7"
    },
    {
      "name": "drizzle",
      "version": "^0.44.6"
    },
    {
      "name": "@neondatabase/serverless",
      "version": "^1.0.2"
    }
  ],
  "betterAuth": {
    "version": "^1.4.5",
    "config": null
  }
}
```

### Which area(s) are affected? (Select all that apply)

Backend

### Auth config (if applicable)

```typescript
import { env } from "@/env";
import { betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { nextCookies } from "better-auth/next-js";
import { admin } from "better-auth/plugins";
import { z } from "zod";

import { db } from "@/server/db";
import { schema } from "@/server/db/schema";

export const auth = betterAuth({
  appName: "appName",
  database: drizzleAdapter(db, {
    provider: "pg", // or "pg" or "mysql"
    schema: schema,
  }),

  ...(env.NODE_ENV === "development" && {
    trustedOrigins: ["https://192.168.4.100:3000"],
  }),

  user: {
    additionalFields: {
      countryIsoCode: {
        type: "string",
        required: false,
      },
      phoneNumber: {
        type: "string",
        required: false,
      },
      bio: {
        type: "string",
        required: false,
        defaultValue: "",
        validator: {
          input: z.string().max(500),
          output: z.string().max(500),
        },
      },
    },
  },
  advanced: {
    ...(env.NODE_ENV === "production" && {
      defaultCookieAttributes: {
        httpOnly: true,
        secure: true,
      },
    }),
    cookiePrefix: "myapp",
  },
  logger: {
    disabled: false,
    disableColors: false,
    level: "error",
    log: (level, message, ...args) => {
      // Custom logging implementation
      // eslint-disable-next-line @typescript-eslint/no-unsafe-argument
      console.log(`[${level}] ${message}`, ...args);
    },
  },
  telemetry: {
    debug: true,
  },
  emailAndPassword: {
    enabled: true,
    autoSignIn: true,
    minPasswordLength: 8,
    maxPasswordLength: 128,
  },
  plugins: [
    admin({
      defaultRole: "user",
      adminRoles: ["admin"],
    }),
    nextCookies(), // make sure this is the last plugin in the array
  ],
});

export type Session = typeof auth.$Infer.Session;
```

### Additional context

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
