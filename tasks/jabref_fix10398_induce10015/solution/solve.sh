#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/org/jabref/gui/fieldeditors/PopOverUtil.java`:

This pull request introduces the defect later reported as "New "Journal Information" functionality does not work for entries where Journaltitle is specified instead of Journal.". The
problem a user observed, and its root cause:

### JabRef version

5.10 (latest release)

### Operating system

GNU / Linux

### Details on version and operating system

_No response_

### Checked with the latest development build (copy version output from About dialog)

- [X] I made a backup of my libraries before testing the latest development version.
- [X] I have tested the latest development version and the problem persists

### Steps to reproduce the behaviour

1. Open a BibLaTeX entry in Entry Editor (make sure that journaltitle is defined but journal is not—see MWE below).
2. Click on _i_ next to Journaltitle field. Message appears stating "ISSN or journal name required for fetching journal information".
4. Switch to "biblatex source" tab.
5. Copy and paste journaltitle field, rename to "journal".
6. Switch to "Required fields", click on _i_ next to Journaltitle field. Popup with journal information opens.

### Appendix

<details>

<summary>MWE BibLaTeX File</summary>

```
@Article{Rayleigh1878,
  author           = {Rayleigh, John William Strutt},
  date             = {1878-07},
  journaltitle     = {Nature},
  title            = {The explanation of certain acoustical phenomena},
  doi              = {10.1038/018319a0},
  number           = {455},
  pages            = {319--321},
  volume           = {18},
  modificationdate = {2023-09-18T13:48:18},
}
```

</details>

This same root cause must be fixed before merging.
REVIEW_EOF
