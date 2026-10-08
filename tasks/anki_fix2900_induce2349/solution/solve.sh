#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `qt/aqt/editor.py`:

This pull request introduces the defect later reported as "Raycast copy and paste problem". The
problem a user observed, and its root cause:

The objective of this issue tracker is to gather users which are affected by the issue
---

**App involved**: [Raycast (Floating Notes)](https://www.raycast.com/)

[**Forum post related**](https://forums.ankiweb.net/t/copy-paste-issue/37168?u=namelessgo)

**Workaround**: Because Anki relies on clipboard change events, it seems that switching to another application, fixes the issue

Example of workaround: Copy "A"in anki, then "B" in floating note (Raycast), then switch application and paste on Anki, it would fix the issue and paste the correct "B" instead of "AB"


Steps to reproduce:
1. Copy text (a) from field in Anki.
2. Copy another text (b) from another app.
3. Paste text in Anki (this renders text a)
4. Paste text in Anki again (this renders text b).

![65f01f5eb813305c774d36083971285a73065a89](https://github.com/ankitects/anki/assets/66227691/f616c3cd-9639-445a-b5df-e0d3da02fde5)
Credits for reporting, providing the steps to reproduce and GIF: herrsilen

This same root cause must be fixed before merging.
REVIEW_EOF
