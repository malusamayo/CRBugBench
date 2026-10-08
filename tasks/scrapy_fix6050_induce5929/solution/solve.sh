#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `scrapy/downloadermiddlewares/retry.py`:

This pull request introduces the defect later reported as "`downloadermiddlewares.retry.BackwardsCompatibilityMetaclass` does not provide backward compatibility for middleware instances". The
problem a user observed, and its root cause:

# Description

Previously, `EXCEPTIONS_TO_RETRY` was an attribute of `RetryMiddleware`. This allows:
- `RetryMiddleware` subclasses could access `EXCEPTIONS_TO_RETRY` via `cls.EXCEPTIONS_TO_RETRY`.
- `RetryMiddleware` instances and instances of its subclasses could access `EXCEPTIONS_TO_RETRY` via `self.EXCEPTIONS_TO_RETRY`.

In 2.10 `EXCEPTIONS_TO_RETRY` was removed and added as a property to `BackwardsCompatibilityMetaclass`. This added compatibility only for the first point.

# Steps to Reproduce

```python
class MyRetryMiddleware(RetryMiddleware):

    def process_exception(self, request, exception, spider):
        if isinstance(exception, self.EXCEPTIONS_TO_RETRY) and not request.meta.get('dont_retry', False):
            # update request
            return self._retry(request, exception, spider)
```

# Expected behavior

A warning about `EXCEPTIONS_TO_RETRY` deprecation.

# Actual behavior

AttributeError: 'MyRetryMiddleware' object has no attribute 'EXCEPTIONS_TO_RETRY'

# Versions

```
Scrapy       : 2.10.1
lxml         : 4.9.3.0
libxml2      : 2.10.3
cssselect    : 1.2.0
parsel       : 1.8.1
w3lib        : 2.1.2
Twisted      : 22.10.0
Python       : 3.11.4 (tags/v3.11.4:d2340ef, Jun  7 2023, 05:45:37) [MSC v.1934 64 bit (AMD64)]
pyOpenSSL    : 23.2.0 (OpenSSL 3.1.2 1 Aug 2023)
cryptography : 41.0.3
Platform     : Windows-10-10.0.19044-SP0
```

This same root cause must be fixed before merging.
REVIEW_EOF
