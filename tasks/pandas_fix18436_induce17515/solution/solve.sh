#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `pandas/core/categorical.py`:

This pull request introduces the defect later reported as "BUG: method .nunique on categorical series in v0.21 with only NaNs gives ValueError". The
problem a user observed, and its root cause:

#### Code Sample, a copy-pastable example if possible

```python
>>> ser = pd.Series(pd.Categorical([np.nan]))
>>> ser.nunique()
ValueError: buffer source array is read-only
```
#### Problem description

The above code gave 0 in v20.3 and is expected to give 0 also in v0.21. The problem is independent of if I set some categories.

**EDIT**: Actually this doesn't give error if I set categories. so this only happens if no categories are set. The use case for no categories in my case is programmatically reading in data, where some columns are empty and of dtype categorical.

#### Expected Output

0 (zero)

#### Output of ``pd.show_versions()``

<details>

INSTALLED VERSIONS
------------------
commit: 81372093f1fdc0c07e4b45ba0f47b0360fabd405
python: 3.5.4.final.0
python-bits: 32
OS: Windows
OS-release: 10
machine: AMD64
processor: Intel64 Family 6 Model 78 Stepping 3, GenuineIntel
byteorder: little
LC_ALL: None
LANG: None
LOCALE: None.None

pandas: 0.21.0
pytest: 3.2.3
pip: 9.0.1
setuptools: 36.5.0.post20170922
Cython: None
numpy: 1.13.3
scipy: None
pyarrow: None
xarray: None
IPython: 6.1.0
sphinx: None
patsy: None
dateutil: 2.6.1
pytz: 2017.3
blosc: None
bottleneck: None
tables: None
numexpr: None
feather: None
matplotlib: None
openpyxl: 2.4.8
xlrd: None
xlwt: None
xlsxwriter: None
lxml: None
bs4: None
html5lib: None
sqlalchemy: None
pymysql: None
psycopg2: None
jinja2: 2.9.6
s3fs: None
fastparquet: None
pandas_gbq: None
pandas_datareader: None


</details>

This same root cause must be fixed before merging.
REVIEW_EOF
