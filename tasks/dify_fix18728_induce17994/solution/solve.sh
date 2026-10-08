#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `web/app/components/base/prompt-editor/plugins/workflow-variable-block/component.tsx`:

This pull request introduces the defect later reported as "env variables dont display on http node". The
problem a user observed, and its root cause:

### Self Checks

- [x] This is only for bug report, if you would like to ask a question, please head to [Discussions](https://github.com/langgenius/dify/discussions/categories/general).
- [x] I have searched for existing issues [search for existing issues](https://github.com/langgenius/dify/issues), including closed ones.
- [x] I confirm that I am using English to submit this report (我已阅读并同意 [Language Policy](https://github.com/langgenius/dify/issues/1542)).
- [x] [FOR CHINESE USERS] 请务必使用英文提交 Issue，否则会被关闭。谢谢！:)
- [x] Please do not modify this template :) and fill in all the required fields.

### Dify version

1.3.0

### Cloud or Self Hosted

Self Hosted (Docker)

### Steps to reproduce

1. create an env variable
2. add a http request node
3. add the variable to the http node


### ✔️ Expected Behavior

1. the env variable will show on the page

### ❌ Actual Behavior

1. the env variable not show while other variables are all right. some variable will repeat several times like env.APPID in my image.

![Image](https://github.com/user-attachments/assets/c471a623-08b8-4d57-9a8f-7ece735b0333)

2. same env variables can show on code node.

![Image](https://github.com/user-attachments/assets/f35f96e6-b5a7-482d-9e02-25963ed9c122)

This same root cause must be fixed before merging.
REVIEW_EOF
