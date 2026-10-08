#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty_terminal/src/event_loop.rs`:

This pull request introduces the defect later reported as "PTY not read entirely with --hold CLI parameter". The
problem a user observed, and its root cause:

~~Running `alacritty --hold -e bash -c 'column -s, -t < weather.csv'` does not print anything. `alacritty --hold -e bash -c 'ping google.com'` works. The column command in a normal window works. But the column command doesn't seem to work when launched with `alacritty --hold -e bash -c'...`.~~

~~It used to work but recently I found it seems to have broken. Now the window is just blank.~~

When running a command at startup and passing the `--hold` option, the PTY is not always read entirely. Commands like `alacritty --hold -e echo test` often do not print the text written to the PTY. Adding a little `sleep` fixes the problem, so it's likely a problem with the PTY being dropped before it is read entirely since usually without the `--hold` option it's not important to read all of it.

This same root cause must be fixed before merging.
REVIEW_EOF
