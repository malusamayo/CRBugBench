#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ts/editable/frame-handle.ts`:

This pull request introduces the defect later reported as "Mathjax get deleted even when cursor is on it's left". The
problem a user observed, and its root cause:

Tested on d100f7a2c8681b2d4dd1bf03797ef8fb3157358b

Reproduction:
* In a field, enter some mathjax content
* Move the cursor immediately to the left of the mathjax content (you can enter mathjax and use the left arrow. Or you can click on the left of mathjax and press the right arrow once. You arrive at a position that is not reachable by clicking)
* press backspace (the touch to delete what is on the left)

Expected result:
* Nothing occurs since mathjax is on the left part of the field. In particular mathjax remains

Actual result:
* Mathjax content is deleted. Element that appears on the left of the cursor remains (worse: you can't just use ctrl-z to cancel)

The same thing occur with cursor on the right and pressing delete.

This is a minimal example of the bug. It comes from real issue I had with editing the notes, but I simplified it as much as I could to explain it. I lost quite a lot of equations due to it until I finally understood what was occurring. For context, what occurred is that I had fields `Let ($)n\in\mathbb N(/$)` and I wanted to remove "Let". So I double clicked on "let", pressed back key, then moved to the right using the keyboard to check whether a space remained; since I was still on the left of mathjax, I concluded that a space remained, pressed "backspace" and here it is, I lost my mathjax

This same root cause must be fixed before merging.
REVIEW_EOF
