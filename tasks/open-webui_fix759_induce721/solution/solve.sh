#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/lib/components/chat/Settings/Advanced.svelte`:

This pull request introduces the defect later reported as "Negative Keep Alive value won't work". The
problem a user observed, and its root cause:

# Bug Report

## Description

**Bug Summary:**
Ollama Web UI will throw a "Ollama: time: missing unit in duration -1" when trying to use -1 as a Keep Alive value in the Advanced tab of the Settings. According to [Ollama documentation](https://github.com/ollama/ollama/releases/tag/v0.1.23) a -1 value in the keep_alive header instructs Ollama to keep the model loaded indefinitely

**Steps to Reproduce:**
Go to Settings->Advanced and set Keep Alive to -1, then try to send a message to any model

**Expected Behavior:**
Chat would work normally and the last used model will be kept loaded in Ollama indefinitely

**Actual Behavior:**
Got "Ollama: time: missing unit in duration -1" and "Uh-oh! There was an issue connecting to Ollama" errors when trying to send a message after setting KA to -1

## Environment

- **Operating System:** MacOS Sonoma 14.2.1
- **Browser (if applicable):** Chrome 121.0.6167.184

## Reproduction Details

**Confirmation:**

- [x] I have read and followed all the instructions provided in the README.md.
- [x] I have reviewed the troubleshooting.md document.
- [ ] I have included the browser console logs.
- [ ] I have included the Docker container logs.

## Logs and Screenshots

**Browser Console Logs:**
[Include relevant browser console logs, if applicable]

**Docker Container Logs:**
[Include relevant Docker container logs, if applicable]

**Screenshots (if applicable):**
[Attach any relevant screenshots to help illustrate the issue]

## Installation Method

[Describe the method you used to install the project, e.g., manual installation, Docker, package manager, etc.]

## Additional Information

[Include any additional details that may help in understanding and reproducing the issue. This could include specific configurations, error messages, or anything else relevant to the bug.]

## Note

If the bug report is incomplete or does not follow the provided instructions, it may not be addressed. Please ensure that you have followed the steps outlined in the README.md and troubleshooting.md documents, and provide all necessary information for us to reproduce and address the issue. Thank you!

This same root cause must be fixed before merging.
REVIEW_EOF
