#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/telegram_bot/__init__.py`:

This pull request introduces the defect later reported as "Telegram polling not completting when sender has no 'last_name'". The
problem a user observed, and its root cause:

Make sure you are running the latest version of Home Assistant before reporting an issue.

You should only file an issue if you found a bug. Feature and enhancement requests should go in [the Feature Requests section](https://community.home-assistant.io/c/feature-requests) of our community forum:

**Home Assistant release (`hass --version`):**
0.43.0

**Python release (`python3 --version`):**
The one supplied with the homeassistant docker image

**Component/platform:**
telegram_polling

**Description of problem:**
Telegram polling expects a 'last_name' to be set, if it is not it will not complete the polling job

**Expected:**
Receive the message sent via telegram

**Problem-relevant `configuration.yaml` entries and steps to reproduce:**
```yaml

```

1. 
2. 
3. 

**Traceback (if applicable):**
```bash
17-04-24 17:50:39 ERROR (Dummy-14) [homeassistant.core] Error doing job: Task exception was never retrieved
Traceback (most recent call last):
  File "uvloop/future.pyx", line 372, in uvloop.loop.BaseTask._fast_step (uvloop/loop.c:112669)
  File "/usr/src/app/homeassistant/components/telegram_bot/polling.py", line 119, in check_incoming
    yield from self.handle()
  File "/usr/src/app/homeassistant/components/telegram_bot/polling.py", line 108, in handle
    self.process_message(update)
  File "/usr/src/app/homeassistant/components/telegram_bot/__init__.py", line 118, in process_message
    ATTR_FROM_LAST: data['from']['last_name']}
KeyError: 'last_name'

```

**Additional info:**
I have my telegram account for a while now, I'm not sure if this can happen with newer accounts, maybe you are now required to set a `last name`?

This same root cause must be fixed before merging.
REVIEW_EOF
