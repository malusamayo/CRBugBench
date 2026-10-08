#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `spacy/pipeline/pipes.pyx`:

This pull request introduces the defect later reported as "part of speech tagger training example from documentation doesn't seem to work after update". The
problem a user observed, and its root cause:

## How to reproduce the behaviour

https://github.com/explosion/spaCy/blob/master/examples/training/train_parser.py
It worked fine for version 2.0.16, now I have tried it using v2.3.0 and faced the following problem: on every iteration loss is zero, the resulting model assigns '_SP' tag to every token.

## Your Environment
* **spaCy version:** 2.3.0
* **Platform:** Windows-10-10.0.18362-SP0
* **Python version:** 3.8.3

This same root cause must be fixed before merging.
REVIEW_EOF
