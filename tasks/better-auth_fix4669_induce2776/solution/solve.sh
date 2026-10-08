#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/better-auth/src/client/query.ts`:

This pull request introduces the defect later reported as "useSession causes hundreds/thousands of duplicate requests under slow network + react async server component hydration". The
problem a user observed, and its root cause:

### Is this suited for github?

- [x] Yes, this is suited for github

### To Reproduce

No, this is not some bad React code that is causing infinite re-renders or something 😄

I narrowed the problem down to this reproducible scenario in my own Next.js app:

1. Create a **Next.js** app and set up Better Auth with minimal configuration.
2. Create a `Navbar` client component that calls the `useSession` hook. (Just calling the hook is enough.)
3. Use the `Navbar` in the root `layout.tsx`. (Must be in a top layout)
4. Create a new `page.tsx` (or use the top-level `page.tsx`). Make this page component an **async function**. (Must be async)  
   > You don’t need to `await` anything inside — simply declaring it as `async` is enough to trigger the issue.
5. Inside this page, render a **medium-sized client component**. (This is very important)  
   > If the component is too small, the bug doesn’t trigger. A “safe” reproduction size is ~200 lines of code with a few UI library components imported.
6. Open Chrome DevTools → **Network** tab, and throttle speed to **3G**.
7. **Check “Disable cache”** in the Network tab. (This often makes the issue reliably reproduce.)
8. Load the page.
9. Watch the network panel — you will see `/api/auth/get-session` requests piling up (hundreds to thousands and sometimes even more).

### Important conditions
For this issue to occur, all three of the following conditions must be met:
- A **slow network connection** (e.g., 3G throttling) 
- **Disable cache** checked in Chrome DevTools (often required in the minimal repro)
- A `useSession` call inside a **client component used in the top layout**  
- A **page component declared as async** (even with no `await` inside)
- A **relatively mediums sized client component rendered inside that async page** (if the component is too small, the issue does not trigger)


### Current vs. Expected behavior

## Expected Behavior
- `useSession` should fire **once** (or at most once per component mount).

## Current Behavior
- `useSession` triggers `/api/auth/get-session` **600–1800 times**, depending on component size and network speed.  
- In some cases, especially in production mode with heavier code, I observed **tens of thousands of requests** continuously being sent and piling up until the page fully loads.


## Minimal Repro Repository
- https://github.com/SorooshGb/better-auth-test2

> This repo consistently reproduces the issue. In this lighter setup, the bug appears more consistently when **Disable cache** is checked in Chrome DevTools (Network tab) while throttling to **3G**.

<img width="1919" height="914" alt="Image" src="https://github.com/user-attachments/assets/504db9b3-3d22-4ff5-a9a7-838bf322cb7d" />

### What version of Better Auth are you using?

1.3.9

### System info

```bash
{
  "system": {
    "platform": "win32",
    "arch": "x64",
    "version": "Windows 11 Home",
    "release": "10.0.26100",
    "cpuCount": 12,
    "cpuModel": "13th Gen Intel(R) Core(TM) i5-13420H",
    "totalMemory": "31.73 GB",
    "freeMemory": "15.26 GB"
  },
  "node": {
    "version": "v22.16.0",
    "env": "development"
  },
  "packageManager": {
    "name": "npm",
    "version": "11.4.2"
  },
  "frameworks": [
    {
      "name": "next",
      "version": "15.4.2"
    },
    {
      "name": "react",
      "version": "19.1.0"
    }
  ],
  "databases": [
    {
      "name": "pg",
      "version": "^8.16.3"
    },
    {
      "name": "drizzle",
      "version": "^0.44.3"
    }
  ],
  "betterAuth": {
    "version": "0.1.0",
    "config": null
  }
}
```

### Which area(s) are affected? (Select all that apply)

Client

### Auth config (if applicable)

```typescript
import { createAuthClient } from 'better-auth/react';
import { inferAdditionalFields } from 'better-auth/client/plugins';
import { auth } from './auth';

export const { signIn, signOut, signUp, useSession } = createAuthClient({
  plugins: [inferAdditionalFields<typeof auth>()],
});
```

### Additional context

## Additional Context
- Reproduced with `useSession` alone — no extra fetch calls in render.
- If the fetch is wrapped in `useEffect` or gated with a `useIsMounted` check, the problem disappears.
- I also tested by adding a simple `console.log('hello')` or a test `fetch('https://jsonplaceholder.typicode.com/todos/1')` call:
  - When wrapped in `useEffect`, they fire **once** as expected.
  - When placed inline in a client component used in the root layout, they fire **hundreds of times** under the same conditions.
- This shows the behavior is tied to Next.js/React async server components and hydration process.
- Normally, developers don’t put fetches inline (they always use `useEffect`), so most apps won’t hit this scenario.
- However, `useSession` internally kicks off a fetch as soon as it mounts, so Better Auth should take this seriously and ensure that fetch calls only happen after hydration somehow.
- This happens in both **dev** and **production** builds (as long as the page is not cached in production).
- From testing, this **does not happen** when `useSession` is called in a normal client component.  
  It only happens when `useSession` is called in a client component used in the **layout**, combined with a route that has an **async page server component**.

## Temporary Workaround
- Wrap the entire navbar (or any `useSession` caller) in a hydration guard (`useIsMounted`) that sets the `isMounted` state to `true` in a `useEffect`, and render the component with the `useSession` only when `isMounted` is `true`.

This same root cause must be fixed before merging.
REVIEW_EOF
