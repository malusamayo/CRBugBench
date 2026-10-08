#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/internal/blob.js`:

This pull request introduces the defect later reported as "new Blob([new Uint16Array([1])]) has size 1 instead of 2". The
problem a user observed, and its root cause:

### Version

v16.13.0

### Platform

Darwin vashli.local 20.6.0 Darwin Kernel Version 20.6.0: Wed Jun 23 00:26:31 PDT 2021; root:xnu-7195.141.2~5/RELEASE_X86_64 x86_64

### Subsystem

_No response_

### What steps will reproduce the bug?

If you run following with node 16.3

```sh
node -e 'assert.equal(new (require("buffer").Blob)([new Uint16Array([1])]).size, 2)'
```

Produces output

```
node:assert:123
  throw new AssertionError(obj);

AssertionError [ERR_ASSERTION]: 1 == 2
    at [eval]:1:8
    at Script.runInThisContext (node:vm:129:12)
    at Object.runInThisContext (node:vm:305:38)
    at node:internal/process/execution:81:19
    at [eval]-wrapper:6:22
    at evalScript (node:internal/process/execution:80:60)
    at node:internal/main/eval_string:27:3 {
  generatedMessage: true,
  code: 'ERR_ASSERTION',
  actual: 1,
  expected: 2,
  operator: '=='
}
```

Which mismatches expected `Blob` behavior



### How often does it reproduce? Is there a required condition?

Always

### What is the expected behavior?

assert should pass and generally blob behavior should match one from web

### What do you see instead?

_No response_

### Additional information

Issue with the following line

https://github.com/nodejs/node/blob/dd52c05046bcc65746e26e2de65699dffcd454ee/lib/internal/blob.js#L109-L128

Which should return following instead

```js
  source = new Uint8Array(source.buffer.slice(source.byteOffset, source.byteOffset + source.byteLength));
  return [source.byteLength, source];
```

This same root cause must be fixed before merging.
REVIEW_EOF
