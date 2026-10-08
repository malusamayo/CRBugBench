#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docs/manual/en/introduction/WebGL-compatibility-check.html`:

This pull request introduces the defect later reported as "Wrong import in Doc: The requested module 'three/addons/capabilities/WebGL.js' does not provide an export named 'WebGL'". The
problem a user observed, and its root cause:

### Description

In the doc: https://threejs.org/docs/#manual/en/introduction/WebGL-compatibility-check

We find this import `import { WebGL } from 'three/addons/capabilities/WebGL.js';`

It seems to be a default export in the file, so, it should be `import WebGL from 'three/addons/capabilities/WebGL.js';`

### Reproduction steps

1. Import WebGL the way the docs described it
2. Call isWebGLAvailable()
3. Get the error in the console


### Code

```js
import {WebGL} from 'three/addons/capabilities/WebGL.js';

if (WebGL.isWebGLAvailable()) {
//...
  } else {
//...
  }
```


### Live example

https://codesandbox.io/s/webglcapabilitiesimport-ptln5o

### Screenshots

![image](https://user-images.githubusercontent.com/18304870/229493198-a0975e3f-426e-4609-8d3a-63027f6a734d.png)


### Version

r150

### Device

Desktop

### Browser

Chrome

### OS

Windows

This same root cause must be fixed before merging.
REVIEW_EOF
