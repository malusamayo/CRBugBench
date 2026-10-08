#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `core/src/main/java/bisq/core/app/BisqExecutable.java`:

This pull request introduces the defect later reported as "Changing BTC network does not have any effect". The
problem a user observed, and its root cause:

If user changes the BTC network in settings and restarts MAINNET will be selected again even if the user has changed to testnet. There is probably some bug in the option parsing. @freimair will look into it.
For now users who want to try out the testnet DAO need to add a program argument: 
'--baseCurrencyNetwork=BTC_TESTNET ' to enable testnet.

This same root cause must be fixed before merging.
REVIEW_EOF
