#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/uv/src/commands/project/init.rs`:

This pull request introduces the defect later reported as "`uv init` creates unimportable package subdirectory". The
problem a user observed, and its root cause:

Steps to reproduce:

* `mkdir a-b && cd a-b`
* `uv init`

This creates a package subdirectory with the same name as the project, but the project name is itself not a valid package name:

```shell
$ tree
.
├── README.md
├── pyproject.toml
└── src
    └── a-b
        └── __init__.py
```

Instead, the subdirectory should be named `a_b`, with `-` normalized.

This same root cause must be fixed before merging.
REVIEW_EOF
