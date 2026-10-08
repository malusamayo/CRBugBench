#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `OpenRA.Mods.Common/ServerTraits/LobbyCommands.cs`:

This pull request introduces the defect later reported as "game speed is not working". The
problem a user observed, and its root cause:

in multiplayer games the game speed would always be at the slowest... no matter what i am taking faster or fastest its just not working on the game

This same root cause must be fixed before merging.
REVIEW_EOF
