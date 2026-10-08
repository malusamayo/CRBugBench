#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `rust/src/files.rs`:

This pull request introduces the defect later reported as "[🐛 Bug]: Selenium Manager should support Edge management using RPM in Linux". The
problem a user observed, and its root cause:

### What happened?

Currently, Selenium Manager uses the DEB package in Linux for Edge management. Nevertheless, this package is not compatible with the Red Hat Linux distros (e.g., Fedora). That should be improved in the Selenium Manager logic since Edge is also shipped as RPM: https://www.microsoft.com/en-us/edge/download?form=MA13FJ

### How can we reproduce the issue?


Run this command in a RPM-based Linux system:

```shell
./selenium-manager --trace --browser edge --force-browser-download
```


### Relevant log output

```shell
[2024-02-27T10:56:10.769Z TRACE] Artifacts: [Artifact { artifact_name: "deb", location: "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_122.0.2365.52-1_amd64.deb", hash: "8542F251416132389AADE5EBD734F29F29275727ABB78E4DD07E2247CC28191C", hash_algorithm: "SHA256", size_in_bytes: 165968574 }]
[2024-02-27T10:56:10.769Z DEBUG] Downloading edge 122.0.2365.52 from https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_122.0.2365.52-1_amd64.deb
[2024-02-27T10:56:10.769Z TRACE] Downloading https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_122.0.2365.52-1_amd64.deb to temporal folder "/tmp/selenium-manager9CpqoP"
[2024-02-27T10:56:10.962Z TRACE] File to be downloaded: microsoft-edge-stable_122.0.2365.52-1_amd64.deb
[2024-02-27T10:56:10.962Z TRACE] File downloaded to temporal folder: /tmp/selenium-manager9CpqoP/microsoft-edge-stable_122.0.2365.52-1_amd64.deb
[2024-02-27T10:56:49.706Z TRACE] The detected extension of the compressed file is deb
[2024-02-27T10:56:49.706Z TRACE] Extracting from /tmp/selenium-manager9CpqoP/microsoft-edge-stable_122.0.2365.52-1_amd64.deb to /tmp/selenium-manager9CpqoP
[2024-02-27T10:56:59.294Z TRACE] Moving extracted files and folders from /tmp/selenium-manager9CpqoP/opt/microsoft/msedge to /home/vagrant/.cache/selenium/edge/linux64/122.0.2365.52
[2024-02-27T10:57:00.419Z ERROR] Cross-device link (os error 18)
```


### Operating System

Red Hat Linux (e.g., Fedora)

### Selenium version

4.18+

### What are the browser(s) and version(s) where you see this issue?

Edge

### What are the browser driver(s) and version(s) where you see this issue?

NA

### Are you using Selenium Grid?

No

This same root cause must be fixed before merging.
REVIEW_EOF
