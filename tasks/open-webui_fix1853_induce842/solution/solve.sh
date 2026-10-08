#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/lib/components/common/Modal.svelte`:

This pull request introduces the defect later reported as "bug: Settings modal should not close when dragging from inside of modal". The
problem a user observed, and its root cause:

# Bug Report

## Description
The modal closes unexpectedly on `mouseup` when dragging from inside the modal.
For example, when highlighting text from within the modal, `mousedown` is on the foreground and `mouseup` is on the backdrop. It should not close in this case:

![open-webui-mouseup-close-small](https://github.com/open-webui/open-webui/assets/14891742/9ce8dde4-0b97-4fc3-8110-3a9202c44786)

**Expected Behavior:**
In this case, the modal should stay open.

**Actual Behavior:**
The modal closes.

## Environment

- **Open WebUI Version:** 0.1.122
- **Ollama (if applicable):** 0.1.32

- **Operating System:** Windows 10
- **Browser (if applicable):** Chrome

**Confirmation:**

- [x] I have read and followed all the instructions provided in the README.md.
- [x] I am on the latest version of both Open WebUI and Ollama.
- [ ] I have included the browser console logs.
- [ ] I have included the Docker container logs.

## Installation Method

Normal `docker` way:
> docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main

## Suggested fix
It seems reasonable to follow the ChatGPT UI here and use the `mousedown` event instead of the `click` event.

This same root cause must be fixed before merging.
REVIEW_EOF
