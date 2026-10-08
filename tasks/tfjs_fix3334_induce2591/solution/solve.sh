#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tfjs-backend-wasm/src/backend_wasm.ts`:

This pull request introduces the defect later reported as "[WASM] The value of tensor created from TypedArray is incorrect". The
problem a user observed, and its root cause:

#### TensorFlow.js version
- @tensorflow/tfjs-core@"1.5.2"

- @tensorflow/tfjs-backend-wasm@1.5.1-alpha5

#### Browser version
- 80.0.3987.132 (Official Build) (64-bit)

#### Describe the problem or feature request
The issue is shown as the following picture. The data of bias is from a [squeezeNet](https://storage.googleapis.com/download.tensorflow.org/models/tflite/model_zoo/upload_20180427/squeezenet_2018_04_27.tgz) tflite model and its value has changed after an add operation. I'm still trying to find a more simple way to reproduce this issue. 

![issue](https://user-images.githubusercontent.com/44738552/77986731-6fe0d080-734a-11ea-8ee8-10d2871eedb7.png)

Do you have any idea of the potential cause, may it cause by the type or the precision of the variable?

Looking forward to you reply.

This same root cause must be fixed before merging.
REVIEW_EOF
