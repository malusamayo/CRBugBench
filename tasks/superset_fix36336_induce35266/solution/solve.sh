#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `superset-frontend/plugins/legacy-preset-chart-deckgl/src/layers/Polygon/transformProps.test.ts`:

This pull request introduces the defect later reported as "Type '"table"' is not assignable to type 'DatasourceType'.". The
problem a user observed, and its root cause:

### Bug description

Hi bot/people.

I managed to get SS run in my work computer with arch WSL and now want to get it to run in my home computer with native Archlinux.

Ran:

docker compose -f docker-compose-non-dev.yml up

and just when ending the node compiling stuff (99.9%) i got:

189.6 <s> [webpack.Progress] 99% cache shutdown IdleFileCachePlugin serialize pack
200.7 <s> [webpack.Progress] 99% cache shutdown IdleFileCachePlugin stored
200.7 <s> [webpack.Progress] 99% cache shutdown
200.7 <s> [webpack.Progress] 100% 
200.7 
202.3 1030 assets
202.3 13946 modules
202.3 
202.3 ERROR in ./plugins/legacy-preset-chart-deckgl/src/layers/Polygon/transformProps.test.ts:58:19
202.3 TS2322: Type '"table"' is not assignable to type 'DatasourceType'.
202.3     56 |       },
202.3     57 |     ],
202.3   > 58 |     datasource: { type: 'table' as const, id: 1 },
202.3        |                   ^^^^
202.3     59 |     height: 400,
202.3     60 |     width: 600,
202.3     61 |     hooks: {},
202.3 
202.3 webpack 5.102.1 compiled with 1 error in 185394 ms
------
failed to solve: process "/bin/sh -c if [ \"${DEV_MODE}\" = \"false\" ]; then         echo \"Running 'npm run ${BUILD_CMD}'\";         npm run ${BUILD_CMD};     else         echo \"Skipping 'npm run ${BUILD_CMD}' in dev mode\";     fi;" did not complete successfully: exit code: 1


I already made this build process twice, removing the volumes in each case. (in case you bot suggest me to do that).

Thanks.

### Screenshots/recordings

_No response_

### Superset version

master / latest-dev

### Python version

3.9

### Node version

16

### Browser

Chrome

### Additional context

_No response_

### Checklist

- [ ] I have searched Superset docs and Slack and didn't find a solution to my problem.
- [ ] I have searched the GitHub issue tracker and didn't find a similar bug report.
- [ ] I have checked Superset's logs for errors and if I found a relevant Python stacktrace, I included it here as text in the "additional context" section.

This same root cause must be fixed before merging.
REVIEW_EOF
