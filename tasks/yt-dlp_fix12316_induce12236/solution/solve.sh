#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/extractor/francetv.py`:

This pull request introduces the defect later reported as "[francetv:site] direct: `Unable to extract video ID` for france.tv LIVESTREAMS". The
problem a user observed, and its root cause:

### Checklist

- [x] I'm reporting that yt-dlp is broken on a **supported** site
- [x] I've verified that I have **updated yt-dlp to nightly or master** ([update instructions](https://github.com/yt-dlp/yt-dlp#update-channels))
- [x] I've checked that all provided URLs are playable in a browser with the same IP and same login details
- [x] I've checked that all URLs and arguments with special characters are [properly quoted or escaped](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#video-url-contains-an-ampersand--and-im-getting-some-strange-output-1-2839-or-v-is-not-recognized-as-an-internal-or-external-command)
- [x] I've searched [known issues](https://github.com/yt-dlp/yt-dlp/issues/3766), [the FAQ](https://github.com/yt-dlp/yt-dlp/wiki/FAQ), and the [bugtracker](https://github.com/yt-dlp/yt-dlp/issues?q=is%3Aissue%20-label%3Aspam%20%20) for similar issues **including closed ones**. DO NOT post duplicates
- [x] I've read about [sharing account credentials](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#are-you-willing-to-share-account-details-if-needed) and I'm willing to share it if required

### Region

France

### Provide a description that is worded well enough to be understood

This kind of issue have just been solved here : https://github.com/yt-dlp/yt-dlp/issues/12209  
But not for the live stream : https://www.france.tv/france-2/direct.html  
I am using the master version.  
  
  
```
yt-dlp -vU  https://www.france.tv/france-2/direct.html
[debug] Command-line config: ['-vU', 'https://www.france.tv/france-2/direct.html']
[debug] Encodings: locale UTF-8, fs utf-8, pref UTF-8, out utf-8, error utf-8, screen utf-8
[debug] yt-dlp version master@2025.02.08.174857 from yt-dlp/yt-dlp-master-builds [0d9f061d3] (zip)
[debug] Python 3.9.21 (CPython x86_64 64bit) - Linux-6.12.6-x86_64-Intel-R-_Core-TM-_i3-6100H_CPU_@_2.70GHz-with-glibc2.33 (OpenSSL 1.1.1zb  16 Oct 2024, glibc 2.33)
[debug] exe versions: ffmpeg 4.4.2 (fdk,setts), ffprobe 4.4.2
[debug] Optional libraries: brotli-1.0.9, certifi-2021.10.08, requests-2.26.0, sqlite3-3.37.2, urllib3-1.26.8
[debug] Proxy map: {}
[debug] Request Handlers: urllib
[debug] Loaded 1840 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp-master-builds/releases/latest
Latest version: master@2025.02.08.174857 from yt-dlp/yt-dlp-master-builds
yt-dlp is up to date (master@2025.02.08.174857 from yt-dlp/yt-dlp-master-builds)
[francetv:site] Extracting URL: https://www.france.tv/france-2/direct.html
[francetv:site] direct: Downloading webpage
ERROR: [francetv:site] direct: Unable to extract video ID; please report this issue on  https://github.com/yt-dlp/yt-dlp/issues?q= , filling out the appropriate issue template. Confirm you are on the latest version using  yt-dlp -U
  File "/Yt/yt-dlp/yt_dlp/extractor/common.py", line 742, in extract
    ie_result = self._real_extract(url)
  File "/Yt/yt-dlp/yt_dlp/extractor/francetv.py", line 369, in _real_extract
    raise ExtractorError('Unable to extract video ID')
```


### Provide verbose output that clearly demonstrates the problem

- [x] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [ ] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [x] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
[debug] Command-line config: ['-vU', 'https://www.france.tv/france-2/direct.html']
[debug] Encodings: locale UTF-8, fs utf-8, pref UTF-8, out utf-8, error utf-8, screen utf-8
[debug] yt-dlp version master@2025.02.08.174857 from yt-dlp/yt-dlp-master-builds [0d9f061d3] (zip)
[debug] Python 3.9.21 (CPython x86_64 64bit) - Linux-6.12.6-x86_64-Intel-R-_Core-TM-_i3-6100H_CPU_@_2.70GHz-with-glibc2.33 (OpenSSL 1.1.1zb  16 Oct 2024, glibc 2.33)
[debug] exe versions: ffmpeg 4.4.2 (fdk,setts), ffprobe 4.4.2
[debug] Optional libraries: brotli-1.0.9, certifi-2021.10.08, requests-2.26.0, sqlite3-3.37.2, urllib3-1.26.8
[debug] Proxy map: {}
[debug] Request Handlers: urllib
[debug] Loaded 1840 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp-master-builds/releases/latest
Latest version: master@2025.02.08.174857 from yt-dlp/yt-dlp-master-builds
yt-dlp is up to date (master@2025.02.08.174857 from yt-dlp/yt-dlp-master-builds)
[francetv:site] Extracting URL: https://www.france.tv/france-2/direct.html
[francetv:site] direct: Downloading webpage
ERROR: [francetv:site] direct: Unable to extract video ID; please report this issue on  https://github.com/yt-dlp/yt-dlp/issues?q= , filling out the appropriate issue template. Confirm you are on the latest version using  yt-dlp -U
  File "/Yt/yt-dlp/yt_dlp/extractor/common.py", line 742, in extract
    ie_result = self._real_extract(url)
  File "/Yt/yt-dlp/yt_dlp/extractor/francetv.py", line 369, in _real_extract
    raise ExtractorError('Unable to extract video ID')
```

This same root cause must be fixed before merging.
REVIEW_EOF
