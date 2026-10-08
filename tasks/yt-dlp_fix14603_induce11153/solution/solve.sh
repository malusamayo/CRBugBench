#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/__init__.py`:

This pull request introduces the defect later reported as "--compat-opt prefer-vp9-sort prioritizes web_safari formats (AVC) above actual VP9 formats". The
problem a user observed, and its root cause:

### Checklist

- [x] I'm reporting a bug unrelated to a specific site
- [x] I've verified that I have **updated yt-dlp to nightly or master** ([update instructions](https://github.com/yt-dlp/yt-dlp#update-channels))
- [x] I've searched [known issues](https://github.com/yt-dlp/yt-dlp/issues/3766), [the FAQ](https://github.com/yt-dlp/yt-dlp/wiki/FAQ), and the [bugtracker](https://github.com/yt-dlp/yt-dlp/issues?q=is%3Aissue%20-label%3Aspam%20%20) for similar issues **including closed ones**. DO NOT post duplicates
- [x] I've read the [policy against AI/LLM contributions](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#automated-contributions-ai--llm-policy) and understand I may be blocked from the repository if it is violated

### Provide a description that is worded well enough to be understood

The ``--compat-opt prefer-vp9-sort`` parameter does not behave as expected, selecting web_safari formats first and then actual VP9 formats second.

### Provide verbose output that clearly demonstrates the problem

- [x] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [ ] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [x] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
yt-dlp --compat-opt prefer-vp9-sort -vUF https://www.youtube.com/watch?v=JYSDnC37K4s
[debug] Command-line config: ['--compat-opt', 'prefer-vp9-sort', '-vUF', 'https://www.youtube.com/watch?v=JYSDnC37K4s']
[debug] Portable config "C:\yt-dlp\yt-dlp.conf": ['-o', '%(title)s.%(ext)s', '-P', 'D:\\Escritorio', '--alias', 'video', '--extractor-args youtube:formats=dashy --merge mp4 -N 20 --embed-thumbnail --embed-chapters --embed-subs --sub-lang all']
[debug] Encodings: locale cp1252, fs utf-8, pref cp1252, out utf-8, error utf-8, screen utf-8
[debug] yt-dlp version nightly@2025.10.01.232815 from yt-dlp/yt-dlp-nightly-builds [551303610] (win_exe)
[debug] Compatibility options: prefer-vp9-sort
[debug] Python 3.10.11 (CPython AMD64 64bit) - Windows-10-10.0.19045-SP0 (OpenSSL 1.1.1t  7 Feb 2023)
[debug] exe versions: ffmpeg 2023-02-19-git-2aec86695a-full_build-www.gyan.dev (setts), ffprobe 2023-02-19-git-2aec86695a-full_build-www.gyan.dev
[debug] Optional libraries: Cryptodome-3.23.0, brotli-1.1.0, certifi-2025.08.03, curl_cffi-0.13.0, mutagen-1.47.0, requests-2.32.5, sqlite3-3.40.1, urllib3-2.5.0, websockets-15.0.1
[debug] Proxy map: {}
[debug] Request Handlers: urllib, requests, websockets, curl_cffi
[debug] Plugin directories: none
[debug] Loaded 1833 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp-nightly-builds/releases/latest
Latest version: nightly@2025.10.01.232815 from yt-dlp/yt-dlp-nightly-builds
yt-dlp is up to date (nightly@2025.10.01.232815 from yt-dlp/yt-dlp-nightly-builds)
[debug] [youtube] [pot] PO Token Providers: none
[debug] [youtube] [pot] PO Token Cache Providers: memory
[debug] [youtube] [pot] PO Token Cache Spec Providers: webpo
[youtube] Extracting URL: https://www.youtube.com/watch?v=JYSDnC37K4s
[youtube] JYSDnC37K4s: Downloading webpage
[youtube] JYSDnC37K4s: Downloading tv client config
[debug] [youtube] Forcing player 0004de42 in place of player 3dfa10c2
        original url = /s/player/3dfa10c2/player_ias.vflset/en_US/base.js
