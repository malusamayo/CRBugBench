#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `api/services/app_generate_service.py`:

This pull request introduces the defect later reported as "Duplicate InvokeRateLimitError definitions cause exception type mismatch". The
problem a user observed, and its root cause:

### Self Checks

- [x] I have searched for existing issues and this is not a duplicate

### Describe the bug

The codebase contains 6 different `InvokeRateLimitError` class definitions across multiple locations:

| Location | Base Class |
|----------|------------|
| `services/errors/app.py` | `Exception` |
| `services/errors/llm.py` | `InvokeError` |
| `controllers/console/app/error.py` | `BaseHTTPException` |
| `controllers/web/error.py` | `BaseHTTPException` |
| `core/model_runtime/errors/invoke.py` | `InvokeError` |
| `core/errors/error.py` | `ValueError` |

This causes an exception type mismatch:
- `AppGenerateService` throws `services.errors.app.InvokeRateLimitError`
- Controllers (e.g., `workflow.py`) catch `services.errors.llm.InvokeRateLimitError`

Since these are different classes, the exception is not caught, resulting in incorrect error responses to clients (e.g., 500 Internal Server Error instead of 429 Rate Limit Error).

### Steps to reproduce

1. Trigger a rate limit condition via `AppGenerateService.generate()`
2. The `InvokeRateLimitError` from `services.errors.app` is raised
3. Controller's `except InvokeRateLimitError` (from `services.errors.llm`) fails to catch it
4. Client receives incorrect error response

### Expected behavior

Rate limit exceptions should be properly caught and return HTTP 429 with appropriate error message.

### Relevant context

Related files:
- `api/services/app_generate_service.py:17` - imports from `services.errors.app`
- `api/controllers/console/app/workflow.py:48` - imports from `services.errors.llm`

This same root cause must be fixed before merging.
REVIEW_EOF
