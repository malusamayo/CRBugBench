#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/swiss_public_transport/__init__.py`:

This pull request introduces the defect later reported as "swiss_public_transport rate limit is blocking access to Devices & services page". The
problem a user observed, and its root cause:

### The problem

As described in https://github.com/home-assistant/frontend/issues/21514, I can't access the Devices & services page. @silamon found in my logs that the error was coming from the swiss_public_transport integration. Once it reaches the API limit I get the following: 

2024-08-01 18:21:28.756 ERROR (MainThread) [opendata_transport] Response from transport.opendata.ch: 429, message='Too Many Requests', url=URL('http://transport.opendata.ch/v1/connections?from=K%C3%BCsnacht+ZH&to=Z%C3%BCrich+HB&limit=3&page=0&isArrivalTime=0&direct=0&sleeper=0&couchette=0&bike=0')
2024-08-01 18:21:35.270 ERROR (MainThread) [homeassistant.components.websocket_api.http.connection] [140183641710528] Error handling message: Unknown error (unknown_error) David de Chambrier from 192.168.0.16 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36)
Traceback (most recent call last):
  File "/usr/src/homeassistant/homeassistant/helpers/json.py", line 61, in json_encoder_default
    raise TypeError
TypeError

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/src/homeassistant/homeassistant/components/websocket_api/decorators.py", line 28, in _handle_async_response
    await func(hass, connection, msg)
  File "/usr/src/homeassistant/homeassistant/components/config/config_entries.py", line 531, in config_entries_subscribe
    current_entries = await _async_matching_config_entries_json_fragments(
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/src/homeassistant/homeassistant/components/config/config_entries.py", line 577, in _async_matching_config_entries_json_fragments
    entry.as_json_fragment
  File "/usr/local/lib/python3.12/functools.py", line 995, in __get__
    val = self.func(instance)
          ^^^^^^^^^^^^^^^^^^^
  File "/usr/src/homeassistant/homeassistant/config_entries.py", line 494, in as_json_fragment
    return json_fragment(json_bytes(json_repr))
                         ^^^^^^^^^^^^^^^^^^^^^
TypeError: Type is not JSON serializable: OpendataTransportConnectionError


It might be related to https://github.com/home-assistant/core/issues/119137 as well. 

In the morning, when the API rate is restarted I can access the page again.

### What version of Home Assistant Core has the issue?

core-2024.7.4

### What was the last working version of Home Assistant Core?

core-2024.7.4

### What type of installation are you running?

Home Assistant OS

### Integration causing the issue

swiss_public_transport

### Link to integration documentation on our website

https://www.home-assistant.io/integrations/swiss_public_transport/

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
