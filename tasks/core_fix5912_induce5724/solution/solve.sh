#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/mqtt/__init__.py`:

This pull request introduces the defect later reported as "mqtt discovery error". The
problem a user observed, and its root cause:

**Home Assistant release (`hass --version`):**
HA 0.38.1

**Python release (`python3 --version`):**
Python 3.5.2

**Component/platform:**
docker

**Description of problem:**
error starting 

**Expected:**


**Problem-relevant `configuration.yaml` entries and steps to reproduce:**
```yaml
mqtt:
  discovery: true
```

1. restart
2. watch starting output
3. 

**Traceback (if applicable):**
```bash
rpi-home-assistant_1  | 17-02-12 17:13:48 ERROR (MainThread) [homeassistant.bootstrap] Error during setup of component mqtt
rpi-home-assistant_1  | Traceback (most recent call last):
rpi-home-assistant_1  |   File "/usr/local/lib/python3.5/site-packages/homeassistant/bootstrap.py", line 152, in _async_setup_component
rpi-home-assistant_1  |     None, component.setup, hass, config)
rpi-home-assistant_1  |   File "uvloop/future.pyx", line 230, in __iter__ (uvloop/loop.c:110600)
rpi-home-assistant_1  |   File "uvloop/future.pyx", line 432, in uvloop.loop.BaseTask._fast_wakeup (uvloop/loop.c:113980)
rpi-home-assistant_1  |   File "uvloop/future.pyx", line 101, in uvloop.loop.BaseFuture._result_impl (uvloop/loop.c:108900)
rpi-home-assistant_1  |   File "/usr/local/lib/python3.5/concurrent/futures/thread.py", line 55, in run
rpi-home-assistant_1  |     result = self.fn(*self.args, **self.kwargs)
rpi-home-assistant_1  |   File "/usr/local/lib/python3.5/site-packages/homeassistant/components/mqtt/__init__.py", line 334, in setup
rpi-home-assistant_1  |     _setup_discovery(hass, config)
rpi-home-assistant_1  |   File "/usr/local/lib/python3.5/site-packages/homeassistant/components/mqtt/__init__.py", line 240, in _setup_discovery
rpi-home-assistant_1  |     success = discovery.start(hass, conf[CONF_DISCOVERY_PREFIX], config)
rpi-home-assistant_1  | AttributeError: module 'homeassistant.components.mqtt.discovery' has no attribute 'start'
rpi-home-assistant_1  | 17-02-12 17:13:48 ERROR (MainThread) [homeassistant.bootstrap] Component mqtt failed to setup
rpi-home-assistant_1  | 17-02-12 17:13:48 ERROR (MainThread) [homeassistant.bootstrap] Unable to prepare setup for platform automation.mqtt because dependency mqtt could not be initialized
```

**Additional info:**

This same root cause must be fixed before merging.
REVIEW_EOF
