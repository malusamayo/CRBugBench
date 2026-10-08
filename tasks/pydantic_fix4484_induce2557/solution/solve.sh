#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `pydantic/dataclasses.py`:

This pull request introduces the defect later reported as "__post_init__ and validators are not triggered in class inherited from stdlib dataclass in 1.10.1". The
problem a user observed, and its root cause:

### Initial Checks

- [X] I have searched GitHub for a duplicate issue and I'm sure this is something new
- [X] I have searched Google & StackOverflow for a solution and couldn't find anything
- [X] I have read and followed [the docs](https://pydantic-docs.helpmanual.io) and still think this is a bug
- [X] I am confident that the issue is with pydantic  (not my code, or another library in the ecosystem like [FastAPI](https://fastapi.tiangolo.com) or [mypy](https://mypy.readthedocs.io/en/stable))


### Description

__post_init__ and validator are not triggered in the following code. However, uncommenting any of the lines: `py_dataclass(D_C_Base)` or `b: str = "string"` solves the issue.
Versions 1.9.x could trigger both __post_init__ and validators without these lines.



### Example Code

```Python
from dataclasses import dataclass
from pydantic.dataclasses import dataclass as py_dataclass
from pydantic import validator


@dataclass
class D_C_Base:
    a: float = 1.0

# py_dataclass(D_C_Base)

@py_dataclass
class D_C_Child(D_C_Base):
    # b: str = "string"
    
    def __post_init__(self):
        print('POST_INIT')
        
    @validator('a')
    def validate_a(cls, value):
        print(f'Validating "a" is {value}')

d_c_class = D_C_Child()
```


### Python, Pydantic & OS Version

```Text
pydantic version: 1.10.1
pydantic compiled: True
install path: C:\Users\TestUser\.conda\envs\py38\Lib\site-packages\pydantic
               python version: 3.8.13 (default, Mar 28 2022, 06:59:08) [MSC v.1916 64 bit (AMD64)]
platform: Windows-10-10.0.22000-SP0
optional deps. installed: ['typing-extensions']

Also,

pydantic version: 1.10.1
pydantic compiled: True
install path: /local/envs/py39_test/lib/python3.9/site-packages/pydantic
               python version: 3.9.1 (default, Dec 11 2020, 14:32:07)  [GCC 7.3.0]
platform: Linux-3.10.0-1160.66.1.el7.x86_64-x86_64-with-glibc2.17
optional deps. installed: ['typing-extensions']
```


### Affected Components

- [X] [Compatibility between releases](https://pydantic-docs.helpmanual.io/changelog/)
- [X] [Data validation/parsing](https://pydantic-docs.helpmanual.io/usage/models/#basic-model-usage)
- [ ] [Data serialization](https://pydantic-docs.helpmanual.io/usage/exporting_models/) - `.dict()` and `.json()`
- [ ] [JSON Schema](https://pydantic-docs.helpmanual.io/usage/schema/)
- [x] [Dataclasses](https://pydantic-docs.helpmanual.io/usage/dataclasses/)
- [ ] [Model Config](https://pydantic-docs.helpmanual.io/usage/model_config/)
- [ ] [Field Types](https://pydantic-docs.helpmanual.io/usage/types/) - adding or changing a particular data type
- [ ] [Function validation decorator](https://pydantic-docs.helpmanual.io/usage/validation_decorator/)
- [ ] [Generic Models](https://pydantic-docs.helpmanual.io/usage/models/#generic-models)
- [ ] [Other Model behaviour](https://pydantic-docs.helpmanual.io/usage/models/) - `construct()`, pickling, private attributes, ORM mode
- [ ] [Settings Management](https://pydantic-docs.helpmanual.io/usage/settings/)
- [ ] [Plugins](https://pydantic-docs.helpmanual.io/) and integration with other tools - mypy, FastAPI, python-devtools, Hypothesis, VS Code, PyCharm, etc.

This same root cause must be fixed before merging.
REVIEW_EOF
