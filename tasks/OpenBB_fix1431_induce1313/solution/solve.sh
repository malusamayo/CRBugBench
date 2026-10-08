#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `gamestonk_terminal/keys_controller.py`:

This pull request introduces the defect later reported as "setenv CMC api key does not work". The
problem a user observed, and its root cause:

Even if I enter the CMC API key in the setenv file it does not work.

<img width="612" alt="image" src="https://user-images.githubusercontent.com/6489169/153190807-2ed9f67a-51a7-4a1d-8cfb-0102766b9f2a.png">

But when I curl with the same API key to CMC it works.
command is : `curl -H "X-CMC_PRO_API_KEY: ************************" -H "Accept: application/json" -d "start=1&limit=5000&convert=USD" -G https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest`

```json
{"status":{"timestamp":"2022-02-09T11:23:55.074Z","error_code":0,"error_message":null,"elapsed":1,"credit_count":1,"notice":null},"data":[{"id":8105,"name":"8l3juac3stc","symbol":"k9hllal6wyo","slug":"tymech2501r","cmc_rank":3439,"num_market_pairs":2351,"circulating_supply":4751,"total_supply":4859,"max_supply":3417,"last_updated":"2022-02-09T11:23:55.074Z","date_added":"2022-02-09T11:23:55.074Z","tags":.....
```

This same root cause must be fixed before merging.
REVIEW_EOF
