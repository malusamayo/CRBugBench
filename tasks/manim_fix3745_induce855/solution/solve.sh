#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `manim/mobject/text/text_mobject.py`:

This pull request introduces the defect later reported as "MarkupText documentation: ul-tag should be changed to u-tag". The
problem a user observed, and its root cause:

## Description of bug / unexpected behavior
This fails with `ValueError: Unknown tag 'ul' on line 1 char 13`
```python
class MarkupExample(Scene):
    def construct(self):
        text = MarkupText("<ul>underlined</ul>")
        self.add(text)
```

## Expected behavior
The docstring in the code indicates that it should produce underlined text: https://github.com/ManimCommunity/manim/blob/9a84ec6a45f2ff4254d2243116f84bac074db551/manim/mobject/text/text_mobject.py#L897

Note that this does work:

```python
class MarkupExample(Scene):
    def construct(self):
        text = MarkupText('<span underline="single">underlined</span>')
        self.add(text)
```


## System specifications
```
Manim Community v0.18.0
```

This same root cause must be fixed before merging.
REVIEW_EOF
