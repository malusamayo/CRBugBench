#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `spacy/tokens/span.pyx`:

This pull request introduces the defect later reported as "Span.char_span() returns incorrect label". The
problem a user observed, and its root cause:

https://github.com/explosion/spaCy/blob/5ace559201c714ab89b3092b87d791e16973f31d/spacy/tokens/span.pyx#L601
Span.char_span() returns a span with empty label, kb_id and vector.

This was missed in #4793

## Info about spaCy

* **spaCy version:** 2.2.4
* **Platform:** Linux-4.19.112+-x86_64-with-Ubuntu-18.04-bionic
* **Python version:** 3.6.9
* **Models:** en

This same root cause must be fixed before merging.
REVIEW_EOF
