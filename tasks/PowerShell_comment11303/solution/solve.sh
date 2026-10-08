#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Microsoft.PowerShell.Commands.Utility/commands/utility/Get-Error.cs` (around line 11): @SteveL-MSFT, your last commit had 4 failures in `PowerShell-CI-windows`
Error occurred in test script 'D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1'
```powershell
At D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1:106 char:1
+ }
+ ~
Unexpected token '}' in expression or statement.
at <ScriptBlock>, D:\a\1\s\src\powershell-win-core\bin\Release\netcoreapp3.1\win7-x64\publish\Modules\Pester\4.8.0\Pester.psm1: line 1097
```
Error occurred in test script 'D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1'
```powershell
At D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1:106 char:1
+ }
+ ~
Unexpected token '}' in expression or statement.
at <ScriptBlock>, D:\a\1\s\src\powershell-win-core\bin\Release\netcoreapp3.1\win7-x64\publish\Modules\Pester\4.8.0\Pester.psm1: line 1097
```
Error occurred in test script 'D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1'
```powershell
At D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1:106 char:1
+ }
+ ~
Unexpected token '}' in expression or statement.
at <ScriptBlock>, D:\a\1\s\src\powershell-win-core\bin\Release\netcoreapp3.1\win7-x64\publish\Modules\Pester\4.8.0\Pester.psm1: line 1097
```
Error occurred in test script 'D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1'
```powershell
At D:\a\1\s\test\powershell\Modules\Microsoft.PowerShell.Utility\Foreach-Object-Parallel.Tests.ps1:106 char:1
+ }
+ ~
Unexpected token '}' in expression or statement.
at <ScriptBlock>, D:\a\1\s\src\powershell-win-core\bin\Release\netcoreapp3.1\win7-x64\publish\Modules\Pester\4.8.0\Pester.psm1: line 1097
```
REVIEW_EOF
