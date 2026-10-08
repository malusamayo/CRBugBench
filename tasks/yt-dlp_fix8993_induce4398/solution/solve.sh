#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/extractor/patreon.py`:

This pull request introduces the defect later reported as "Patreon embedded video not found anymore". The
problem a user observed, and its root cause:

### DO NOT REMOVE OR SKIP THE ISSUE TEMPLATE

- [X] I understand that I will be **blocked** if I *intentionally* remove or skip any mandatory\* field

### Checklist

- [X] I'm reporting that yt-dlp is broken on a **supported** site
- [X] I've verified that I have **updated yt-dlp to nightly or master** ([update instructions](https://github.com/yt-dlp/yt-dlp#update-channels))
- [X] I've checked that all provided URLs are playable in a browser with the same IP and same login details
- [X] I've checked that all URLs and arguments with special characters are [properly quoted or escaped](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#video-url-contains-an-ampersand--and-im-getting-some-strange-output-1-2839-or-v-is-not-recognized-as-an-internal-or-external-command)
- [X] I've searched [known issues](https://github.com/yt-dlp/yt-dlp/issues/3766) and the [bugtracker](https://github.com/yt-dlp/yt-dlp/issues?q=) for similar issues **including closed ones**. DO NOT post duplicates
- [X] I've read the [guidelines for opening an issue](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#opening-an-issue)
- [X] I've read about [sharing account credentials](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#are-you-willing-to-share-account-details-if-needed) and I'm willing to share it if required

### Region

Worldwide

### Provide a description that is worded well enough to be understood

Today it seems that Patreon changed their embedding or embedded videos. The program fails on all embedded videos and creators I got access to. So it looks like a site change.

### Provide verbose output that clearly demonstrates the problem

- [X] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [ ] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [X] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
[debug] Command-line config: ['-vU', '--cookies-from-browser', 'firefox', 'https://www.patreon.com/posts/fairy-tail-30-85954582']
Extracting cookies from firefox
[debug] Extracting cookies from: "C:\Users\Black\AppData\Roaming\Mozilla\Firefox\Profiles\i7jxqj1d.default-release-1663947917890\cookies.sqlite"
Extracted 2322 cookies from firefox
[debug] Encodings: locale cp932, fs utf-8, pref cp932, out utf-8, error utf-8, screen utf-8
[debug] yt-dlp version nightly@2024.01.09.232723 from yt-dlp/yt-dlp-nightly-builds [95e82347b] (win_exe)
[debug] Python 3.8.10 (CPython AMD64 64bit) - Windows-10-10.0.19045-SP0 (OpenSSL 1.1.1k  25 Mar 2021)
[debug] exe versions: ffmpeg N-109468-gd39b34123d-20221230 (setts), ffprobe N-109468-gd39b34123d-20221230
[debug] Optional libraries: Cryptodome-3.19.1, brotli-1.1.0, certifi-2023.11.17, mutagen-1.47.0, requests-2.31.0, sqlite3-3.35.5, urllib3-2.1.0, websockets-12.0
[debug] Proxy map: {}
[debug] Request Handlers: urllib, requests, websockets
[debug] Loaded 1798 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp-nightly-builds/releases/latest
Latest version: nightly@2024.01.09.232723 from yt-dlp/yt-dlp-nightly-builds
yt-dlp is up to date (nightly@2024.01.09.232723 from yt-dlp/yt-dlp-nightly-builds)
[Patreon] Extracting URL: https://www.patreon.com/posts/fairy-tail-30-85954582
[Patreon] 85954582: Downloading API JSON
ERROR: [Patreon] 85954582: No supported media found in this post
  File "yt_dlp\extractor\common.py", line 718, in extract
  File "yt_dlp\extractor\patreon.py", line 289, in _real_extract
  File "yt_dlp\extractor\common.py", line 1196, in raise_no_formats
```

This same root cause must be fixed before merging.
REVIEW_EOF
