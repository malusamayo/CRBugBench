#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/media_source/local_source.py`:

This pull request introduces the defect later reported as "Cannot play local media sources and TTS over DLNA". The
problem a user observed, and its root cause:

### The problem

If I try TTS or playing a local media file on a DLNA compatible renderer, it doesn't work and shows an error in the log:
```
[homeassistant.components.dlna_dmr] Error during call async_play_media: UpnpActionResponseError('Error during async_call(), status: 500, upnp error: 716 (Resource not found)')
```

Right before the `Resource not found` error above, the HA logs show that there's a HEAD request coming in from the speaker and that fails with an HTTP 500 error. I also saw somewhere someone hinting that DLNA renderers might send a HEAD request before sending the GET one.


There are several reports around the net about this or related DLNA problems, dating back to 2022:
- #81162
- #111078
- [Media Cast / DLNA not working with Samsung TVs or Smart Monitors](https://community.home-assistant.io/t/media-cast-dlna-not-working-with-samsung-tvs-or-smart-monitors/693075)
- [DLNA Digital Media Renderer Not Working](https://www.reddit.com/r/homeassistant/comments/1fk8ase/dlna_digital_media_renderer_not_working)

Most replies to such issues end up pointing to configuring `media_dirs` ([Setting up local media sources](https://www.home-assistant.io/more-info/local-media/setup-media), [Media Source](https://next.home-assistant.io/integrations/media_source/)), but nothing works, leading to complains about unclear documentation: https://github.com/home-assistant/home-assistant.io/issues/28940.

Also, [the documentation says there might be hiccups with Samsung devices](https://next.home-assistant.io/integrations/dlna_dmr), but that might be exactly because of the missing support for HEAD requests:
> Note that some devices, such as Samsung TVs, are rather picky about the source used to play from. The TTS action might not work in combination with these devices. 

**UPDATE 2025-03-01**
~~However, I haven't tried streaming videos yet. I'll check it later and submit a separate PR if necessary, and it seems to also be an issue like #67618.~~
Videos work with these changes and I also included a fix for local images.


I created a PR (https://github.com/home-assistant/core/pull/134903) which adds support for `HEAD` requests for local_source media, image, and TTS (also allowing signed requests for `HEAD`), which fixes these problems and likely related issues mentioned above. I'd appreciate a review.




### What version of Home Assistant Core has the issue?

core-2025.2.5

### What was the last working version of Home Assistant Core?

_No response_

### What type of installation are you running?

Home Assistant OS

### Integration causing the issue

image, media_source, tts, auth

### Link to integration documentation on our website

https://www.home-assistant.io/integrations/media_source/

### Diagnostics information

_No response_

### Example YAML snippet

```yaml

```

### Anything in the logs that might be useful for us?

```txt
[homeassistant.components.dlna_dmr] Error during call async_play_media: UpnpActionResponseError('Error during async_call(), status: 500, upnp error: 716 (Resource not found)')
```

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
