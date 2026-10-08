#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/cli/src/databases/migrations/mysqldb/1717498465931-AddActivatedAtUserSetting.ts`:

This pull request introduces the defect later reported as "Endless crashloop after upgrading to latest". The
problem a user observed, and its root cause:

### Bug Description

n8n is in an endless crash-loop after upgrading to latest.
This has been running fine for more than year. A standard n8n set-up with docker compose with mysql database.
Only change in a long time has been upgrading to latest version.

```
User settings loaded from: /home/node/.n8n/config
Last session crashed
Migrations in progress, please do NOT stop the process.
Migration "AddActivatedAtUserSetting1717498465931" failed, error: You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'JSON))
			WHERE settings IS NOT NULL AND JSON_EXTRACT(settings, '$.userActiva...' at line 2
Error: There was an error running database migrations
QueryFailedError: You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'JSON))
			WHERE settings IS NOT NULL AND JSON_EXTRACT(settings, '$.userActiva...' at line 2
User settings loaded from: /home/node/.n8n/config
Last session crashed
```

### To Reproduce

A standard n8n set-up with docker compose with mysql database.
Only change in a long time has been upgrading to latest version.

Issue is with the latest version. Apologies since I cannot remember the previous version, but I had upgraded to the latest docker version in approx early June 2024.

### Expected behavior

Dont be in crash loop.

### Operating System

Ubuntu 22.04 LTS Server

### n8n Version

latest docker tag

### Node.js Version

not sure

### Database

MySQL

### Execution mode

main (default)

This same root cause must be fixed before merging.
REVIEW_EOF
