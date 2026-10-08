#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty/windows/wix/alacritty.wxs`:

This pull request introduces the defect later reported as "Add "Open Alacritty here" (when right click at file explorer's background) in windows 10 context menu throws error when in root directory, with a weird solution.". The
problem a user observed, and its root cause:

system: windows 10 pro 1909 (without WSL)\
I solved the problem with a wired solution but I don't know how I did it.

I want to add "Open Alacritty here" in the context menu (when right-clicking at file explorer's background). So I search online and find this:\
<https://gist.github.com/emlautarom1/5ad137f7e3508efd85ecf611d4dd4f51>

```
[HKEY_CLASSES_ROOT\Directory\Background\shell\alacritty]
@="Open Alacritty here"
"Icon"="C:\\programdata\\chocolatey\\bin\\alacritty.exe"

[HKEY_CLASSES_ROOT\Directory\Background\shell\alacritty\command]
@="\"C:\\programdata\\chocolatey\\bin\\alacritty.exe\" \"--working-directory\" \"%V%\""
```

When this added to the registry, the last variable of the key-value is `"%V%"`. I don't understand why there's an extra `%` after `%V`. They seem to perform the same.

However, I face two directory situations now that **conflicts with each other**. D:\ and D:\Program Files

If I use `"%V"`, right-click at the background open Alacritty here at D:\Program Files and D:\nospace will have no problem. However, D:\ directory will cause Alacritty to throw an error of `Invalid working directory: "D:\""`. I guess it is because the backslash`\` make `"` an escape character.

Then I try `%V`, D:\  will have no problem. However, D:\Program Files is a problem and Alacritty will not open here. I think it is because you need "" around D:\Program Files to compromise the space between Program Files.

Then I try `"%V\"`, the same problem as above and even worse, you can't even open at D:\ProgramFiles which is a directory that doesn't contain space.

Then I try `"%V\\"` which is what the WezTerm terminal emulator did but also can't open at D:\  with right-click at the background. 
 
**Then I try `"%V` and it magically solves the problem. I don't know why.**

cmd and Powershell don't have this problem, they are fine with `cmd.exe /s /k pushd "%V"` and `powershell.exe -noexit -command Set-Location -literalPath '%V'` registry key value. They can open in all two directories. I guess it might because of some of those variables that pass to them, and they considered this situation in the source code for reading directory string.

Here's my edited fork for the gist above in case someone needs it:
<https://gist.github.com/flyxyz123/53ac952fe94a14482565f1d96e5704d5>

This same root cause must be fixed before merging.
REVIEW_EOF
