#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Jellyfin.Server/Migrations/Routines/MigrateLibraryDb.cs`:

This pull request introduces the defect later reported as "Chapter images not migrated". The
problem a user observed, and its root cause:

### Description of the bug

After upgrading from 10.10 to 10.11 generated chapter images are not displayed in the web UI. A scan must be performed to view them.

### Reproduction steps

1. Have chapter images enabled in your library on a 10.10 server
2. Upgrade to the latest master

### What is the current _bug_ behavior?

Chapter images are not displayed in web UI. 

### What is the expected _correct_ behavior?

Chapter images should be displayed in web UI. 

### Jellyfin Server version

Master

### Specify commit id

b03620d3daefe81d9ea873719f9e75cba361a8fb

### Specify unstable release number

_No response_

### Specify version number

_No response_

### Specify the build version

Dev Server

### Environment

```markdown
- OS: Windows 11
- Plugins: None installed
```

### Jellyfin logs

```shell
No relevant entries.
```

### FFmpeg logs

```shell

```

### Client / Browser logs

_No response_

### Relevant screenshots or videos

_No response_

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
