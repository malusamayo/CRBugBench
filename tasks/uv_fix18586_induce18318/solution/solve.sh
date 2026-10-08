#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/uv/src/commands/tool/list.rs`:

This pull request introduces the defect later reported as "`uv tool upgrade --all` does not update anything". The
problem a user observed, and its root cause:

### Summary

Since the flag `uv tool list --outdated` was released (thank you for that!) I list the outdated packages, then run `uv tool upgrade --all` and it states that nothing to update:

```fish
 uv tool list --color never --outdated
bandit v1.9.3 [latest: 1.9.4]
- bandit
- bandit-baseline
- bandit-config-generator
basedpyright v1.38.1 [latest: 1.38.2]
- basedpyright
- basedpyright-langserver
meson v1.10.1 [latest: 1.10.2]
- meson
pyinfra v3.6.1 [latest: 3.7]
- pyinfra
ruff v0.15.2 [latest: 0.15.6]
- ruff
semgrep v1.152.0 [latest: 1.155.0]
- pysemgrep
- semgrep
tombi v0.7.32 [latest: 0.9.6]
- tombi
```
```fish
 uv tool upgrade --all
Nothing to upgrade
```
Bandit was in the list of outdated packages:
```fish
 bandit --version
bandit 1.9.3
  python version = 3.13.2 (main, Feb  5 2025, 19:11:32) [Clang 19.1.6 ]
```

Even upgrading one package doesn't work:
```fish
 uv tool upgrade bandit
Nothing to upgrade
```

I have to install `@latest` to upgrade the package:
```fish
 uv tool install bandit@latest
Resolved 7 packages in 149ms
Prepared 1 package in 33ms
Uninstalled 1 package in 1ms
Installed 1 package in 3ms
 - bandit==1.9.3
 + bandit==1.9.4
Installed 3 executables: bandit, bandit-baseline, bandit-config-generator
```

I would expect that running `uv tool upgrade --all` or `uv tool upgrade <package>` would upgrade the package without issues.

### Platform

Pop!_OS 24.04 LTS Linux 6.18.7-76061807-generic x86_64 GNU/Linux

### Version

uv 0.10.10

### Python version

Python 3.13.2

This same root cause must be fixed before merging.
REVIEW_EOF
