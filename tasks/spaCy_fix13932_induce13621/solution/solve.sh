#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `spacy/strings.pyx`:

This pull request introduces the defect later reported as "Exception in memory_zone does not clear vocab". The
problem a user observed, and its root cause:

When using the `nlp.memory_zone()`, if an exception occurs inside the memory zone and you then try and use the `nlp` object to process another doc, it retains the vocab from the previous use.

## How to reproduce the behaviour
```python
import spacy

def spacy_proc(nlp, text, should_raise=False):
    with nlp.memory_zone():
        doc = nlp(text)
        for token in doc:
            print(token.text, token.pos_, token.dep_)

        if should_raise:
            raise Exception("This is a test exception to check memory zone handling.")

        return doc

def main():
    nlp = spacy.load("en_core_web_md")
    try:
        spacy_proc(nlp, "This is a test sentence to check memory zones in spaCy.", should_raise=True)
    except Exception:
        pass  # Handle the exception gracefully

    spacy_proc(nlp, "Some more text to process after the exception.")
    # raises AssertionError on "spacy/vocab.pyx", line 199, in spacy.vocab.Vocab.get
```
You can work around this by using a try/except inside the memory zone, and raising the caught exception _outside_ of it, like this:
```python
import spacy

def spacy_proc(nlp, text, should_raise=False):
    err = None
    with nlp.memory_zone():
        try:
          doc = nlp(text)
          for token in doc:
              print(token.text, token.pos_, token.dep_)

          if should_raise: 
              raise Exception("This is a test exception to check memory zone handling.")

          return doc
        except Exception as e:
             err = e
    raise err  # raise _after_ the memory zone closes

def main():
    nlp = spacy.load("en_core_web_md")
    try:
        spacy_proc(nlp, "This is a test sentence to check memory zones in spaCy.", should_raise=Tr  ue)
    except Exception:
        pass  # Handle the exception gracefully

    spacy_proc(nlp, "Some more text to process after the exception.") # succeeds
```

I'm not sure if this is the intended implementation, but it feels like a sharp edge to me and should be documented. Or the memory zone should ensure it handles exceptions and closes down correctly before raising them.

## Your Environment
### Info about spaCy

- **spaCy version:** 3.8.11
- **Platform:** macOS-26.1-arm64-arm-64bit-Mach-O (also seeing this on AWS Graviton, ARM environment)
- **Python version:** 3.13.3
- **Pipelines:** en_core_web_md (3.8.0)

This same root cause must be fixed before merging.
REVIEW_EOF
