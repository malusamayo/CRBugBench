#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Microsoft.PowerShell.Commands.Utility/commands/utility/TestJsonCommand.cs`:

This pull request introduces the defect later reported as "Test-Json doesn't recognize JSON arrays or primitives". The
problem a user observed, and its root cause:

# Steps to reproduce

```powershell
'42' | Test-Json | Should -BeTrue
'[ 1, 2 ]' | Test-Json | Should -BeTrue
```

# Expected behavior

The tests should succeed, given that these are valid [JSON strings](https://www.json.org/json-en.html) and that piping them to `ConvertFrom-Json` works just fine:

```powershell
# These tests pass.
'42' | ConvertFrom-Json | Should -Be 42
'[ 1, 2 ]' | ConvertFrom-Json | Should -Be 1, 2
```

# Actual behavior

Both tests fail.

# Environment data


```none
PowerShell Core 7.0.0-rc.1
```

This same root cause must be fixed before merging.
REVIEW_EOF
