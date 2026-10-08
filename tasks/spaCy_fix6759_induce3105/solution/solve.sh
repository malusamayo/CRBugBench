#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `spacy/matcher/matcher.pyx`:

This pull request introduces the defect later reported as "Matcher with single "OP": "?" returns 0-length matches". The
problem a user observed, and its root cause:

## How to reproduce the behaviour
<!-- Include a code example or the steps that led to the problem. Please try to be as specific as possible. -->

When the pattern contains a single token dict with `"OP": "?"`, the `Matcher` returns 0-length matches at the start of the non-matching tokens, which additionally cause `AssertionError`s with `greedy` options because there are checks for 0-length matches that aren't performed without `greedy`.

```python
import spacy
from spacy.tokens import Doc
from spacy.matcher import Matcher

nlp = spacy.blank("en")
doc = Doc(nlp.vocab, words=["a", "b"], tags=["A", "B"])

# 1. Without greedy

## 1a. Without attributes: no 0-length matches
matcher = Matcher(nlp.vocab)
matcher.add("TEST", [[{"OP": "?"}]])
assert matcher(doc) == [(1046765068364475028, 0, 1), (1046765068364475028, 1, 2)]

## 1b. With non-matching attributes: 0-length matches immediately preceding non-matching tokens
matcher = Matcher(nlp.vocab)
matcher.add("TEST", [[{"TAG": "C", "OP": "?"}]])
assert matcher(doc) == [(1046765068364475028, 0, 0), (1046765068364475028, 1, 1)]

matcher = Matcher(nlp.vocab)
matcher.add("TEST", [[{"TAG": "A", "OP": "?"}]])
assert matcher(doc) == [(1046765068364475028, 0, 1), (1046765068364475028, 1, 1)]

# 2. With greedy

## 2a. Without attributes: no 0-length matches
matcher = Matcher(nlp.vocab)
matcher.add("TEST", [[{"OP": "?"}]], greedy="FIRST")
assert matcher(doc) == [(1046765068364475028, 0, 1), (1046765068364475028, 1, 2)]

## 2b. With non-matching attributes: AssertionError due to check for 0-length matches
try:
    matcher = Matcher(nlp.vocab)
    matcher.add("TEST", [[{"TAG": "C", "OP": "?"}]], greedy="FIRST")
    matcher(doc)
    assert False
except AssertionError:
    assert True
```

## Your Environment

- **spaCy version:** 3.0.0rc2 (for `greedy` and extended `Doc` init, the behavior for the cases in 1 with 0-length matches in the same in v2.3)

This same root cause must be fixed before merging.
REVIEW_EOF
