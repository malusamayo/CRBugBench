#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/System.Management.Automation/engine/Modules/SwitchProcessCommand.cs`:

This pull request introduces the defect later reported as "Switch-Process (exec) fails to make the replacement process inherit the calling process' environment variables". The
problem a user observed, and its root cause:

### Prerequisites

- [X] Write a descriptive title.
- [X] Make sure you are able to repro it on the [latest released version](https://github.com/PowerShell/PowerShell/releases)
- [X] Search the existing issues.
- [X] Refer to the [FAQ](https://github.com/PowerShell/PowerShell/blob/master/docs/FAQ.md).
- [X] Refer to [Differences between Windows PowerShell 5.1 and PowerShell](https://docs.microsoft.com/powershell/scripting/whats-new/differences-from-windows-powershell).

### Steps to reproduce

It is understood that the newly introduced, Unix-only `Switch-Process` cmdlet (alias `exec`) is _not_ designed to have full feature parity with the `exec` built-in in POSIX-compatible shells, notably not with respect to supporting stream redirections.

However, making the replacement process inherit the caller's environment is an important part of `exec` functionality (and it is how it works in POSIX-compatible shells).

Related discussion predating `Switch-Process`:
* #12750

```powershell
# Run on macOS or Linux.
# Note the use of `exec`; if you remove it, 'bar' prints as expected
pwsh -nop -c '$env:FOO=''bar''; exec /bin/sh -c ''echo $FOO'''
```

### Expected behavior

```console
bar
```


### Actual behavior

(no output)


### Error details

_No response_

### Environment data

```powershell
PowerShell Core 7.3.0-rc.1 on Unix-like platforms
```


### Visuals

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
