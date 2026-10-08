#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `codec-http/src/main/java/io/netty/handler/codec/http/HttpContentEncoder.java`:

This pull request introduces the defect later reported as "IllegalReferenceCountException with compression enabled but not used if HttpResponse implements HttpContent and not LastHttpContent". The
problem a user observed, and its root cause:

Turns out my fix for https://github.com/netty/netty/issues/11092 was incomplete. It fixes the case where the content is compressed, but it will also fail if the client does not specify an Accept-Encoding.

This same root cause must be fixed before merging.
REVIEW_EOF
