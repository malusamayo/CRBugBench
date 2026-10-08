#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/uv-virtualenv/src/virtualenv.rs`:

This pull request introduces the defect later reported as "`/` is mistaken for prefix of local installation". The
problem a user observed, and its root cause:

On my ubuntu 24.04, i have the system default python 3.12 installed (`sudo apt install python3.12`). This installation comes with a `/lib/python3.12/os.py`, and also the uv test pythons (`uv python install` in the project root). This can break the uv test suite: The test python 3.12 is in `/home/konsti/.local/share/uv/tests/.tmpyikuSY/python/3.12/python3`, which we mistake as a base python, because `/` fulfills `is_prefix` in `find_base_python`. Since this is not the correct home for that python, tests trying to run it fail with the wrong PYTHONHOME error (`ModuleNotFoundError: No module named 'encodings'`).

This same root cause must be fixed before merging.
REVIEW_EOF
