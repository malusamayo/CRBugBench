#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/vs/workbench/contrib/terminalContrib/mouseWheelZoom/browser/terminal.mouseWheelZoom.contribution.ts`:

This pull request introduces the defect later reported as "Terminal error messages: "Cannot have two terminal contributions with the same id" and "Cannot read properties of undefined (reading 'querySelector')"". The
problem a user observed, and its root cause:

Seeing these two error messages consistently:

```
2023-12-13 11:37:02.005 [error] Cannot have two terminal contributions with the same id terminal.find: Error: Cannot have two terminal contributions with the same id terminal.find
    at new De (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:2622:56705)
    at b.j (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:640:1241)
    at b.createInstance (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:640:733)
    at i.createInstance (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:2719:15825)
    at re.createTerminal (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:2719:33517)
    at async vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:1692:21225
    at async vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:149:23472
```

```
2023-12-13 11:37:02.059 [error] Cannot read properties of undefined (reading 'querySelector'): TypeError: Cannot read properties of undefined (reading 'querySelector')
    at b.n (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:2633:11406)
    at b.xtermReady (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:2633:11169)
    at vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:2622:56934
```

This same root cause must be fixed before merging.
REVIEW_EOF
