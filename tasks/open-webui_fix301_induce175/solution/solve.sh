#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/lib/components/chat/SettingsModal.svelte`:

This pull request introduces the defect later reported as "Ollama API: option "stop" must be of type array". The
problem a user observed, and its root cause:

# Bug Report

## Description

**Bug Summary:**
Hi, thanks for this awesome project!  
I ran into this issue when trying to set my stop sequence to `\n\n` (so my output would be limited to a single paragraph).  
After saving this stop sequence, Ollama API rejects calls with the error: `option "stop" must be of type array`.

**Steps to Reproduce:**
- Start from a fresh UI install
- Edit advanced options: set "stop sequence" to `\n\n` (though any string will work)
- Attempt to submit a chat message

**Expected Behavior:**
- The Ollama API responds to the prompt

**Actual Behavior:**
- API rejects the request with a 400 BAD REQUEST error and the following message: `option "stop" must be of type array`

## Environment
Model: dolphin-mixtral
Ollama Web UI Version v1.0.0-alpha.33
Ollama Version 0.1.17

## Reproduction Details
- After inspecting my network logs, it seems the UI had stringified the stop sequence option into 
```json
"stop": "\\n\\n",
```
But, the API is expecting an array, so the correct value would have been 
```json
"stop": ["\n\n"],
```

**Confirmation:**
- [x] I have read and followed all the instructions provided in the README.md.
- [x] I have reviewed the troubleshooting.md document.
- [x] I have included the browser console logs.
- [ ] I have included the Docker container logs.

## Logs

**Browser Console Logs:**
XHR POST http://hello-ollama/ollama/api/chat
[HTTP/1.1 400 Bad Request 853ms]
VersionHTTP/1.1
Transferred 403 B (163 B size)

**Docker Container Logs:**
N/A

## Installation Method
Docker with external Ollama instance running on same server, but outside docker

## Additional Information
I've attempted a fix in https://github.com/nielsmaerten/ollama-webui/tree/bugfix/options-stop-array  
While this works for me, it may need to be cleaned up a bit.

## Screenshots
![20l7MUtNiN](https://github.com/ollama-webui/ollama-webui/assets/4604406/11c1e4c8-6fcd-489c-bb52-a0b385896ea8)
![AF57uhUT2B](https://github.com/ollama-webui/ollama-webui/assets/4604406/0b7a9b3d-be0f-4163-92b1-6634d86cd134)
![1xDNW3CDcc](https://github.com/ollama-webui/ollama-webui/assets/4604406/e12fccbb-bacb-4ede-9438-fcca9f3472f3)

This same root cause must be fixed before merging.
REVIEW_EOF
