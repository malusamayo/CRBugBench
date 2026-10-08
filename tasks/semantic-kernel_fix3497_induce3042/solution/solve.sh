#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `dotnet/SK-dotnet.sln`:

This pull request introduces the defect later reported as ".Net: Microsoft.SemanticKernel.Plugins.Memory.dll is delay-signed or test-signed assembly". The
problem a user observed, and its root cause:

**Describe the bug**
The assembly Microsoft.SemanticKernel.Plugins.Memory.dll fails to load on a Windows Server machine:
```
Could not load file or assembly 'Microsoft.SemanticKernel.Plugins.Memory' or one of its dependencies. 
Strong name signature could not be verified. The assembly may have been tampered with, or it was delay
signed but not fully signed with the correct private key. (Exception from HRESULT: 0x80131045) 
```
Checking the assembly with `sn.exe -v` yields:
```
sn -v Microsoft.SemanticKernel.Plugins.Memory.dll

Microsoft (R) .NET Framework Strong Name Utility  Version 4.0.30319.0
Copyright (c) Microsoft Corporation.  All rights reserved.

Microsoft.SemanticKernel.Plugins.Memory.dll is a delay-signed or test-signed assembly
```

**To Reproduce**
Steps to reproduce the behavior:
1. Verify that verification skipping is disabled, i.e. `sn.exe -Vl` for your architecture (x86/x64) shows
```
sn.exe -Vl

Microsoft (R) .NET Framework Strong Name Utility  Version 4.0.30319.0
Copyright (c) Microsoft Corporation.  All rights reserved.

No verification entries registered
```
2. Load the assembly into a runtime that verifies strongname signatures.

**Expected behavior**
The assembly should load without issues.


**Platform**
 - OS: Windows
 - Language: C#
 - Source: beta1, beta4

This same root cause must be fixed before merging.
REVIEW_EOF
