#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react-dom-bindings/src/server/ReactFlightServerConfigDOM.js`:

This pull request introduces the defect later reported as "Link preload must have a valid `as`". The
problem a user observed, and its root cause:

### Link to the code that reproduces this issue

https://codesandbox.io/p/devbox/kind-elbakyan-fgg4tv?workspaceId=ws_NduBwxz3MLYn31fcaz2JTB

### To Reproduce

Import a .css file
Start the application in dev mode
A warning is logged for each css file:

```
<link rel=preload> must have a valid `as` value
```

### Current vs. Expected behavior

Stylesheets should be correctly loaded, and not trigger a browser warning.

It appears because as="stylesheet" is not a valid as value. It should be style according to [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rel/preload#what_types_of_content_can_be_preloaded).

```html
<link rel="preload" href="/_next/static/chunks/%5Broot-of-the-server%5D__02ec3763._.css" as="stylesheet"/>
```

### Provide environment information

```bash
Operating System:
  Platform: darwin
  Arch: arm64
  Version: Darwin Kernel Version 24.6.0: Mon Jul 14 11:30:29 PDT 2025; root:xnu-11417.140.69~1/RELEASE_ARM64_T6000
  Available memory (MB): 16384
  Available CPU cores: 10
Binaries:
  Node: 22.20.0
  npm: 10.8.2
  Yarn: N/A
  pnpm: 10.17.1
Relevant Packages:
  next: 15.6.0-canary.45 // Latest available version is detected (15.6.0-canary.45).
  eslint-config-next: N/A
  react: 19.2.0
  react-dom: 19.2.0
  typescript: 5.9.3
Next.js Config:
  output: N/A
```

### Which area(s) are affected? (Select all that apply)

Not sure

### Which stage(s) are affected? (Select all that apply)

next dev (local), Vercel (Deployed), next start (local), Other (Deployed)

### Additional context

The issue started showing up in 15.6.0-canary.32. Previous versions do not include a preload link for stylesheets.

This same root cause must be fixed before merging.
REVIEW_EOF
