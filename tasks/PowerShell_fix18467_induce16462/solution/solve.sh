#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/System.Management.Automation/engine/Modules/SwitchProcessCommand.cs`:

This pull request introduces the defect later reported as "Switch-Process, when used to replace the PowerShell process with an interactive (different) shell session, breaks that session". The
problem a user observed, and its root cause:

### Prerequisites

- [X] Write a descriptive title.
- [X] Make sure you are able to repro it on the [latest released version](https://github.com/PowerShell/PowerShell/releases)
- [X] Search the existing issues.
- [X] Refer to the [FAQ](https://github.com/PowerShell/PowerShell/blob/master/docs/FAQ.md).
- [X] Refer to [Differences between Windows PowerShell 5.1 and PowerShell](https://docs.microsoft.com/powershell/scripting/whats-new/differences-from-windows-powershell).

### Steps to reproduce

Clearly not a common use case, but a bug nonetheless:

When you use `Switch-Process` (`exec`) to replace the current PowerShell process (running an interactive session) with a different shell's interactive session (e.g., `bash`), that session's command-line editing is broken.

```powershell
# Run on macOS or Linux
Switch-Process /bin/bash
```

### Expected behavior

A regular interactive Bash session.

### Actual behavior

What the user types on the Bash command line doesn't print (however, submitting commands and printing output works normally).

### Error details

_No response_

### Environment data

```powershell
PowerShell Core 7.3.0-rc.1 on macOS 12.6 or Linux
```


### Visuals

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
