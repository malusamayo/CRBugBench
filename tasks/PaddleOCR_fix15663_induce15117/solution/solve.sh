#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `paddleocr/_common_args.py`:

This pull request introduces the defect later reported as "[Regression] Output cannot be disabled". The
problem a user observed, and its root cause:

### 🔎 Search before asking

- [x] I have searched the PaddleOCR [Docs](https://paddlepaddle.github.io/PaddleOCR/) and found no similar bug report.
- [x] I have searched the PaddleOCR [Issues](https://github.com/PaddlePaddle/PaddleOCR/issues) and found no similar bug report.
- [x] I have searched the PaddleOCR [Discussions](https://github.com/PaddlePaddle/PaddleOCR/discussions) and found no similar bug report.

### 🐛 Bug (问题描述)

The output is always set to a default value:

https://github.com/PaddlePaddle/PaddleOCR/blob/966c11e20b2da0a776215603d8ac9b96576b8e8d/paddleocr/_utils/cli.py#L41-L46

So it cannot be disabled, even though this  part:

https://github.com/PaddlePaddle/PaddleOCR/blob/966c11e20b2da0a776215603d8ac9b96576b8e8d/paddleocr/_utils/cli.py#L72-L73

theoretically checks if it is "None" for example.

In PaddleOCR 2.10 the were two arguments, one to enable/disable the output and one to set the path - that could also be done here. Or the default str could be set to "None", but that would change the default behaviour that is currently set in version 3.0.1

### 🏃‍♂️ Environment (运行环境)

OS: Windows 11
PaddleOCR 3.0.1
PaddlePaddle 3.0.0 (CPU version)
16GB RAM
GPU: Nvidia GTX 1660 TI
Installed via pip in a venv with Python 3.11

### 🌰 Minimal Reproducible Example (最小可复现问题的Demo)

Explained above

This same root cause must be fixed before merging.
REVIEW_EOF
