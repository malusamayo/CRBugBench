#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frontend/src/hooks/query/use-feedback-exists.ts`:

This pull request introduces the defect later reported as "[Bug]: "Error: No route matches URL "/feedback/conversation/{convo}/4"". The
problem a user observed, and its root cause:

### Is there an existing issue for the same bug? (If one exists, thumbs up or comment on the issue instead).

- [x] I have checked the existing issues.

### Describe the bug and reproduction steps

When running the main branch locally using the development workflow of `make build && make run` I get the following error:

```
16:02:41 - openhands:INFO: llm_utils.py:39 - Removing unsupported format "uri" for STRING parameter "url"
INFO:     127.0.0.1:59567 - "GET /api/conversations/21bac69c88dc47aebabdad33c6749519/git/changes HTTP/1.1" 200 OK
Error: No route matches URL "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/4"
    at getInternalRouterError (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:4514:5)
    at Object.query (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:2728:19)
    at handleDocumentRequest (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:11037:40)
    at requestHandler (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:10952:24)
    at processTicksAndRejections (node:internal/process/task_queues:105:5)
    at nodeHandler (/Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3335:30)
    at /Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3341:17
No routes matched location "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/4" 
ErrorResponseImpl {
  status: 404,
  statusText: 'Not Found',
  internal: true,
  data: 'Error: No route matches URL "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/4"',
  error: Error: No route matches URL "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/4"
      at getInternalRouterError (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:4514:5)
      at Object.query (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:2728:19)
      at handleDocumentRequest (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:11037:40)
      at requestHandler (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:10952:24)
      at processTicksAndRejections (node:internal/process/task_queues:105:5)
      at nodeHandler (/Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3335:30)
      at /Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3341:17
}
Error: No route matches URL "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/7"
    at getInternalRouterError (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:4514:5)
    at Object.query (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:2728:19)
    at handleDocumentRequest (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:11037:40)
    at requestHandler (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:10952:24)
    at processTicksAndRejections (node:internal/process/task_queues:105:5)
    at nodeHandler (/Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3335:30)
    at /Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3341:17
No routes matched location "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/7" 
ErrorResponseImpl {
  status: 404,
  statusText: 'Not Found',
  internal: true,
  data: 'Error: No route matches URL "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/7"',
  error: Error: No route matches URL "/feedback/conversation/21bac69c88dc47aebabdad33c6749519/7"
      at getInternalRouterError (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:4514:5)
      at Object.query (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:2728:19)
      at handleDocumentRequest (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:11037:40)
      at requestHandler (file:///Users/gneubig/work/OpenHands/frontend/node_modules/react-router/dist/development/chunk-QMGIS6GS.mjs:10952:24)
      at processTicksAndRejections (node:internal/process/task_queues:105:5)
      at nodeHandler (/Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3335:30)
      at /Users/gneubig/work/OpenHands/frontend/node_modules/@react-router/dev/dist/vite.js:3341:17
}
```

### OpenHands Installation

Docker command in README

### OpenHands Version

main

### Model Name

gemini

### Operating System

None

### Logs, Errors, Screenshots, and Additional Context

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
