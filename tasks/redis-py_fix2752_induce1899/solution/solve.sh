#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `redis/asyncio/client.py`:

This pull request introduces the defect later reported as "Redis.from_url() is a misnomer". The
problem a user observed, and its root cause:

**Version**: 4.5.2

**Platform**: Python 3.11.2

**Description**: Redis.from_url is a convenience function, but the kwargs are passed into the ConnectionPool object and not the Redis instance. This formerly wasn't a problem, but it appears as though auto_close_connection_pool now defaults to true, so you can't reliably use Redis.from_url() in a singleton.

This same root cause must be fixed before merging.
REVIEW_EOF
