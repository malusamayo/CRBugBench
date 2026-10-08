#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/uv-dispatch/src/lib.rs`:

This pull request introduces the defect later reported as "`uv` behaves differently than `pip` when using `--only-binary=:all:` for editable installs". The
problem a user observed, and its root cause:

`uv` version:
```
uv --version
uv 0.1.16 (9f1452cb7 2024-03-07)
```

I have the following package:
- pkg/
  - src/pkg/__init__.py
  - tests
  - pyproject.toml

The `pyproject.toml` contains the following:
```
[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

[project]
name = "pkg"
version = "1.0.0"
dependencies = []
```

I create a virtual environment with the following:
```
uv venv --python python3.11 --seed env
```

Then, if I try to install my package as an editable install, while specifying the `--only-binary=:all:` flag, it fails:
```
VIRTUAL_ENV=env uv pip install --only-binary=:all: -e ./
error: Failed to build editables
  Caused by: Failed to build editable: file:///Users/ryan/pkg
  Caused by: Building source distributions is disabled
```

Running the same command directly with `pip` succeeds:
```
./env/bin/pip install --only-binary=:all: -e ./
Obtaining file:///Users/ryan/pkg
  Installing build dependencies ... done
  Checking if build backend supports build_editable ... done
  Getting requirements to build editable ... done
  Installing backend dependencies ... done
  Preparing editable metadata (pyproject.toml) ... done
Building wheels for collected packages: pkg
  Building editable for pkg (pyproject.toml) ... done
  Created wheel for pkg: filename=pkg-1.0.0-0.editable-py3-none-any.whl size=1120 sha256=9b3f829a419131d6ec58795d1d4d5fad5c58c50ef24f64fad219d5f01e426fb1
  Stored in directory: /private/var/folders/qx/q6hdl8rn3x57stn_m6sy3_tm0000gn/T/pip-ephem-wheel-cache-igev1641/wheels/b0/9a/a6/2db658aee67947ede4e7a4e42146f43316514a2f3ec0e5ac7d
Successfully built pkg
Installing collected packages: pkg
Successfully installed pkg-1.0.0
```

The `pip` version is:
```
./env/bin/pip --version
pip 24.0 from /Users/ryan/pkg/env/lib/python3.11/site-packages/pip (python 3.11)
```

Our use case is that we would like to use wheels to install all of our third-party packages, but we would like to install all of our local packages as editable installs for easier development. With `pip` the `--only-binary=:all:` worked well for this case since editable packages seemed to be ignored when considering the only-binary requirement. `pip` behaves the same when editable installs are discovered in `requirements.txt` files. `uv` fails the install in the same way when detecting editable installs in the `requirements.txt` files.

This same root cause must be fixed before merging.
REVIEW_EOF
