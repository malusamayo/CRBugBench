#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Makefile`:

This pull request introduces the defect later reported as "[Bug]:     make start-backend results in NotImplementedError: Non-relative patterns are unsupported". The
problem a user observed, and its root cause:

### Is there an existing issue for the same bug?

- [X] I have checked the existing issues.

### Describe the bug and reproduction steps

just need to run make start-backend

The error is related to the `--reload-exclude` option in the  `uvicorn` command. The issue is that the glob pattern you're passing to this option is being interpreted as an absolute path, which is not supported by Python's `pathlib.glob()` function.

Below is how I solved the issue but not sure if this is an ideal way of handling it ;
1. First, let's modify the Makefile command. Instead of using `$(shell pwd)`, we'll use a relative path:

```makefile
start-backend:
    @echo "$(YELLOW)Starting backend...$(RESET)"
    @poetry run uvicorn openhands.server.listen:app --host $(BACKEND_HOST) --port $(BACKEND_PORT) --reload --reload-exclude "./workspace"
```

This change makes the `--reload-exclude` pattern relative, which should resolve the `NotImplementedError`.



### OpenHands Installation

Docker command in README

### OpenHands Version

main

### Operating System

Linux

### Logs, Errors, Screenshots, and Additional Context

(oh) ➜  OpenHands git:(main) ✗ make start-backend
Starting backend...
Traceback (most recent call last):
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/bin/uvicorn", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/uvicorn/main.py", line 412, in main
    run(
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/uvicorn/main.py", line 516, in run
    config = Config(
             ^^^^^^^
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/uvicorn/config.py", line 292, in __init__
    self.reload_excludes, self.reload_dirs_excludes = resolve_reload_patterns(reload_excludes, [])
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/anil/.cache/pypoetry/virtualenvs/openhands-ai-CvwGNP_0-py3.12/lib/python3.12/site-packages/uvicorn/config.py", line 145, in resolve_reload_patterns
    for match in current_working_directory.glob(pattern):
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/anil/anaconda3/envs/oh/lib/python3.12/pathlib.py", line 1090, in glob
    raise NotImplementedError("Non-relative patterns are unsupported")
NotImplementedError: Non-relative patterns are unsupported
make: *** [Makefile:193: start-backend] Error 1

This same root cause must be fixed before merging.
REVIEW_EOF
