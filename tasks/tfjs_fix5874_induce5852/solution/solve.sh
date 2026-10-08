#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tfjs-backend-wasm/src/cc/post.js`:

This pull request introduces the defect later reported as "[wasm] Incorrect check for 'process' in pre.js". The
problem a user observed, and its root cause:

<em>Please make sure that this is a bug. As per our
[GitHub Policy](https://github.com/tensorflow/tensorflow/blob/master/ISSUES.md),
we only address code/doc bugs, performance issues, feature requests and
build/installation issues on GitHub. tag:bug_template</em>

**System information**
- Have I written custom code (as opposed to using a stock example script provided in TensorFlow.js):
- OS Platform and Distribution (e.g., Linux Ubuntu 16.04):
- Mobile device (e.g. iPhone 8, Pixel 2, Samsung Galaxy) if the issue happens on mobile device:
- TensorFlow.js installed from (npm or script link):
- TensorFlow.js version (use command below): b2f3664a32a0119a1acf93756cc8b930b8de860f
- Browser version:
- Tensorflow.js Converter Version:


**Describe the current behavior**
#5852 made it impossible to load tfjs-backend-wasm on the web. It checks for the existence of the global `process` variable incorrectly in `pre.js`:
```javascript
if (process && process.listeners) {
...
}
```
This was not caught by unit tests because Karma adds a global `process` variable to the browser.

**Describe the expected behavior**
`pre.js` correctly checks for the existence of a `process` variable.

**Standalone code to reproduce the issue**
Provide a reproducible test case that is the bare minimum necessary to generate
the problem. If possible, please share a link to Colab/CodePen/any notebook.

**Other info / logs** Include any logs or source code that would be helpful to
diagnose the problem. If including tracebacks, please include the full
traceback. Large logs and files should be attached.

This same root cause must be fixed before merging.
REVIEW_EOF
