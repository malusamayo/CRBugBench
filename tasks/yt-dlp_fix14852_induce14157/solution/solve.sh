#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/extractor/youtube/_video.py`:

This pull request introduces the defect later reported as "[youtube] `youtube:formats=dashy` now causes 403 after the deno update". The
problem a user observed, and its root cause:

### Checklist

- [x] I'm reporting that yt-dlp is broken on a **supported** site
- [x] I've verified that I have **updated yt-dlp to nightly or master** ([update instructions](https://github.com/yt-dlp/yt-dlp#update-channels))
- [x] I've checked that all provided URLs are playable in a browser with the same IP and same login details
- [x] I've checked that all URLs and arguments with special characters are [properly quoted or escaped](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#video-url-contains-an-ampersand--and-im-getting-some-strange-output-1-2839-or-v-is-not-recognized-as-an-internal-or-external-command)
- [x] I've searched [known issues](https://github.com/yt-dlp/yt-dlp/issues/3766), [the FAQ](https://github.com/yt-dlp/yt-dlp/wiki/FAQ), and the [bugtracker](https://github.com/yt-dlp/yt-dlp/issues?q=is%3Aissue%20-label%3Aspam%20%20) for similar issues **including closed ones**. DO NOT post duplicates
- [x] I've read the [policy against AI/LLM contributions](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#automated-contributions-ai--llm-policy) and understand I may be blocked from the repository if it is violated
- [x] I've read about [sharing account credentials](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#are-you-willing-to-share-account-details-if-needed) and I'm willing to share it if required

### Region

Global

### Provide a description that is worded well enough to be understood

With the newest `master`, it now gives 403 error for dashy formats.

### Provide verbose output that clearly demonstrates the problem

