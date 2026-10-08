#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `scrapy/extensions/feedexport.py`:

This pull request introduces the defect later reported as "Storage.store is called only for the first feed when empty". The
problem a user observed, and its root cause:

### Description

When having `FEED_STORE_EMPTY=False` and multiple feeds, and the output is empty, `storage.store` is called until first empty feed slot is encountered.

### Steps to Reproduce

1. Create a `test.py` file with [this spider](https://gist.github.com/StasDeep/c7f0b775eb4897b1012f2c76ce6296f5)
2. `scrapy runspider test.py -L INFO`

**Expected behavior:**

```
2020-06-10 10:50:27 [test] INFO: Storing in thread: gs://bucket/output.json
2020-06-10 10:50:27 [test] INFO: Storing in thread: gs://bucket/output.csv
```

**Actual behavior:**

```
2020-06-10 10:50:27 [test] INFO: Storing in thread: gs://bucket/output.json
```

**Reproduces how often:** always

### Versions

```
Scrapy       : 2.1.0
lxml         : 4.5.1.0
libxml2      : 2.9.10
cssselect    : 1.1.0
parsel       : 1.6.0
w3lib        : 1.22.0
Twisted      : 20.3.0
Python       : 3.7.4 (default, Sep  4 2019, 15:20:53) - [Clang 10.0.0 (clang-1000.10.44.4)]
pyOpenSSL    : 19.1.0 (OpenSSL 1.1.1g  21 Apr 2020)
cryptography : 2.9.2
Platform     : Darwin-19.4.0-x86_64-i386-64bit
```

### Reason

In `FeedExporter.close_spider`, it **returns** a deferred from inside a loop instead of adding it to `deferred_list`

```
        deferred_list = []
        for slot in self.slots:
            if not slot.itemcount and not slot.store_empty:
                # We need to call slot.storage.store nonetheless to get the file
                # properly closed.
                return defer.maybeDeferred(slot.storage.store, slot.file)
```

This same root cause must be fixed before merging.
REVIEW_EOF
