#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `web/i18n/language.ts`:

This pull request introduces the defect later reported as "[BUG] - V0.9.1 - Tools section with empty informations & Tools in workflow issue". The
problem a user observed, and its root cause:

### Self Checks

- [X] This is only for bug report, if you would like to ask a question, please head to [Discussions](https://github.com/langgenius/dify/discussions/categories/general).
- [X] I have searched for existing issues [search for existing issues](https://github.com/langgenius/dify/issues), including closed ones.
- [X] I confirm that I am using English to submit this report (我已阅读并同意 [Language Policy](https://github.com/langgenius/dify/issues/1542)).
- [X] [FOR CHINESE USERS] 请务必使用英文提交 Issue，否则会被关闭。谢谢！:）
- [X] Please do not modify this template :) and fill in all the required fields.

### Dify version

0.9.1

### Cloud or Self Hosted

Self Hosted (Docker)

### Steps to reproduce

Starting with `0.8.2` (where everything works fine, even the tools), I migrated to `0.9.1`. And since then, everything has worked except the tool sections and tools in the workflows:

![image](https://github.com/user-attachments/assets/d9763004-c52a-4e84-a7b6-cdb90dce67b0)

- In workflow when i try to get "tools"
![image](https://github.com/user-attachments/assets/85302b6c-8064-493b-86d9-ba6ac18ed8a4)

It's annoying because I can't migrate back to 0.8.2.

*NB: I've also tried it locally and I'm having the same problem.*

### ✔️ Expected Behavior

Allow me to have the tools and display them

### ❌ Actual Behavior

I don't have the possibility to have the tools in the workflow and in the tools section.

This same root cause must be fixed before merging.
REVIEW_EOF
