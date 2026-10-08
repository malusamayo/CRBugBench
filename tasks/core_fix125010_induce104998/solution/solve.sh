#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/openai_conversation/__init__.py`:

This pull request introduces the defect later reported as "Blocking call for `openai_conversation` in 2024.9.0b0". The
problem a user observed, and its root cause:

### The problem

Logged error in 2024.9.0b0

`2024-08-28 19:31:36.223 WARNING (MainThread) [homeassistant.util.loop] Detected blocking call to load_verify_locations with args (<ssl.SSLContext object at 0x7f4f116350>,) inside the event loop by integration 'openai_conversation' at homeassistant/components/openai_conversation/__init__.py, line 91: client = openai.AsyncOpenAI(api_key=entry.data[CONF_API_KEY]) (offender: /usr/local/lib/python3.12/site-packages/httpx/_config.py, line 147: context.load_verify_locations(cafile=cafile))`

### What version of Home Assistant Core has the issue?

2024.9.0b0

### What was the last working version of Home Assistant Core?

_No response_

### What type of installation are you running?

Home Assistant OS

### Integration causing the issue

openai_conversation

### Link to integration documentation on our website

https://www.home-assistant.io/integrations/openai_conversation/

### Diagnostics information

_No response_

### Example YAML snippet

_No response_

### Anything in the logs that might be useful for us?

_No response_

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
