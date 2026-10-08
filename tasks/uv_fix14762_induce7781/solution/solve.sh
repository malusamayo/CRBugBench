#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/uv-build-backend/src/metadata.rs`:

This pull request introduces the defect later reported as "build backend toml parse failure on pyproject readme". The
problem a user observed, and its root cause:

### Summary

When upgrading one of my packages to use the new build backend, I got the following error:

```sh
Resolved 20 packages in 1ms
  × Failed to build `wiopy @ file:///Users/joshie/Dev/projects/github/Walmart%20Wrapper`
  ├─▶ The build backend returned an error
  ╰─▶ Call to `uv_build.build_editable` failed (exit status: 1)

      [stderr]
      Error: Invalid pyproject.toml

      Caused by:
          TOML parse error at line 6, column 10
            |
          6 | readme = {file = "README.md", content-type = "text/markdown"}
            |          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          data did not match any variant of untagged enum Readme


      Stack backtrace:
         0: __mh_execute_header
         1: __mh_execute_header
         2: __mh_execute_header
         3: __mh_execute_header
         4: __mh_execute_header

      hint: This usually indicates a problem with the package or the build environment.
```

This parsing error should likely not happen. [Looking at the packaging docs](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#readme), this pattern seems possible. Because the file ends in `md`, I will modify my pyproject to be just `readme = "README.md`; but I figured this was still work raising. 

To reproduce:

```sh
uv init --package test
cd test
vim pyproject.toml  # modify readme setting to match `readme = {file = "README.md", content-type = "text/markdown"}`
```

### Platform

Darwin 24.5.0 arm64

### Version

uv 0.8.0 (Homebrew 2025-07-17)

### Python version

Python 3.13.5

This same root cause must be fixed before merging.
REVIEW_EOF
