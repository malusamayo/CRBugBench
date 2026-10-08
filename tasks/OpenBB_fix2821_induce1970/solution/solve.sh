#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `openbb_terminal/cryptocurrency/crypto_controller.py`:

This pull request introduces the defect later reported as "[Bug] Crypto: `find -h` - Error: 'NoneType' object has no attribute 'coin'". The
problem a user observed, and its root cause:

This error message prints with the help dialogue: `Error: 'NoneType' object has no attribute 'coin'`

<img width="352" alt="Screen Shot 2022-10-12 at 8 05 00 PM" src="https://user-images.githubusercontent.com/85772166/195489707-5e9e1ab6-6a48-40d8-8fb6-1cdf7485082f.png">

<img width="1363" alt="Screen Shot 2022-10-12 at 7 38 59 PM" src="https://user-images.githubusercontent.com/85772166/195486174-7aa5b278-c80b-4a5b-b56c-49c2a9de7e0f.png">

<img width="562" alt="Screen Shot 2022-10-12 at 7 43 08 PM" src="https://user-images.githubusercontent.com/85772166/195486701-139b65ce-a83a-4bb4-9387-2668a9605969.png">

<img width="1027" alt="Screen Shot 2022-10-12 at 7 44 17 PM" src="https://user-images.githubusercontent.com/85772166/195486841-c98edaa5-0d66-41d5-862f-18ffd2a55719.png">

<img width="364" alt="Screen Shot 2022-10-12 at 7 45 13 PM" src="https://user-images.githubusercontent.com/85772166/195486929-bb68b3af-a56e-46ed-a7f8-cbe4a035fc5b.png">

<img width="526" alt="Screen Shot 2022-10-12 at 7 46 22 PM" src="https://user-images.githubusercontent.com/85772166/195487077-f45900d3-a050-483f-b029-de12f37215c9.png">

This same root cause must be fixed before merging.
REVIEW_EOF
