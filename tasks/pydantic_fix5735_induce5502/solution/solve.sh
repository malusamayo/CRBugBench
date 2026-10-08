#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `pydantic/_internal/_model_construction.py`:

This pull request introduces the defect later reported as "AttributeError when using None as type". The
problem a user observed, and its root cause:

### Initial Checks

- [X] I confirm that I'm using Pydantic V2 installed directly from the `main` branch, or equivalent

### Description

While I won't claim this is useful, it was working fine even with early versions of v2 and the error messages does not really help:

```
  File "~/venv/openapi3/lib/python3.10/site-packages/pydantic/_internal/_model_construction.py", line 135, in inspect_namespace
    and ann_type.__module__ != 'functools'
AttributeError: 'NoneType' object has no attribute '__module__'. Did you mean: '__reduce__'?
```

### Example Code

```Python
from pydantic import BaseModel

class A(BaseModel):
    _x: None
```


### Python, Pydantic & OS Version

```Text
pydantic version: 2.0a4
        pydantic-core version: 0.30.0 release build profile
                 install path: ~/venv/openapi3/lib/python3.10/site-packages/pydantic
               python version: 3.10.6 (main, Mar 10 2023, 10:55:28) [GCC 11.3.0]
                     platform: Linux-5.19.0-40-generic-x86_64-with-glibc2.35
     optional deps. installed: ['email-validator', 'typing-extensions']
```

This same root cause must be fixed before merging.
REVIEW_EOF
