#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `scripts/run.sh`:

This pull request introduces the defect later reported as "Syntax error in run.sh". The
problem a user observed, and its root cause:

### Steps To Reproduce

While deploying Bitwarden server with docker using command `bitwarden.sh update`, the following error line appears:

```
[...]/bwdata/scripts/run.sh: line 194: [: =: unary operator expected
```

It corresponds to the following script line:

```
if [ $KEY_CONNECTOR_ENABLED = true ];
```

I think there are some quotes missing, this should be:

```
if [ "$KEY_CONNECTOR_ENABLED" = true ];
```

which returns no error if `KEY_CONNECTOR_ENABLED` is undefined.

It seems not to be breaking anything though in my case.

### Expected Result

No error in log.

### Actual Result

Error in log:

```
[...]/bwdata/scripts/run.sh: line 194: [: =: unary operator expected
```

### Screenshots or Videos

_No response_

### Additional Context

_No response_

### Build Version

1.45.2

### Environment

Self-Hosted

### Environment Details

- Operating system: Synology DSM with Docker 20.10.3
- Environment: Docker
- Hardware: DS 216+ Intel Celeron N3050, 8GB RAM

This same root cause must be fixed before merging.
REVIEW_EOF
