#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/System.Management.Automation/FormatAndOutput/DefaultFormatters/PowerShellCore_format_ps1xml.cs` (around line 1054): By looking purely at the `if ($myinv -and $myinv.MyCommand)` block, it's theoretically possible that this block doesn't return a string value (maybe that's not the case practically, but from a code analysis point of view, it's possible).

In the case that the `if` block doesn't return anything, we should not return anything back from this script block, but by putting this line here, we will return a sequence for the error color.

It may be better to do the following:
```
### within the "if (@('NativeCommandErrorMessage','NativeCommandError')  ..." block

$myinv = $_.InvocationInfo
$commandPrefix = if ($myinv -and $myinv.MyCommand) {
...
}

### Pre-pend the error color only if we have a command prefix to return.
if ($commandPrefix -and $Host.UI.SupportsVirtualTerminal) {
    $PSStyle.Formatting.Error + $commandPrefix
}
```
REVIEW_EOF
