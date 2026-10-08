#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `osu.Game/Graphics/UserInterface/OsuTextBox.cs`:

This pull request introduces the defect later reported as "Dragging select in Timing tab textboxes will not affect by your clicking position". The
problem a user observed, and its root cause:

### Type

Game behaviour

### Bug description

Hi. As you can see in this video, when you drag in the BPM/Offset textbox (which you're not focused on) to select the number, it doesn't implement your dragging position and uses very first position of the textbox instead.
I know it might be intended, but this is a normal thing in other apps and UI's, so people might find it uncomfortable to work.

https://github.com/user-attachments/assets/174c7f85-1570-429c-ba44-0af5430085b2



### Screenshots or videos

_No response_

### Version

2024.718.1

### Logs

No need

This same root cause must be fixed before merging.
REVIEW_EOF