[youtube] JYSDnC37K4s: Downloading tv player API JSON
[youtube] JYSDnC37K4s: Downloading web safari player API JSON
[debug] Loading youtube-nsig.0004de42-main from cache
[debug] [youtube] Decrypted nsig XySHPwPxCFlikki => wXtyT_ZIHzNR2w
[debug] [youtube] Decrypted nsig xrC2KZGpl3QO8S4 => BWmxV4zjsm14ug
[youtube] JYSDnC37K4s: Downloading m3u8 information
[debug] Sort order given by user: hidden, aud_or_vid, hasvid, ie_pref, lang, quality, res, fps, hdr:12, vcodec:vp9.2, channels, acodec, size, br, asr, proto, ext, hasaud, source, id
[debug] Sort order given by extractor: quality, res, fps, hdr:12, source, vcodec, channels, acodec, lang, proto
[debug] Formats sorted by: hasvid, ie_pref, lang, quality, res, fps, hdr:12(7), vcodec:vp9.2(10), channels, acodec, size, br, asr, proto, vext, aext, hasaud, source, id
[info] Available formats for JYSDnC37K4s:
ID     EXT   RESOLUTION FPS CH │   FILESIZE   TBR PROTO │ VCODEC          VBR ACODEC      ABR ASR MORE INFO
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
sb3    mhtml 48x27        0    │                  mhtml │ images                                  storyboard
sb2    mhtml 80x45        0    │                  mhtml │ images                                  storyboard
sb1    mhtml 160x90       0    │                  mhtml │ images                                  storyboard
sb0    mhtml 320x180      0    │                  mhtml │ images                                  storyboard
249-0  webm  audio only      2 │   10.99MiB   60k https │ audio only          opus        60k 48k [fr-FR] French (FR), low, TV, webm_dash
249-1  webm  audio only      2 │   11.21MiB   61k https │ audio only          opus        61k 48k [de-DE] German (DE), low, TV, webm_dash
249-2  webm  audio only      2 │   11.35MiB   61k https │ audio only          opus        61k 48k [ja] Japanese, low, TV, webm_dash
249-3  webm  audio only      2 │   11.37MiB   62k https │ audio only          opus        62k 48k [it] Italian, low, TV, webm_dash
249-4  webm  audio only      2 │   11.42MiB   62k https │ audio only          opus        62k 48k [pt-BR] Portuguese (BR), low, TV, webm_dash
249-5  webm  audio only      2 │   11.47MiB   62k https │ audio only          opus        62k 48k [es-US] Spanish (US), low, TV, webm_dash
249-6  webm  audio only      2 │   11.47MiB   62k https │ audio only          opus        62k 48k [pl] Polish, low, TV, webm_dash
249-7  webm  audio only      2 │   11.49MiB   62k https │ audio only          opus        62k 48k [hi] Hindi, low, TV, webm_dash
249-8  webm  audio only      2 │   11.57MiB   63k https │ audio only          opus        63k 48k [uk] Ukrainian, low, TV, webm_dash
249-9  webm  audio only      2 │   11.58MiB   63k https │ audio only          opus        63k 48k [ml] Malayalam, low, TV, webm_dash
249-10 webm  audio only      2 │   11.70MiB   63k https │ audio only          opus        63k 48k [id] Indonesian, low, TV, webm_dash
250-0  webm  audio only      2 │   14.18MiB   77k https │ audio only          opus        77k 48k [fr-FR] French (FR), low, TV, webm_dash
250-1  webm  audio only      2 │   14.48MiB   78k https │ audio only          opus        78k 48k [de-DE] German (DE), low, TV, webm_dash
250-2  webm  audio only      2 │   14.62MiB   79k https │ audio only          opus        79k 48k [ja] Japanese, low, TV, webm_dash
250-3  webm  audio only      2 │   14.67MiB   79k https │ audio only          opus        79k 48k [it] Italian, low, TV, webm_dash
250-4  webm  audio only      2 │   14.68MiB   80k https │ audio only          opus        80k 48k [pt-BR] Portuguese (BR), low, TV, webm_dash
250-5  webm  audio only      2 │   14.76MiB   80k https │ audio only          opus        80k 48k [es-US] Spanish (US), low, TV, webm_dash
250-6  webm  audio only      2 │   14.80MiB   80k https │ audio only          opus        80k 48k [hi] Hindi, low, TV, webm_dash
250-7  webm  audio only      2 │   14.81MiB   80k https │ audio only          opus        80k 48k [pl] Polish, low, TV, webm_dash
250-8  webm  audio only      2 │   14.91MiB   81k https │ audio only          opus        81k 48k [uk] Ukrainian, low, TV, webm_dash
250-9  webm  audio only      2 │   14.92MiB   81k https │ audio only          opus        81k 48k [ml] Malayalam, low, TV, webm_dash
250-10 webm  audio only      2 │   15.06MiB   82k https │ audio only          opus        82k 48k [id] Indonesian, low, TV, webm_dash
140-0  m4a   audio only      2 │   23.91MiB  129k https │ audio only          mp4a.40.2  129k 44k [de-DE] German (DE), medium, TV

This same root cause must be fixed before merging.
REVIEW_EOF
