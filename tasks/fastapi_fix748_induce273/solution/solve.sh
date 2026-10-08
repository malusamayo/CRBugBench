#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `fastapi/exception_handlers.py`:

This pull request introduces the defect later reported as "Invalid Constrained Decimals (condecimal) cause 500 response code, rather than a 422 with explanation of what was invalid.". The
problem a user observed, and its root cause:

**Describe the bug**
If an invalid `condecimal` is sent to a FastAPI service the service will return a 500 internal server error, instead of a 422 validation error. I can't reproduce this using Pydantic alone.

**To Reproduce**
Steps to reproduce the behavior:
1. Run the attached [`condecimal-500-server.py`](https://github.com/tiangolo/fastapi/files/3900830/condecimal-500-server.py.txt) file.
2. In a separate terminal run the attached [`condecimal-500-client.py`](https://github.com/tiangolo/fastapi/files/3900829/condecimal-500-client.py.txt) file.
3. [`condecimal-500-server.log`](https://github.com/tiangolo/fastapi/files/3900824/condecimal-500-server.log) shows what you will see in the terminal that is running the server, most of the invalid requests will return a 422 but the one that violates the decimal constraint raises a `TypeError`.
4. [`condecimal-500-client.log`](https://github.com/tiangolo/fastapi/files/3900823/condecimal-500-client.log) shows what you will see in the terminal running the client, basically the same info that you see in the server's logs.
5. Run the attached [`condecimal-500-pydantic.py`](https://github.com/tiangolo/fastapi/files/3900870/condecimal-500-pydantic.py.txt) file.
6. [`condecimal-500-pydantic.log`](https://github.com/tiangolo/fastapi/files/3900869/condecimal-500-pydantic.log) shows what you will see when running that file, Pydantic correctly raises a `ValidationError` when the constraint is violated indicating that this is not an bug in Pydantic.

**Expected behavior**
I expect a 422 response along with an explanation of what is invalid about the number to be returned, as happens when other invalid payloads are sent.

**Environment:**
 - OS: Linux
 - FastAPI Version: 0.44.0
 - Pydantic Version: 1.1.1
 - Python Version: 3.7.2

This same root cause must be fixed before merging.
REVIEW_EOF
