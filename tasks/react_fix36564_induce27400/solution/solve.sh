#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react-dom-bindings/src/server/ReactFizzConfigDOM.js`:

This pull request introduces the defect later reported as "Bug: ReactDOM.preloadModule crashes with repeated custom as value". The
problem a user observed, and its root cause:

React version: current `main` (`d5736f098edee62c44f27b053e6e48f5fa443803` locally)

## Steps To Reproduce

1. Render a component on the server with two `ReactDOM.preloadModule()` calls that use the same non-default `as` value:

```js
function App() {
  ReactDOM.preloadModule('worker-a', {as: 'serviceworker'});
  ReactDOM.preloadModule('worker-b', {as: 'serviceworker'});
  return <div>hello</div>;
}

renderToPipeableStream(<App />).pipe(writable);
```

2. Let the Fizz render run.

Link to code example: minimal reproduction above; this is also covered by the added regression test in `packages/react-dom/src/__tests__/ReactDOMFloat-test.js`.

## The current behavior

The second call crashes during server rendering:

```text
TypeError: Cannot read properties of undefined (reading 'hasOwnProperty')
```

The repeated custom-`as` path checks `moduleUnknownResources` but then reads the bucket from `unknownResources`, so the bucket can be undefined.

## The expected behavior

Fizz should track repeated custom module preload `as` values in `moduleUnknownResources` and emit both module preload links without crashing.

This same root cause must be fixed before merging.
REVIEW_EOF
