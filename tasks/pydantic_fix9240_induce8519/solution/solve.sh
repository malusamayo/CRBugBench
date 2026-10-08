#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `pydantic/types.py`:

This pull request introduces the defect later reported as "JSON serialisation error with Secret types union.". The
problem a user observed, and its root cause:

### Initial Checks

- [X] I confirm that I'm using Pydantic V2

### Description

A PydanticSerializationError is raised when attempting `model_dump_json()` on a model containing a union of Secret types.

Error: `pydantic_core._pydantic_core.PydanticSerializationError: Error serializing to JSON: PydanticSerializationError: Unable to serialize unknown type: <class 'pydantic.types.Secret'>`


### Example Code

```Python
from pydantic import BaseModel, Secret


class Base(BaseModel):
    x: Secret[int] | Secret[str]


model = Base(x=1)

print(model.model_dump())  # No error
print(model.model_dump_json())  # pydantic_core._pydantic_core.PydanticSerializationError: Error serializing to JSON: PydanticSerializationError: Unable to serialize unknown type: <class 'pydantic.types.Secret'>
```


### Python, Pydantic & OS Version

```Text
pydantic version: 2.7.0
        pydantic-core version: 2.18.1
          pydantic-core build: profile=release pgo=true
                 install path: /Users/kasperzutterman/.pyenv/versions/3.12.1/envs/pydantic-3.12/lib/python3.12/site-packages/pydantic
               python version: 3.12.1 (main, Feb  2 2024, 09:13:09) [Clang 15.0.0 (clang-1500.1.0.2.5)]
                     platform: macOS-14.4.1-arm64-arm-64bit
             related packages: typing_extensions-4.9.0
                       commit: unknown
```

This same root cause must be fixed before merging.
REVIEW_EOF
