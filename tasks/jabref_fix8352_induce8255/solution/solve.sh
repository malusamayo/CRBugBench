#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/org/jabref/gui/preview/PreviewViewer.java`:

This pull request introduces the defect later reported as "Exception at org.jabref.gui.desktop.os.Linux.lambda$nativeOpenFile$0". The
problem a user observed, and its root cause:

### JabRef version

Latest development branch build (please note build date below)

### Operating system

GNU / Linux

### Details on version and operating system

Fedora 35

### Checked with the latest development build

- [X] I made a backup of my libraries before testing the latest development version.
- [X] I have tested the latest development version and the problem persists

### Steps to reproduce the behaviour

When I click on the bibtex key in the preview pane, I get this exception. Maybe related to https://github.com/JabRef/jabref/issues/8280?

### Appendix

...
<details>

<summary>Log File</summary>

```
java.lang.NullPointerException
	at java.base/java.io.File.<init>(Unknown Source)
	at org.jabref@5.4.519/org.jabref.gui.desktop.os.Linux.lambda$nativeOpenFile$0(Unknown Source)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
	at java.base/java.lang.Thread.run(Unknown Source)

```

</details>

This same root cause must be fixed before merging.
REVIEW_EOF
