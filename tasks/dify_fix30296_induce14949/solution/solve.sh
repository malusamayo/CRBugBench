#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `web/app/components/workflow/panel/version-history-panel/index.tsx`:

This pull request introduces the defect later reported as "Draft version uses wrong DSL". The
problem a user observed, and its root cause:

### Self Checks

- [x] I have read the [Contributing Guide](https://github.com/langgenius/dify/blob/main/CONTRIBUTING.md) and [Language Policy](https://github.com/langgenius/dify/issues/1542).
- [x] This is only for bug report, if you would like to ask a question, please head to [Discussions](https://github.com/langgenius/dify/discussions/categories/general).
- [x] I have searched for existing issues [search for existing issues](https://github.com/langgenius/dify/issues), including closed ones.
- [x] I confirm that I am using English to submit this report, otherwise it will be closed.
- [x] 【中文用户 & Non English User】请使用英语提交，否则会被关闭 ：）
- [x] Please do not modify this template :) and fill in all the required fields.

### Dify version

1.9.0

### Cloud or Self Hosted

Cloud

### Steps to reproduce

Create a workflow
publish it
Alter workflow
do not publish it, leave it as draft

open historic versions
select a past version
now select the current draft version

### ✔️ Expected Behavior

Should show current drag DSL

### ❌ Actual Behavior

Shows DSL of the published flow

This same root cause must be fixed before merging.
REVIEW_EOF
