#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/model/channel/message.rs`:

This pull request introduces the defect later reported as "Invalid Type Error". The
problem a user observed, and its root cause:

Iterating over all the messages in a server yields me an invalid type error every time. The error is:
`invalid type: string "#d0334d", expected u32 at line 1 column 123537`
I don't really know what to do in order to help debug this but I assume this is a deserialization error.
Branch: `current`

This same root cause must be fixed before merging.
REVIEW_EOF
