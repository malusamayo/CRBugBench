#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/polars-core/src/frame/group_by/aggregations/string.rs`:

This pull request introduces the defect later reported as "grouped `arg_min`/`arg_max` for `Binary` returns `null` and `String` single-element groups return wrong index". The
problem a user observed, and its root cause:

### Checks

- [x] I have checked that this issue has not already been reported.
- [x] I have confirmed this bug exists on the [latest version](https://pypi.org/project/polars/) of Polars.

### Reproducible example

```python

import polars as pl

df = pl.DataFrame({
    "key": ["a", "a", "b"],
    "val": [b"x", b"y", b"z"],
})
print(df.group_by("key", maintain_order=True).agg(pl.col("val").arg_max()))

df = pl.DataFrame({
    "key": ["a", "a", "b"],
    "val": ["x", "y", "z"],
})
print(df.group_by("key", maintain_order=True).agg(pl.col("val").arg_max()))

df = pl.DataFrame({
    "key": ["a", "a", "b"],
    "val": [10, 20, 30],
    "by":  ["x", "y", "z"],
})
df.group_by("key", maintain_order=True).agg(pl.col("val").max_by("by"))

```


### Log output

```shell
shape: (2, 2)
┌─────┬──────┐
│ key ┆ val  │
│ --- ┆ ---  │
│ str ┆ u64  │
╞═════╪══════╡
│ a   ┆ null │
│ b   ┆ null │
└─────┴──────┘
shape: (2, 2)
┌─────┬─────┐
│ key ┆ val │
│ --- ┆ --- │
│ str ┆ u64 │
╞═════╪═════╡
│ a   ┆ 1   │
│ b   ┆ 2   │
└─────┴─────┘

thread 'polars-0' (59449) panicked at crates/polars-expr/src/expressions/aggregation.rs:738:42:
index out of bounds: the len is 1 but the index is 2
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
Traceback (most recent call last):
  File "/home/gauta/polars/repro_argmax_groupby.py", line 20, in <module>
    df.group_by("key", maintain_order=True).agg(pl.col("val").max_by("by"))
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/gauta/polars/py-polars/src/polars/dataframe/group_by.py", line 298, in agg
    .collect(optimizations=QueryOptFlags.none())
     ~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/gauta/polars/py-polars/src/polars/_utils/deprecation.py", line 97, in wrapper
    return function(*args, **kwargs)
  File "/home/gauta/polars/py-polars/src/polars/lazyframe/opt_flags.py", line 343, in wrapper
    return function(*args, **kwargs)
  File "/home/gauta/polars/py-polars/src/polars/lazyframe/frame.py", line 2464, in collect
    return wrap_df(ldf.collect(engine, callback))
                   ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^
pyo3_runtime.PanicException: index out of bounds: the len is 1 but the index is 2
```

### Issue description

When calling `arg_min`/`arg_max` inside `group_by`, Binary columns return `null` for every group instead of the correct in-group index. For string columns, multi-element groups return the correct index. However, in single-element `Idx` groups, `arg_max` returns the wrong index, and `arg_min` may incorrectly return `null` when the underlying series contains any nulls. This can also lead to wrong results or a panic when used through `max_by`/`min_by`.

Basically, these regressions became user-visible in #26093
- `SeriesWrap<BinaryChunked>` does not override `agg_arg_min`/`agg_arg_max`, so grouped Binary aggregations fall through to the default `full_null` implementation.
- In the `Idx` fast path, `agg_arg_max` returns the global row index (`first`) for 1-element groups instead of the relative in-group position (`0`); and in the single-element fast path, `agg_arg_min` uses the array-wide `no_nulls` flag instead of per-element validity, so valid single-element groups can incorrectly return `null` when the series contains any nulls.

### Expected behavior

`arg_max` / `arg_min` in `group_by` should return the relative position within the group (0-based), matching the behavior for numeric and boolean dtypes.

### Installed versions

<details>

```
--------Version info---------
Polars:              1.39.3
Index type:          UInt64
Platform:            Linux-6.6.87.2-microsoft-standard-WSL2-x86_64-with-glibc2.39
Python:              3.13.11 | packaged by Anaconda, Inc. | (main, Dec 10 2025, 21:28:48) [GCC 14.3.0]
Runtime:             rt64

----Optional dependencies----
Azure CLI            <not installed>
adbc_driver_manager  <not installed>
altair               <not installed>
azure.identity       <not installed>
boto3                <not installed>
cloudpickle          <not installed>
connectorx           <not installed>
deltalake            <not installed>
fastexcel            <not installed>
fsspec               <not installed>
gevent               <not installed>
google.auth          <not installed>
great_tables         <not installed>
matplotlib           <not installed>
numpy                2.4.3
openpyxl             <not installed>
pandas               <not installed>
polars_cloud         <not installed>
pyarrow              <not installed>
pydantic             2.12.4
pyiceberg            <not installed>
sqlalchemy           <not installed>
torch                <not installed>
xlsx2csv             <not installed>
xlsxwriter           <not installed>

```

</details>

This same root cause must be fixed before merging.
REVIEW_EOF
