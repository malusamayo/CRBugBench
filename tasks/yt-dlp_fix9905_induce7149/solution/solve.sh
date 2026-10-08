#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/extractor/bilibili.py`:

This pull request introduces the defect later reported as "[Bilibili] failure to download whole channels videos". The
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

China

### Provide a description that is worded well enough to be understood

Download whole channels videos failed, but download single one is OK.

### Provide verbose output that clearly demonstrates the problem

- [X] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [ ] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [X] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
./yt-dlp_linux -Uv --cookies-from-browser firefox https://space.bilibili.com/68412710 
[debug] Command-line config: ['-Uv', '--cookies-from-browser', 'firefox', 'https://space.bilibili.com/68412710']
[debug] Encodings: locale UTF-8, fs utf-8, pref UTF-8, out utf-8, error utf-8, screen utf-8
[debug] yt-dlp version nightly@2024.05.08.232715 from yt-dlp/yt-dlp-nightly-builds (linux_exe)
[debug] Python 3.11.9 (CPython x86_64 64bit) - Linux-6.8.0-31-generic-x86_64-with (OpenSSL 3.1.4 24 Oct 2023)
[debug] exe versions: ffmpeg 6.1.1 (setts), ffprobe 6.1.1
[debug] Optional libraries: Cryptodome-3.20.0, brotli-1.1.0, certifi-2024.02.02, mutagen-1.47.0, requests-2.31.0, secretstorage-3.3.3, sqlite3-3.44.2, urllib3-2.2.1, websockets-12.0
[debug] Proxy map: {'https': 'http://127.0.0.1:1081', 'http': 'http://127.0.0.1:1081'}
Extracting cookies from firefox
[debug] Extracting cookies from: "/home/xia/snap/firefox/common/.mozilla/firefox/f8edbslu.default/cookies.sqlite"
Extracted 1836 cookies from firefox
[debug] Request Handlers: urllib, requests, websockets
[debug] Loaded 1810 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp-nightly-builds/releases/latest
Latest version: nightly@2024.05.08.232715 from yt-dlp/yt-dlp-nightly-builds
yt-dlp is up to date (nightly@2024.05.08.232715 from yt-dlp/yt-dlp-nightly-builds)
[BilibiliSpaceVideo] Extracting URL: https://space.bilibili.com/68412710
[BilibiliSpaceVideo] A channel URL was given. Only the channel's videos will be downloaded. To download audios, add a "/audio" to the URL
[BilibiliSpaceVideo] 68412710: Downloading JSON metadata
[BilibiliSpaceVideo] 68412710: Downloading page 0
ERROR: [BilibiliSpaceVideo] 68412710: Request is blocked by server (412), please add cookies, wait and try later.
  File "yt_dlp/extractor/common.py", line 734, in extract
  File "yt_dlp/extractor/bilibili.py", line 1072, in _real_extract
  File "yt_dlp/extractor/bilibili.py", line 974, in _extract_playlist
  File "yt_dlp/extractor/bilibili.py", line 1051, in fetch_page
```

This same root cause must be fixed before merging.
REVIEW_EOF
