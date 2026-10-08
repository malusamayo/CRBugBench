#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/polars-plan/src/plans/conversion/join.rs`:

This pull request introduces the defect later reported as "Join fails with PanicException instead of ColumnNotFoundError". The
problem a user observed, and its root cause:

### Checks

- [X] I have checked that this issue has not already been reported.
- [X] I have confirmed this bug exists on the [latest version](https://pypi.org/project/polars/) of Polars.

### Reproducible example

```python
# join.py
import polars as pl

a = pl.DataFrame({"x": [1, 2, 3]})
b = pl.DataFrame({"y": [1, 2, 3]})
a.join(b, on="y")
```

```shell
> uv run --with 'polars==1.12.0' join.py
Traceback (most recent call last):
  File "/home/jan/phd/clustering/join.py", line 5, in <module>
    a.join(b, on="y")
  File "/home/jan/phd/clustering/.venv/lib/python3.12/site-packages/polars/dataframe/frame.py", line 7150, in join
    .collect(_eager=True)
     ^^^^^^^^^^^^^^^^^^^^
  File "/home/jan/phd/clustering/.venv/lib/python3.12/site-packages/polars/lazyframe/frame.py", line 2055, in collect
    return wrap_df(ldf.collect(callback))
                   ^^^^^^^^^^^^^^^^^^^^^
polars.exceptions.ColumnNotFoundError: "y" not found
```

```shell
> uv run --with 'polars==1.13.0' join.py
thread '<unnamed>' panicked at crates/polars-plan/src/plans/conversion/join.rs:126:14:
called `Option::unwrap()` on a `None` value
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
Traceback (most recent call last):
  File "/home/jan/phd/clustering/join.py", line 5, in <module>
    a.join(b, on="y")
  File "/home/jan/.cache/uv/archive-v0/Vi6ISUc8Vikk9vWM4Og84/lib/python3.12/site-packages/polars/dataframe/frame.py", line 7151, in join
    .collect(_eager=True)
     ^^^^^^^^^^^^^^^^^^^^
  File "/home/jan/.cache/uv/archive-v0/Vi6ISUc8Vikk9vWM4Og84/lib/python3.12/site-packages/polars/lazyframe/frame.py", line 2021, in collect
    return wrap_df(ldf.collect(callback))
                   ^^^^^^^^^^^^^^^^^^^^^
pyo3_runtime.PanicException: called `Option::unwrap()` on a `None` value
```

```shell
> uv run --with 'polars==1.13.1' join.py
thread '<unnamed>' panicked at crates/polars-plan/src/plans/conversion/join.rs:126:14:
called `Option::unwrap()` on a `None` value
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
Traceback (most recent call last):
  File "/home/jan/phd/clustering/join.py", line 5, in <module>
    a.join(b, on="y")
  File "/home/jan/.cache/uv/archive-v0/DlBEEtqNl5PBvMKH3DEWW/lib/python3.12/site-packages/polars/dataframe/frame.py", line 7151, in join
    .collect(_eager=True)
     ^^^^^^^^^^^^^^^^^^^^
  File "/home/jan/.cache/uv/archive-v0/DlBEEtqNl5PBvMKH3DEWW/lib/python3.12/site-packages/polars/lazyframe/frame.py", line 2021, in collect
    return wrap_df(ldf.collect(callback))
                   ^^^^^^^^^^^^^^^^^^^^^
pyo3_runtime.PanicException: called `Option::unwrap()` on a `None` value

```

### Log output

_No response_

### Issue description

When joining on column that doesn't exist, version 1.13 throws panic exception instead of the `ColumnNotFoundError` it throws with version 1.12. I see the bug in Python so marking it as such, but I think the bug might be in Rust instead. 


### Expected behavior

All three versions should throw the same error `ColumnNotFoundError`

### Installed versions

<details>

```
--------Version info---------
Polars:              1.13.1
Index type:          UInt32
Platform:            Linux-6.8.0-48-generic-x86_64-with-glibc2.39
Python:              3.12.3 (main, Sep 11 2024, 14:17:37) [GCC 13.2.0]
LTS CPU:             False

----Optional dependencies----
adbc_driver_manager  <not installed>
altair               <not installed>
cloudpickle          <not installed>
connectorx           <not installed>
deltalake            <not installed>
fastexcel            <not installed>
fsspec               2024.10.0
gevent               <not installed>
great_tables         <not installed>
matplotlib           <not installed>
nest_asyncio         <not installed>
numpy                2.1.3
openpyxl             <not installed>
pandas               <not installed>
pyarrow              <not installed>
pydantic             <not installed>
pyiceberg            <not installed>
sqlalchemy           <not installed>
torch                2.5.1+cu124
xlsx2csv             <not installed>
xlsxwriter           <not installed>
```

</details>

This same root cause must be fixed before merging.
REVIEW_EOF
