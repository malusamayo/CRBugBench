#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `spacy/tokens/_retokenize.pyx`:

This pull request introduces the defect later reported as "cymem assersion Error in `retokenizer.split`". The
problem a user observed, and its root cause:

```python
text = "Hyperglycemic adverse events following antipsychotic drug administration in"
doc = en(text)

with doc.retokenize() as retokenizer:
    token = doc[0]
    heads = [(token, 0)] * len(token)
    retokenizer.split(doc[token.i], list(token.text), heads=heads)
```

Error:

```
---------------------------------------------------------------------------
AssertionError                            Traceback (most recent call last)
<ipython-input-75-cf40a2ff9ce8> in <module>
      5     token = doc[0]
      6     heads = [(token,0)] * len(token)
----> 7     retokenizer.split(doc[token.i], list(token.text), heads=heads)

_retokenize.pyx in spacy.tokens._retokenize.Retokenizer.__exit__()

_retokenize.pyx in spacy.tokens._retokenize._split()

doc.pyx in spacy.tokens.doc.Doc._realloc()

cymem.pyx in cymem.cymem.Pool.realloc()

AssertionError:
```

spacy version: 2.2.2

This same root cause must be fixed before merging.
REVIEW_EOF