- [x] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [x] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [x] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
[debug] Command-line config: ['https://www.youtube.com/watch?v=xo1arhanUi0', '--ignore-config', '-vU', '-f', '137+140', '--extractor-arg', 'youtube:formats=dashy']
[debug] Encodings: locale cp1252, fs utf-8, pref cp1252, out utf-8, error utf-8, screen utf-8
[debug] yt-dlp version master@2025.10.31.221350 from yt-dlp/yt-dlp-master-builds [6224a3898] (win_exe)
[debug] Python 3.10.11 (CPython AMD64 64bit) - Windows-10-10.0.19045-SP0 (OpenSSL 1.1.1t  7 Feb 2023)
[debug] exe versions: ffmpeg 7.0-full_build-www.gyan.dev (setts), ffprobe 7.0-full_build-www.gyan.dev, phantomjs 2.1.1, rtmpdump 2.3
[debug] Optional libraries: Cryptodome-3.23.0, brotli-1.1.0, certifi-2025.10.05, curl_cffi-0.13.0, mutagen-1.47.0, requests-2.32.5, sqlite3-3.40.1, urllib3-2.5.0, websockets-15.0.1, yt_dlp_ejs-0.3.0
[debug] JS runtimes: deno-2.5.1
[debug] Proxy map: {'http': 'http://127.0.0.1:7890', 'https': 'http://127.0.0.1:7890', 'ftp': 'http://127.0.0.1:7890'}
[debug] Request Handlers: urllib, requests, websockets, curl_cffi
[debug] Extractor Plugins: RadikoLiveIE, RadikoPersonIE, RadikoSearchIE, RadikoShareIE, RadikoStationButtonIE, RadikoTimeFreeIE
[debug] Plugin directories: C:\Users\ikena\AppData\Roaming\yt-dlp\plugins\yt_dlp_rajiko-1.7-py3-none-any.whl\yt_dlp_plugins
[debug] Loaded 1847 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp-master-builds/releases/latest
Latest version: master@2025.10.31.221350 from yt-dlp/yt-dlp-master-builds
yt-dlp is up to date (master@2025.10.31.221350 from yt-dlp/yt-dlp-master-builds)
[debug] [youtube] [pot] PO Token Providers: none
[debug] [youtube] [pot] PO Token Cache Providers: memory
[debug] [youtube] [pot] PO Token Cache Spec Providers: webpo
[debug] [youtube] [jsc] JS Challenge Providers: bun (unavailable), deno, node (unavailable), quickjs (unavailable)
[youtube] Extracting URL: https://www.youtube.com/watch?v=xo1arhanUi0
[youtube] xo1arhanUi0: Downloading webpage
[youtube] xo1arhanUi0: Downloading tv client config
[youtube] xo1arhanUi0: Downloading player c6d7bdc9-main
[youtube] xo1arhanUi0: Downloading tv player API JSON
[youtube] xo1arhanUi0: Downloading android sdkless player API JSON
[youtube] [jsc:deno] Solving JS challenges using deno
[debug] [youtube] [jsc:deno] Using challenge solver lib script v0.3.0 (source: python package, variant: minified)
[debug] [youtube] [jsc:deno] Using challenge solver core script v0.3.0 (source: python package, variant: minified)
[debug] [youtube] [jsc:deno] Running deno: deno run --no-prompt --no-remote --no-lock --node-modules-dir=none --no-config --no-npm --cached-only -
[debug] Sort order given by extractor: quality, res, fps, hdr:12, source, vcodec, channels, acodec, lang, proto
[debug] Formats sorted by: hasvid, ie_pref, quality, res, fps, hdr:12(7), source, vcodec, channels, acodec, lang, proto, size, br, asr, vext, aext, hasaud, id
[info] xo1arhanUi0: Downloading 1 format(s): 137+140
[debug] Invoking dashsegments downloader on "https://rr2---sn-i3co-i3bes.googlevideo.com/videoplayback?expire=1761989380&ei=pH4Fac6iDtuBvcAP7qXSwAw&ip=138.19.37.159&id=o-AKbPE2XBu6kFz4SRugauhy37G-k39fOF6tiGw_0_ti8F&itag=137&aitags=133%2C134%2C135%2C136%2C137%2C160%2C242%2C243%2C244%2C247%2C248%2C278%2C394%2C395%2C396%2C397%2C398%2C399&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761967780%2C&mh=F0&mm=31%2C29&mn=sn-i3co-i3bes%2Csn-i3b7kn6s&ms=au%2Crdu&mv=m&mvi=2&pcm2cms=yes&pl=21&rms=au%2Cau&initcwndbps=4151250&bui=AdEuB5TGx2bwN0eSnuit3NNWLhcuaAKgHkDGjbm5Obj3_0NSm2lXbKjTX7xhxLhSCKFOHjElJPsinO_-&vprv=1&svpuc=1&mime=video%2Fmp4&ns=wGVT5mNR8EQsW-jq_JdvDzMQ&rqh=1&gir=yes&clen=159738328&dur=504.704&lmt=1761802663061826&mt=1761967249&fvip=4&keepalive=yes&lmw=1&fexp=51557447%2C51565115%2C51565681%2C51580970&c=TVHTML5&sefc=1&txp=6319224&n=K1zaEWYbO5YxCg&sparams=expire%2Cei%2Cip%2Cid%2Caitags%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhAPVJQWIgRzueh828r9qG2bHWldhpz1uTzv4pcPnVSyH0AiAFQBWTRzLTEbZnRQqnVRcsZ34ITiErS5zYi2iLJqBoRg%3D%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIgV5jF0CnACjMgD3zHbl5cJL1tGlCjosVkftYsGObWdeYCIQCzfSeyDkafN1C4giOpnoezmyNweDYJQyYIIFfSSLO-bQ%3D%3D"
[download] Sleeping 5.00 seconds as required by the site...
[dashsegments] Total fragments: 16
[download] Destination: FRUITS ZIPPER、ハロウィン明けから“長〜いクリスマスイブ”突入！？サンタさんにお願いしたいことも発表　「NEW OKASHI PROJECT」新WEBCM [xo1arhanUi0].f137.mp4
[debug] File locking is not supported. Proceeding without locking
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (1/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (2/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (3/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (4/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (5/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (6/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (7/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (8/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (9/10)...
[download] Got error: HTTP Error 403: Forbidden. Retrying fragment 1 (10/10)...
[download] Got error: HTTP Error 403: Forbidden. Giving up after 10 retries
  File "__main__.py", line 17, in <module>
  File "yt_dlp\__init__.py", line 1079, in main
  File "yt_dlp\__init__.py", line 1070, in _real_main
  File "yt_dlp\YoutubeDL.py", line 3662, in download
  File "yt_dlp\YoutubeDL.py", line 3635, in wrapper
  File "yt_dlp\YoutubeDL.py", line 1685, in extract_info
  File "yt_dlp\YoutubeDL.py", line 1696, in wrapper
  File "yt_dlp\YoutubeDL.py", line 1852, in __extract_info
  File "yt_dlp\YoutubeDL.py", line 1911, in process_ie_result
  File "yt_dlp\YoutubeDL.py", line 3089, in process_video_result
  File "yt_dlp\YoutubeDL.py", line 189, in wrapper
  File "yt_dlp\YoutubeDL.py", line 3518, in process_info
  File "yt_dlp\YoutubeDL.py", line 3278, in dl
  File "yt_dlp\downloader\c

This same root cause must be fixed before merging.
REVIEW_EOF
