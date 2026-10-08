#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/better-auth/src/client/index.ts`:

This pull request introduces the defect later reported as "monorepo/turborepo: Inferred type of 'authClient' cannot be named without a reference to .pnpm/nanostores. A type annotation is necessary". The
problem a user observed, and its root cause:

### Is this suited for github?

- [x] Yes, this is suited for github

### To Reproduce

Running a turborepo monorepo (NextJS 15)

```
The inferred type of 'authClient' cannot be named without a reference to '.pnpm/nanostores@0.11.3/node_modules/nanostores'. This is likely not portable. A type annotation is necessary.
```

If we typecast it with return type
```ts
export const authClient: ReturnType<typeof createAuthClient> = createAuthClient(
  {
    baseURL: process.env.NEXT_PUBLIC_APP_URL,
    plugins: [adminClient()],
  }
);
```
Errors goes away but we dont infer the routes from plugins. Example:
```ts
 const response = await authClient.admin.listUsers({
          query: { limit: 10 },
        });
```
Would error with:
```
Property 'admin' does not exist on type '{ signIn: { social: <FetchOptions extends { method?: string | undefined; headers?: (HeadersInit & (HeadersInit | CommonHeaders)) | undefined; redirect?: RequestRedirect | undefined; ... 32 more ...; disableValidation?: boolean | undefined; }>(data_0: Prettify<...>, data_1?: FetchOptions | undefined) => Promise<...>;...'.
```

Setting `preserveSymlinks": true` would make the error go away but all types would be inferred as `any`.

using `inferAdditionalFields` does not work in this case

```ts
import { inferAdditionalFields } from "better-auth/client/plugins";
import { createAuthClient } from "better-auth/react";
import type { auth } from "./auth";
 
export const authClient = createAuthClient({
  plugins: [inferAdditionalFields<typeof auth>()],
});
```

### Current vs. Expected behavior

I would want it to work out of the box with inference.

### What version of Better Auth are you using?

1.1.16

### Provide environment information

```bash
- pnpm: v9.15.0
- node: v20.17.0
- "turbo": "^2.3.3",
```

### Which area(s) are affected? (Select all that apply)

Types, Client

### Auth config (if applicable)

```typescript
import { betterAuth } from "better-auth"
export const auth = betterAuth({
  emailAndPassword: {  
    enabled: true
  },
});
```

### Additional context

This is my tsconfig.json
```json
{
  "extends": "@resellguru/typescript-config/nextjs.json",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./*"],
      "@resellguru/ui/*": ["../../packages/ui/src/*"]
    },
    "plugins": [
      {
        "name": "next"
      }
    ],
  },
  "include": [
    "next-env.d.ts",
    "next.config.mjs",
    "**/*.ts",
    "**/*.tsx",
    ".next/types/**/*.ts"
  ],
  "exclude": ["node_modules"]
}
```

Issue seems to appear in a lot of other cases: An example
[Typescript #42873](https://github.com/microsoft/TypeScript/issues/42873#issuecomment-2066874644)

This same root cause must be fixed before merging.
REVIEW_EOF
