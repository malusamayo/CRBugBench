# Code Review Task

You are a maintainer reviewing a pull request to the `astral-sh/uv` repository.

**PR title:** Preserve directory-level standalone build symlinks (#9723)

**PR description / commit message:**

Preserve directory-level standalone build symlinks (#9723)

## Summary

This PR improves our "don't fully resolve symlinks" behavior for
`python-build-standalone` builds based on learnings from
https://github.com/indygreg/python-build-standalone/issues/380#issuecomment-2526575235.

Specifically, we can now robustly detect whether a target executable
will lead to a valid `prefix` or not, and iteratively resolve symlinks
until we find a valid target executable.

## Test Plan

### Direct symlink to `python`

Correctly resolves to the symlink target, rather than the symlink
itself.

```
❯ ln -s /Users/crmarsh/.local/share/uv/python/cpython-3.12.6-macos-aarch64-none/bin/python foo
❯ cargo run venv --python ./foo
❯ cat .venv/pyvenv.cfg
home = /Users/crmarsh/.local/share/uv/python/cpython-3.12.6-macos-aarch64-none/bin
implementation = CPython
uv = 0.5.7
version_info = 3.12.6
include-system-site-packages = false
prompt = uv
❯ .venv/bin/python -c "import sys"
```

### Symlink to the Python installation

Correctly does _not_ resolve the symlink.

```
❯ ln -s /Users/crmarsh/.local/share/uv/python/cpython-3.12.6-macos-aarch64-none bar
❯ cargo run venv --python ./bar
❯ cat .venv/pyvenv.cfg
home = /Users/crmarsh/workspace/uv/bar/bin
implementation = CPython
uv = 0.5.7
version_info = 3.12.6
include-system-site-packages = false
prompt = uv
❯ .venv/bin/python -c "import sys"
```

### Direct symlink to `python` in a symlinked Python installation

Correctly resolves the direct symlink, but not the symlink of the Python
installation.

```
❯ ln -s bar/bin/python baz
❯ cargo run venv --python ./baz
❯ cat .venv/pyvenv.cfg
home = /Users/crmarsh/workspace/uv/bar/bin
implementation = CPython
uv = 0.5.7
version_info = 3.12.6
include-system-site-packages = false
prompt = uv
❯ .venv/bin/python -c "import sys"
```

## Working environment

The repository is checked out at `/app/uv` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
