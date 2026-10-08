#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `redis/commands/core.py`:

This pull request introduces the defect later reported as "4.0.0rc1 breaks various zrange commands on older servers". The
problem a user observed, and its root cause:

**Version**: redis-py 4.0.0rc1, redis 6.0.16 (or any less than 6.2).

**Platform**: Python 3.8, Ubuntu 20.04

**Description**:

Previously calling `zrevrange` or `zrange(..., desc=True)` would use ZREVRANGE on the wire. Somewhere between 4.0.0b1 and 4.0.0rc1 this changed to use `ZRANGE ... REV`, which is new syntax in Redis 6.2. When using an older server this causes a syntax error.

To reproduce:
```python
import redis
r = redis.Redis('localhost')
r.zrevrange('foo', 0, -1)
```

Other commands are also affected e.g. zrangebyscore and zrangebylex are also using ZRANGE with options on the wire which is not supported pre-6.2.

This same root cause must be fixed before merging.
REVIEW_EOF
