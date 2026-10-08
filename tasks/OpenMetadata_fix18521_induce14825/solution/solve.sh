#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ingestion/src/metadata/ingestion/source/database/iceberg/fs/s3.py`:

This pull request introduces the defect later reported as "Iceberg Metadata Ingestion failing due to S3 FileSystem Initialisation ". The
problem a user observed, and its root cause:

**Affected module**
Does it impact the UI, backend or Ingestion Framework?
-- Ingestion

**Describe the bug**
When ingesting Iceberg table metadata in OpenMetadata version 1.5.10, the ingestion process encounters a TypeError indicating an issue with the S3FileSystem initialization. Specifically, the error shows that expected bytes, pydantic_core._pydantic_core.Url found. This appears to be related to the S3 file system implementation that requires a fix.

**To Reproduce**

Screenshots or steps to reproduce

```
Traceback (most recent call last):
  File "/home/airflow/.local/lib/python3.10/site-packages/metadata/ingestion/source/database/iceberg/metadata.py", line 183, in get_tables_name_and_type 
    table = self.iceberg.load_table(table_identifier)
  File "/home/airflow/.local/lib/python3.10/site-packages/pyiceberg/catalog/hive.py", line 358, in load_table 
    return self._convert_hive_into_iceberg(hive_table, io)
  File "/home/airflow/.local/lib/python3.10/site-packages/pyiceberg/catalog/hive.py", line 239, in _convert_hive_into_iceberg 
    file = io.new_input(metadata_location)
  File "/home/airflow/.local/lib/python3.10/site-packages/pyiceberg/io/pyarrow.py", line 369, in new_input 
    fs=self.fs_by_scheme(scheme),
  File "/home/airflow/.local/lib/python3.10/site-packages/pyiceberg/io/pyarrow.py", line 319, in _initialize_fs 
    return S3FileSystem(**client_kwargs)
  File "pyarrow/_s3fs.pyx", line 356, in pyarrow._s3fs.S3FileSystem.__init__ 
  File "<stringsource>", line 15, in string.from_py.__pyx_convert_string_from_py_6libcpp_6string_std__in_string 
TypeError: expected bytes, pydantic_core._pydantic_core.Url found
```

**Expected behavior**
A clear and concise description of what you expected to happen.
--The ingestion process should complete successfully, loading metadata for Iceberg tables without raising errors related to S3FileSystem.

**Version:**
 - OS: [e.g. iOS]
 - Python version:
 - OpenMetadata version: [e.g. 0.8]  v1.5.10
 - OpenMetadata Ingestion package version: [e.g. `openmetadata-ingestion[docker]==XYZ`]

**Additional context**
Add any other context about the problem here.

This same root cause must be fixed before merging.
REVIEW_EOF
