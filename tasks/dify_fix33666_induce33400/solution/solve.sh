#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `api/dify_graph/nodes/llm/llm_utils.py`:

This pull request introduces the defect later reported as "An LLM node error occurred regarding TextPromptMessageContent". The
problem a user observed, and its root cause:

### Self Checks

- [x] I have read the [Contributing Guide](https://github.com/langgenius/dify/blob/main/CONTRIBUTING.md) and [Language Policy](https://github.com/langgenius/dify/issues/1542).
- [x] This is only for bug report, if you would like to ask a question, please head to [Discussions](https://github.com/langgenius/dify/discussions/categories/general).
- [x] I have searched for existing issues [search for existing issues](https://github.com/langgenius/dify/issues), including closed ones.
- [x] I confirm that I am using English to submit this report, otherwise it will be closed.
- [x] 【中文用户 & Non English User】请使用英语提交，否则会被关闭 ：）
- [x] Please do not modify this template :) and fill in all the required fields.

### Dify version

1.13.1

### Cloud or Self Hosted

Self Hosted (Docker)

### Steps to reproduce

upgrade from 1.13.0 to 1.13.1
use llm node in workflow

### ✔️ Expected Behavior

llm node run success without any problems.

### ❌ Actual Behavior

```
api-1               | 2026-03-17 21:21:26.582 ERROR [Thread-6 (_generate_worker)] [workflow_entry.py:187] 34836eb924e8510dbf576aa3349d34db - Unknown Error when workflow entry running
api-1               | Traceback (most recent call last):
api-1               |   File "/app/api/core/workflow/workflow_entry.py", line 183, in run
api-1               |     yield from generator
api-1               |   File "/app/api/dify_graph/graph_engine/graph_engine.py", line 295, in run
api-1               |     raise self._graph_execution.error
api-1               | RuntimeError: req_id: 783a97602d PluginInvokeError: {"args":{"description":"[models] Error: 'TextPromptMessageContent' object has no attribute 'startswith'"},"error_type":"InvokeError","message":"[models] Error: 'TextPromptMessageContent' object has no attribute 'startswith'"}
```
```
api-1               | 2026-03-17 21:36:49.681 ERROR [Dummy-142] [base.py:305] 1c632614e03b5e8580fb4238b52910be - Error in stream response for plugin {'code': -500, 'message': '{"message":"{\\"args\\":{\\"description\\":\\"[models] Error: Object of type TextPromptMessageContent is not JSON serializable\\"},\\"error_type\\":\\"InvokeError\\",\\"message\\":\\"[models] Error: Object of type TextPromptMessageContent is not JSON serializable\\"}","error_type":"PluginInvokeError","args":null}', 'data': None}
```

This same root cause must be fixed before merging.
REVIEW_EOF
