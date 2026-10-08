#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `test/e2e/check-coverage.js`:

This pull request introduces the defect later reported as "test/e2e/check-coverage.js in CI test fails". The
problem a user observed, and its root cause:

**Describe the bug**

`test/e2e/check-coverage.js` fails in CI test.

```
> three@0.121.1 test-e2e-cov /home/runner/work/three.js/three.js
> node test/e2e/check-coverage.js

/home/runner/work/three.js/three.js/test/e2e/check-coverage.js:17
for ( var key in files ) {
                 ^

ReferenceError: files is not defined
    at Object.<anonymous> (/home/runner/work/three.js/three.js/test/e2e/check-coverage.js:17:18)
    at Module._compile (internal/modules/cjs/loader.js:1015:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:1035:10)
    at Module.load (internal/modules/cjs/loader.js:879:32)
    at Function.Module._load (internal/modules/cjs/loader.js:724:14)
    at Function.executeUserEntryPoint [as runMain] (internal/modules/run_main.js:60:12)
    at internal/main/run_main_module.js:17:47
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! three@0.121.1 test-e2e-cov: `node test/e2e/check-coverage.js`
npm ERR! Exit status 1
npm ERR! 
npm ERR! Failed at the three@0.121.1 test-e2e-cov script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.
```

If I'm right, this error has happened since #20512 was merged?

**To Reproduce**

1. See any PR which is open
2. Check CI test results

***Code***

`files` is defined by reading `examples/files.js` and  using eval.

https://github.com/mrdoob/three.js/blob/r121/test/e2e/check-coverage.js#L16

```js
eval( fs.readFileSync( './examples/files.js' ).toString() );
```

#20512 changed the statement for `files` in `examples/files.js` from `var` to `const`. `let/const` variable doesn't seem to be exposed to out of eval scope.

So an easy solution may be

```js
eval( fs.readFileSync( './examples/files.js' )
    .toString().replace( 'const files', 'var files' ) );
```

But not sure if this is a robust approach.

**Expected behavior**

`test/e2e/check-coverage.js` should run without error.

**Platform:**

 - Device: Desktop
 - OS: Windows
 - Browser: 
 - Three.js version: dev

This same root cause must be fixed before merging.
REVIEW_EOF
