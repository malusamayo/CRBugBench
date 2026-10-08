#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/extractor/polskieradio.py`:

This pull request introduces the defect later reported as "[polskieradio] Download skips first nine files in playlist.". The
problem a user observed, and its root cause:

### DO NOT REMOVE OR SKIP THE ISSUE TEMPLATE

- [X] I understand that I will be **blocked** if I *intentionally* remove or skip any mandatory\* field

### Checklist

- [X] I'm reporting that yt-dlp is broken on a **supported** site
- [X] I've verified that I'm running yt-dlp version **2023.10.13** ([update instructions](https://github.com/yt-dlp/yt-dlp#update)) or later (specify commit)
- [X] I've checked that all provided URLs are playable in a browser with the same IP and same login details
- [X] I've checked that all URLs and arguments with special characters are [properly quoted or escaped](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#video-url-contains-an-ampersand--and-im-getting-some-strange-output-1-2839-or-v-is-not-recognized-as-an-internal-or-external-command)
- [X] I've searched [known issues](https://github.com/yt-dlp/yt-dlp/issues/3766) and the [bugtracker](https://github.com/yt-dlp/yt-dlp/issues?q=) for similar issues **including closed ones**. DO NOT post duplicates
- [X] I've read the [guidelines for opening an issue](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#opening-an-issue)
- [ ] I've read about [sharing account credentials](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#are-you-willing-to-share-account-details-if-needed) and I'm willing to share it if required

### Region

_No response_

### Provide a description that is worded well enough to be understood

The download starts from the 10th file in the playlist. Skip the first 9.

### Provide verbose output that clearly demonstrates the problem

- [X] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [ ] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [X] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
[debug] Command-line config: ['-vU', '--max-downloads', '1', 'https://trojka.polskieradio.pl/audycja/6568']
[debug] Encodings: locale cp1250, fs utf-8, pref cp1250, out utf-8, error utf-8, screen utf-8
[debug] yt-dlp version stable@2023.10.13 [b634ba742] (win_exe)
[debug] Python 3.8.10 (CPython AMD64 64bit) - Windows-10-10.0.19045-SP0 (OpenSSL 1.1.1k  25 Mar 2021)
[debug] exe versions: none
[debug] Optional libraries: Cryptodome-3.19.0, brotli-1.1.0, certifi-2023.07.22, mutagen-1.47.0, sqlite3-3.35.5, websockets-11.0.3
[debug] Proxy map: {}
[debug] Loaded 1890 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest
Available version: stable@2023.10.13, Current version: stable@2023.10.13
Current Build Hash: 13d6a04ef6678dc61cb6e2d42eb53e69486bd2f52b8e5d778db029ccd4c600b4
yt-dlp is up to date (stable@2023.10.13)
[polskieradio:audition] Extracting URL: https://trojka.polskieradio.pl/audycja/6568
[polskieradio:audition] 6568: Downloading webpage
[download] Downloading playlist: AnagrammarganA
[polskieradio:audition] 6568: Downloading article list page 1
[polskieradio:audition] 6568: Downloading article list page 2
[polskieradio:audition] 6568: Downloading article list page 3
[polskieradio:audition] 6568: Downloading article list page 4
[polskieradio:audition] 6568: Downloading article list page 5
[polskieradio:audition] 6568: Downloading article list page 6
[polskieradio:audition] 6568: Downloading article list page 7
[polskieradio:audition] 6568: Downloading article list page 8
[polskieradio:audition] 6568: Downloading article list page 9
[polskieradio:audition] 6568: Downloading article list page 10
[polskieradio:audition] 6568: Downloading article list page 11
[polskieradio:audition] 6568: Downloading article list page 12
[polskieradio:audition] 6568: Downloading article list page 13
[polskieradio:audition] 6568: Downloading article list page 14
[polskieradio:audition] 6568: Downloading article list page 15
[polskieradio:audition] 6568: Downloading article list page 16
[polskieradio:audition] 6568: Downloading article list page 17
[polskieradio:audition] 6568: Downloading article list page 18
[polskieradio:audition] 6568: Downloading article list page 19
[polskieradio:audition] 6568: Downloading article list page 20
[polskieradio:audition] 6568: Downloading article list page 21
[polskieradio:audition] 6568: Downloading article list page 22
[polskieradio:audition] 6568: Downloading article list page 23
[polskieradio:audition] 6568: Downloading article list page 24
[polskieradio:audition] 6568: Downloading article list page 25
[polskieradio:audition] 6568: Downloading article list page 26
[polskieradio:audition] 6568: Downloading article list page 27
[polskieradio:audition] 6568: Downloading article list page 28
[polskieradio:audition] 6568: Downloading article list page 29
[polskieradio:audition] 6568: Downloading article list page 30
[polskieradio:audition] 6568: Downloading article list page 31
[polskieradio:audition] 6568: Downloading article list page 32
[polskieradio:audition] 6568: Downloading article list page 33
[polskieradio:audition] 6568: Downloading article list page 34
[polskieradio:audition] 6568: Downloading article list page 35
[polskieradio:audition] 6568: Downloading article list page 36
[polskieradio:audition] 6568: Downloading article list page 37
[polskieradio:audition] Playlist AnagrammarganA: Downloading 322 items of 322
[download] Downloading item 1 of 322
[PolskieRadio] Extracting URL: https://trojka.polskieradio.pl/artykul/3252342,AnagrammarganA-1-pazdziernika-godz-0006
[PolskieRadio] 3252342: Downloading webpage
[download] Downloading playlist: AnagrammarganA 1 października godz. 00:06
[PolskieRadio] Playlist AnagrammarganA 1 października godz. 00:06: Downloading 1 items of 1
[download] Downloading item 1 of 1
[debug] Formats sorted by: hasvid, ie_pref, lang, quality, res, fps, hdr:12(7), vcodec:vp9.2(10), channels, acodec, size, br, asr, proto, vext, aext, hasaud, source, id
[debug] Default format spec: best/bestvideo+bestaudio
[info] e73612ee-5031-450c-b6da-896e10578f78: Downloading 1 format(s): 0
[debug] Invoking http downloader on "https://static.prsa.pl/e73612ee-5031-450c-b6da-896e10578f78.file"
[debug] File locking is not supported. Proceeding without locking
[download] Destination: AnagrammarganA 1 października godz. 00_06 [e73612ee-5031-450c-b6da-896e10578f78].mp3
[download] 100% of  211.12MiB in 00:00:19 at 10.86MiB/s
[info] Maximum number of downloads reached, stopping due to --max-downloads
Aborting remaining downloads
```

This same root cause must be fixed before merging.
REVIEW_EOF
