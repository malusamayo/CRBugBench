#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `pkg/api/dashboard_test.go`:

This pull request introduces the defect later reported as "Provisioning: Cannot save provisioned dashboard". The
problem a user observed, and its root cause:

**What happened**:
Starting grafana in development mode and see this error message each time provisioning running. 
```
DBUG[11-06|16:30:17] Start walking disk                       logger=provisioning.dashboard type=file name="gdev dashboards" path=devenv/dev-dashboards
DBUG[11-06|16:30:17] saving new dashboard                     logger=provisioning.dashboard type=file name="gdev dashboards" provisioner="gdev dashboards" file=/home/marcus/go/src/github.com/grafana/grafana/devenv/dev-dashboards/panel-polystat/polystat_test.json folderId=1985
EROR[11-06|16:30:17] failed to save dashboard                 logger=provisioning.dashboard type=file name="gdev dashboards" error="Cannot save provisioned dashboard"
```

**What you expected to happen**:
Provisioned dashboard to be saved.

**How to reproduce it (as minimally and precisely as possible)**:
This is an existing provisioned dashboard (1 year old).

dashboard_provisioning row:
```
id | dashboard_id | name | external_id | updated | check_sum -- | -- | -- | -- | -- | --
2562 | 2502 | gdev dashboards | /home/marcus/go/src/github.com/grafana/grafana/devenv/dev-dashboards/panel-polystat/polystat_test.json | 1573035122 | 977b8f242142d17578a4fe5098d64839
```

dashboard row:
```
id | version | slug | title | org_id | created | updated | updated_by | created_by | folder_id | uid -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | --
2502 | 5 | panel-tests-polystat | Panel Tests - Polystat | 1 | 2019-05-27 16:32:47 | 2019-11-06 10:12:02 | -1 | -1 | 1985 | Kp9Z0hTik
```

**Anything else we need to know?**:
Shouldn't validate argument always be false when provisioning saves dashboard? Now code looks like [this](https://github.com/grafana/grafana/blob/master/pkg/services/dashboards/dashboard_service.go#L192) and probably why it fails since allowUiUpdate for devenv provisioned dashboard in grafana repo don't have this flag set to true?

**Environment**:
- Grafana version: master

This same root cause must be fixed before merging.
REVIEW_EOF
