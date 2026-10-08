#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `examples/training/rehearsal.py`:

This pull request introduces the defect later reported as "Spacy 2.3 'with nlp.disable_pipes()' does not properly restore the pipes.". The
problem a user observed, and its root cause:

## How to reproduce the behaviour
When I run the example https://spacy.io/usage/training/#example-train-ner with a pretrained model `en_core_web_md` the `with nlp.disable_pipes():` does not get properly closed and the saved model only has the `ner` component, not the tagger and parser. However if I do the normal disable flow without the context manager `disabled.restore()` it works fine.

Seems like a bug to me but wondering if others can reproduce.

## Your Environment

* **spaCy version:** 2.3.0
* **Platform:** Darwin-18.6.0-x86_64-i386-64bit
* **Python version:** 3.7.7

This same root cause must be fixed before merging.
REVIEW_EOF
