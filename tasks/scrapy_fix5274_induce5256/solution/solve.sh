#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docs/intro/tutorial.rst`:

This pull request introduces the defect later reported as "Doctest failure". The
problem a user observed, and its root cause:

Merging #5256 introduced a doctest failure in `docs/intro/tutorial.rst`:

```
Expected:
    Traceback (most recent call last):
    File "<console>", line 1, in <module>
    ...
    IndexError: list index out of range
Got:
    Traceback (most recent call last):
      File "/opt/hostedtoolcache/Python/3.7.12/x64/lib/python3.7/doctest.py", line 1337, in __run
        compileflags, 1), test.globs)
      File "<doctest None[0]>", line 1, in <module>
      File "/home/runner/work/scrapy/scrapy/.tox/py/lib/python3.7/site-packages/parsel/selector.py", line 70, in __getitem__
        o = super(SelectorList, self).__getitem__(pos)
    IndexError: list index out of range
```

This same root cause must be fixed before merging.
REVIEW_EOF
