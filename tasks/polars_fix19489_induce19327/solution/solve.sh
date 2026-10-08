#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/polars-arrow/src/compute/take/fixed_size_list.rs`:

This pull request introduces the defect later reported as "Incorrect `group_by().first()` aggregation of Arrays". The
problem a user observed, and its root cause:

### Checks

- [X] I have checked that this issue has not already been reported.
- [X] I have confirmed this bug exists on the [latest version](https://pypi.org/project/polars/) of Polars.

### Reproducible example

### A.
First the simple version which works perfectly.
```python
import polars as pl


df = pl.DataFrame(
    [
        pl.Series('bin', [None, None, 0.0, 0.0, 0.0], dtype=pl.Float64),
        pl.Series('bin_edges', [None, None, [1.0, 1.0], [1.0, 1.0], [1.0, 1.0]], dtype=pl.Array(pl.Float64, shape=(2,))),
    ]
)
df_result = df.group_by("bin").agg(pl.col("bin_edges").first())
print(df_result)
```
gives
```
shape: (2, 2)
┌──────┬───────────────┐
│ bin  ┆ bin_edges     │
│ ---  ┆ ---           │
│ f64  ┆ array[f64, 2] │
╞══════╪═══════════════╡
│ 0.0  ┆ [1.0, 1.0]    │
│ null ┆ [1.0, 1.0]    │
└──────┴───────────────┘
```

#### B
Now I construct the same dataframe but in a more complicated way (sorry for the long code, already cut down)
```python
import numpy as np
import polars as pl


def bin_feature(
    feature: pl.Series,
    n_bins: int = 10,
):
    """Helper function to bin features of different dtypes."""
    # We treat NaN as Null values, numpy will see a Null as a NaN.
    feature = feature.fill_nan(None)

    # Binning
    # ...
    # Simplify code, just use unique values.
    bin_edges = np.unique(feature.drop_nulls())

    # We want: bins[i-1] < x <= bins[i]
    f_binned = np.digitize(feature, bins=bin_edges, right=True)
    # The full bin edges also include min and max of the feature.
    bin_edges = np.r_[feature.min(), bin_edges, feature.max()]
    # This is quite a hack with numpy strides and views. We want to accomplish
    # bin_edges = [[value0, value1], [value1, value2], [value2, value3], ..]
    bin_edges = np.lib.stride_tricks.as_strided(
        bin_edges, (bin_edges.shape[0] - 1, 2), bin_edges.strides * 2
    )
    # Back to the binned feature.
    # Now, we insert Null values again at the original places.
    f_binned = (
        pl.LazyFrame(
            [
                feature,
                pl.Series("__f_binned", f_binned, dtype=feature.dtype),
                pl.Series(
                    "__bin_edges",
                    bin_edges[f_binned],
                    dtype=pl.Array(pl.Float64, 2),
                ),
            ]
        )
        .select(
            pl.when(pl.col(feature.name).is_null())
            .then(None)
            .otherwise(pl.col("__f_binned"))
            .alias("bin"),
            pl.when(pl.col(feature.name).is_null())
            .then(None)
            .otherwise(pl.col("__bin_edges"))
            .alias("bin_edges"),
        )
        .collect()
    )
    return feature, n_bins, f_binned

feature, n_bins, f_binned = bin_feature(
    feature=pl.Series('feature', [None, None, 1.0, 1.0, 1.0], dtype=pl.Float64),
    n_bins=10,
)

df = pl.DataFrame([f_binned.get_column("bin"), f_binned.get_column("bin_edges")])

df_result = df.group_by("bin").agg(pl.col("bin_edges").first())
print(df_result)
```
results in 
```
shape: (2, 2)
┌──────┬───────────────┐
│ bin  ┆ bin_edges     │
│ ---  ┆ ---           │
│ f64  ┆ array[f64, 2] │
╞══════╪═══════════════╡
│ 0.0  ┆ [1.0, 1.0]    │
│ null ┆ [1.0, 1.0]    │
└──────┴───────────────┘
```
Note:
1. For `bin = null` the `bin_edges` value should be `null`.
2. If you `print(df)`, you will see exactly the same dataframe as in section A.

### Log output

_No response_

### Issue description

It worked with polars 1.6. Somewhere on the way to polars 1.12 this bug occurred.

### Expected behavior

See section A.

### Installed versions

<details>

```
--------Version info---------
Polars:              1.12.0
Index type:          UInt32
Platform:            macOS-15.0.1-x86_64-i386-64bit
Python:              3.12.4 (main, Jun  6 2024, 18:26:44) [Clang 15.0.0 (clang-1500.3.9.4)]
LTS CPU:             False

----Optional dependencies----
adbc_driver_manager  <not installed>
altair               5.4.1
cloudpickle          3.0.0
connectorx           <not installed>
deltalake            <not installed>
fastexcel            <not installed>
fsspec               2024.9.0
gevent               <not installed>
great_tables         <not installed>
matplotlib           3.9.2
nest_asyncio         1.6.0
numpy                2.1.2
openpyxl             <not installed>
pandas               2.2.2
pyarrow              17.0.0
pydantic             <not installed>
pyiceberg            <not installed>
sqlalchemy           <not installed>
torch                2.2.2
xlsx2csv             <not installed>
xlsxwriter           <not installed>
```

</details>

This same root cause must be fixed before merging.
REVIEW_EOF
