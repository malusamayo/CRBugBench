#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/polars-core/src/frame/column/mod.rs`:

This pull request introduces the defect later reported as "Full join with categorical fails". The
problem a user observed, and its root cause:

### Checks

- [X] I have checked that this issue has not already been reported.
- [X] I have confirmed this bug exists on the [latest version](https://pypi.org/project/polars/) of Polars.

### Reproducible example

```python
a = pl.LazyFrame({"a": [1], "c": [None]}, schema={"a": pl.Int64, "c": pl.Categorical})
b = pl.LazyFrame({"a": [1,3,4]})
a.join(b, on="a", how="full", coalesce=True).collect()
```

results in 

```
join parallel: true
FULL join dataframes finished

thread '<unnamed>' panicked at /home/runner/work/polars/polars/crates/polars-arrow/src/array/binview/mod.rs:336:9:
assertion failed: i < self.len()
---------------------------------------------------------------------------
PanicException                            Traceback (most recent call last)
<ipython-input-49-2eb897db543a> in ?()
----> 1 a.join(b, on="a", how="full", coalesce=True).collect()

python3.11/site-packages/decorator.py in ?(*args, **kw)
    229         def fun(*args, **kw):
    230             if not kwsyntax:
    231                 args, kw = fix(args, kw, sig)
--> 232             return caller(func, *(extras + args), **kw)

python3.11/site-packages/polars/dataframe/frame.py in ?(self)
   1181     def __repr__(self) -> str:
-> 1182         return self.__str__()

python3.11/site-packages/polars/dataframe/frame.py in ?(self)
   1178     def __str__(self) -> str:
-> 1179         return self._df.as_str()

PanicException: assertion failed: i < self.len()
```

### Log output

```shell
join parallel: true
FULL join dataframes finished
```


### Issue description

A full join with a categorical column as a non-by column causes a full join to fail.
removing the categorical column allows the join to work

### Expected behavior

A full join should be possible here

### Installed versions

<details>

```
--------Version info---------
Polars:              1.13.1
Index type:          UInt32
Platform:            Linux-6.8.0-48-generic-x86_64-with-glibc2.39
Python:              3.11.9 (main, Apr 19 2024, 16:48:06) [GCC 11.2.0]
LTS CPU:             False

----Optional dependencies----
adbc_driver_manager  <not installed>
altair               <not installed>
cloudpickle          <not installed>
connectorx           <not installed>
deltalake            <not installed>
fastexcel            <not installed>
fsspec               2024.3.1
gevent               <not installed>
great_tables         <not installed>
matplotlib           <not installed>
nest_asyncio         <not installed>
numpy                1.24.3
openpyxl             3.1.2
pandas               2.1.4
pyarrow              16.0.0
pydantic             1.10.13
pyiceberg            <not installed>
sqlalchemy           1.4.39
torch                <not installed>
xlsx2csv             <not installed>
xlsxwriter           <not installed>
```

</details>

This same root cause must be fixed before merging.
REVIEW_EOF
