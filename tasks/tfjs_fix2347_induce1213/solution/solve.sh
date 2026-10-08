#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tfjs-core/src/tensor_format.ts`:

This pull request introduces the defect later reported as "tensor.print() shows incorrect ending values for long 'complex64' tensors". The
problem a user observed, and its root cause:

#### TensorFlow.js version
1.3.1

#### Browser version
Safari, Version 13.0.3 (15608.3.10.1.4)

#### Describe the problem or feature request
.print() on a large complex64 tensor returns incorrect results for tail values. In particular, for 1D tensors if the length is N and even, the printed tail values show the values leading up to N/2. If N is odd, the real and imaginary parts also get swapped.

For example:
a.print() -> `[1, 2, 3, ..., 28, 29, 30]`
b.print() -> `[0, 0, 0, ..., 0, 0, 0]`
tf.complex(a,b).print() -> `[1 + 0j, 2 + 0j, 3 + 0j, ..., 13 + 0j, 14 + 0j, 15 + 0j]`

a.print() -> `[1, 2, 3, ..., 27, 28, 29]`
b.print() -> `[0, 0, 0, ..., 0, 0, 0]`
tf.complex(a,b).print() -> `[1 + 0j, 2 + 0j, 3 + 0j, ..., 0 + 13j, 0 + 14j, 0 + 15j]`

#### Code to reproduce the bug / link to feature request
https://codepen.io/toadman667/pen/eYYVGZj

This same root cause must be fixed before merging.
REVIEW_EOF
