#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/vs/workbench/contrib/output/browser/outputView.ts`:

This pull request introduces the defect later reported as "Output channel editor disappears after reload". The
problem a user observed, and its root cause:

- Open an output channel
- Reload the window
- Sometimes it disappears, and the devtools show all these errors

<img width="900" alt="Image" src="https://github.com/user-attachments/assets/26f9acb4-5e0d-4ce1-863d-141d7fdc1941" />

```
ERR InstantiationService has been disposed: Error: InstantiationService has been disposed
    at r0t.m (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:1905:372)
    at r0t.createInstance (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:1905:929)
    at ZAe.Q (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:5795)
    at new ZAe (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:3159)
    at Ca.cc (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:276:18175)
    at Ca.bc (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:276:16433)
    at Ca.setModel (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:276:409)
    at xct.setInput (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:1319:74037)
    at async xct.setInput (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:2527:15544)
error @ log.ts:460
log.ts:460   ERR Cannot read properties of undefined (reading 'getWidgets'): TypeError: Cannot read properties of undefined (reading 'getWidgets')
    at ZAe.S (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:6491)
    at Object.prepareRenderText (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:9741)
    at Object.prepareRenderText (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:9160)
    at vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13169
    at ZR (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:12680)
    at tki.g (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13160)
    at jMe.t [as d] (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13073)
    at jMe.execute (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:14711)
    at n (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:14954)
    at vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:15125
error @ log.ts:460
log.ts:460   ERR Cannot read properties of undefined (reading 'domNode'): TypeError: Cannot read properties of undefined (reading 'domNode')
    at Object.renderText (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:9870)
    at Object.renderText (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:9261)
    at vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13260
    at ZR (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:12680)
    at tki.g (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13251)
    at jMe.t [as d] (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13073)
    at jMe.execute (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:14711)
    at n (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:14954)
    at vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:15125
error @ log.ts:460
log.ts:460   ERR Cannot read properties of undefined (reading 'getWidgets'): TypeError: Cannot read properties of undefined (reading 'getWidgets')
    at ZAe.S (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:6491)
    at Object.prepareRenderText (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:9741)
    at Object.prepareRenderText (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:9160)
    at vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13169
    at ZR (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:12680)
    at tki.g (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13160)
    at jMe.t [as d] (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:239:13073)
    at jMe.execute (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:14711)
    at n (vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:14954)
    at vscode-file://vscode-app/Applications/Visual%20Studio%20Code%20-%20Insiders.app/Contents/Resources/app/out/vs/workbench/workbench.desktop.main.js:32:15125
```

This has been an issue for awhile, I think. If the output pane is not visible when reloading the window, it doesn't happen

This same root cause must be fixed before merging.
REVIEW_EOF
