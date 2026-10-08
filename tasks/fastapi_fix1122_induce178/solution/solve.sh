#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `fastapi/routing.py`:

This pull request introduces the defect later reported as "Dependency override websocket broken". The
problem a user observed, and its root cause:

### Describe the bug

Dependency override does not work for websockets. 

The function `add_api_websocket_route` does not add `dependency_overrides_provider` to `APIWebSocketRoute`.

### To Reproduce

Create a simple app with websockets and test it with override.

### Expected behavior

The overrides should be taken into account, but the test uses the original dependency. 

### Environment

- OS: Windows
- FastAPI version: 0.49.0
- Python version: 3.6.8

This same root cause must be fixed before merging.
REVIEW_EOF
