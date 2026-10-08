#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tabby-electron/src/sshImporters.ts`:

This pull request introduces the defect later reported as "SSH Config HostName is ignored if the key is spelled as "hostname" or "Hostname"". The
problem a user observed, and its root cause:

**Describe the problem:**
When using an SSH configuration file, Tabby does not read the HostName directive if it is spelled as hostname (all lowercase) or Hostname (capital "H"). It seems that Tabby only recognizes HostName exactly with the capital "N" and ignores other variations.

**To Reproduce:**

1. Create or edit your ~/.ssh/config file.
2. Define a host with hostname or Hostname (different cases) instead of HostName.
3. Attempt to connect using Tabby.
4.  Tabby does not show the host.

**Expected behavior:**
Tabby should recognize HostName in any case variation, especially since SSH itself accepts HostName in multiple letter cases.

This same root cause must be fixed before merging.
REVIEW_EOF
