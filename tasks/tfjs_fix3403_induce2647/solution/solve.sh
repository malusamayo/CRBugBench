#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tfjs-core/src/io/indexed_db.ts`:

This pull request introduces the defect later reported as "`tf.LayersModel.save` not working inside web worker". The
problem a user observed, and its root cause:

#### TensorFlow.js version

2.0.0

#### Browser version

Chrome 83.0.4103.61

#### Description

```
model.worker.ts:4 Uncaught ReferenceError: window is not defined
    at Module../node_modules/workerize-loader/dist/rpc-worker-loader.js!./node_modules/babel-loader/lib/index.js?!./node_modules/eslint-loader/dist/cjs.js?!./src/game/ml/model.worker.ts (model.worker.ts:4)
    at __webpack_require__ (bootstrap:19)
    at bootstrap:83
    at bootstrap:83
```

Saving a `LayersModel` to the IndexedDB inside a web worker does not work because the `window` object is not defined. This is because inside a web worker the global scope is saved in a variable named `self` or `globalThis`.

The problem was identified in #2643 and it was attempted to be fixed in PR #2647. Unfortunately, the merged solution did not fix the problem (I am not sure how it passed the review).

[The following line](https://github.com/tensorflow/tfjs/blob/81b390dbc5be3109db049f098117eae0e08721da/tfjs-core/src/io/indexed_db.ts#L60) will throw a `ReferenceError` because `window` is not defined. 

```typescript
const theWindow: any = window || self;
```

A better implementation would be:

```typescript
const theWindow: any = typeof window === 'undefined' ? self : window;
```

This same root cause must be fixed before merging.
REVIEW_EOF
