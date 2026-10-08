#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/cookies.py`:

This pull request introduces the defect later reported as "[firefox/macOS] Using `--cookies-from-browser firefox:<profile>` throws FileNotFoundError". The
problem a user observed, and its root cause:

### DO NOT REMOVE OR SKIP THE ISSUE TEMPLATE

- [X] I understand that I will be **blocked** if I *intentionally* remove or skip any mandatory\* field

### Checklist

- [X] I'm reporting a bug unrelated to a specific site
- [X] I've verified that I have **updated yt-dlp to nightly or master** ([update instructions](https://github.com/yt-dlp/yt-dlp#update-channels))
- [X] I've checked that all provided URLs are playable in a browser with the same IP and same login details
- [X] I've checked that all URLs and arguments with special characters are [properly quoted or escaped](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#video-url-contains-an-ampersand--and-im-getting-some-strange-output-1-2839-or-v-is-not-recognized-as-an-internal-or-external-command)
- [X] I've searched [known issues](https://github.com/yt-dlp/yt-dlp/issues/3766) and the [bugtracker](https://github.com/yt-dlp/yt-dlp/issues?q=) for similar issues **including closed ones**. DO NOT post duplicates
- [X] I've read the [guidelines for opening an issue](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#opening-an-issue)

### Provide a description that is worded well enough to be understood

I am on macOS, using Firefox Developer Edition.

When using the CLI option `--cookies-from-browser firefox:PROFILE` with Firefox on macOS, yt-dlp throws a `FileNotFoundError`. It appears yt-dlp is looking for profiles in the wrong directory, or not properly parsing `profiles.ini`.

The directory is structured like:

```
$HOME/Library/Application Support/Firefox
  -> profiles.ini
  -> Profiles/
    -> f5vd0duw.default/
    -> lshed6x3.dev-edition-default/
```

<details>

<summary>`profiles.ini` (click to expand)</summary>

```ini
[Profile1]
Name=default
IsRelative=1
Path=Profiles/f5vd0duw.default
Default=1

[Profile0]
Name=dev-edition-default
IsRelative=1
Path=Profiles/lshed6x3.dev-edition-default

[General]
StartWithLastProfile=1
Version=2

[Install1F42C145FFDD4120]
Default=Profiles/lshed6x3.dev-edition-default
Locked=1
```

</details>

However, when specifying `firefox:dev-edition-default` or `firefox:lshed6x3.dev-edition-default`, the following error is thrown (see Complete Verbose Output)

The relevant line:

```
could not find firefox cookies database in /Users/ralph/Library/Application Support/Firefox/lshed6x3.dev-edition-default
```

It appears yt-dlp either isn't parsing `profiles.ini` or is looking in the wrong directory `Firefox/<profile-name>` rather than `Firefox/Profiles/<profile-name>`. When running the command as `--cookies-from-browser firefox`, no error is thrown.


### Provide verbose output that clearly demonstrates the problem

- [X] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [ ] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [X] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
-------------- When running with --cookies-from-browser firefox:dev-edition-default --------------

[debug] Command-line config: ['-vU', '--cookies-from-browser', 'firefox:dev-edition-default', 'https://www.facebook.com/reel/1046027170051234']
[debug] User config "/Users/ralph/.config/yt-dlp/config": ['--no-mtime', '--restrict-filenames', '--trim-filenames', '120']
Extracting cookies from firefox
Traceback (most recent call last):
  File "/opt/homebrew/bin/yt-dlp", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/__init__.py", line 1009, in main
    _exit(*variadic(_real_main(argv)))
                    ^^^^^^^^^^^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/__init__.py", line 963, in _real_main
    with YoutubeDL(ydl_opts) as ydl:
         ^^^^^^^^^^^^^^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/YoutubeDL.py", line 687, in __init__
    self._request_director = self.build_request_director(_REQUEST_HANDLERS.values(), _RH_PREFERENCES)
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/YoutubeDL.py", line 4128, in build_request_director
    cookiejar=self.cookiejar,
              ^^^^^^^^^^^^^^
  File "/opt/homebrew/Cellar/python@3.11/3.11.6_1/Frameworks/Python.framework/Versions/3.11/lib/python3.11/functools.py", line 1001, in __get__
    val = self.func(instance)
          ^^^^^^^^^^^^^^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/YoutubeDL.py", line 4049, in cookiejar
    return load_cookies(
           ^^^^^^^^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/cookies.py", line 91, in load_cookies
    extract_cookies_from_browser(browser_name, profile, YDLLogger(ydl), keyring=keyring, container=container))
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/cookies.py", line 108, in extract_cookies_from_browser
    return _extract_firefox_cookies(profile, container, logger)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/opt/homebrew/lib/python3.11/site-packages/yt_dlp/cookies.py", line 133, in _extract_firefox_cookies
    raise FileNotFoundError(f'could not find firefox cookies database in {search_root}')
FileNotFoundError: could not find firefox cookies database in /Users/ralph/Library/Application Support/Firefox/dev-edition-default


-------------- When running with --cookies-from-browser firefox --------------


[debug] Command-line config: ['-vU', '--cookies-from-browser', 'firefox', 'https://www.facebook.com/reel/1046027170051234']
[debug] User config "/Users/ralph/.config/yt-dlp/config": ['--no-mtime', '--restrict-filenames', '--trim-filenames', '120']
Extracting cookies from firefox
[debug] Extracting cookies from: "/Users/ralph/Library/Application Support/Firefox/Profiles/lshed6x3.dev-edition-default/cookies.sqlite"
Extracted 490 cookies from firefox
[debug] Encodings: locale UTF-8, fs utf-8, pref UTF-8, out utf-8 (No ANSI), error utf-8 (No ANSI), screen utf-8 (No ANSI)
[debug] yt-dlp version stable@2023.12.30 from yt-dlp/yt-dlp [f10589e34] (pip)
[debug] Python 3.11.6 (CPython arm64 64bit) - macOS-14.2.1-arm64-arm-64bit (OpenSSL 3.2.0 23 Nov 2023)
[debug] exe versions: none
[debug] Optional libraries: Cryptodome-3.19.1, brotli-1.1.0, certifi-2023.11.17, mutagen-1.47.0, requests-2.31.0, sqlite3-3.44.2, urllib3-2.1.0, websockets-12.0
[debug] Proxy map: {}
[debug] Request Handlers: urllib, requests, websockets
[debug] Loaded 1798 extractors
[debug] Fetching release info: https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest
Latest version: stable@2023.12.30 from yt-dlp/yt-dlp
yt-dlp is up to date (stable@2023.12.30 from yt-dlp/yt-dlp)
[facebook:reel] Extracting URL: https://www.facebook.com/reel/1046027170051234
[facebook] Extracting URL: https://m.facebook.com/watch/?v=1046027170051234&_rdr
[facebook] 1046027170051234: Downloading webpage
[debug] Formats sorted by: hasvid, ie_pref, lang, quality, res, fps, hdr:12(7), vcodec:vp9.2(10), channels, acodec, size, br, asr, proto, vext, aext, hasaud, source, id
[debug] Default format spec: best/bestvideo+bestaudio
[info] 1046027170051234: Downloading 1 format(s): hd
[debug] Invoking http downloader on "https://video-bos5-1.xx.fbcdn.net/o1/v/t2/f1/m69/GEXFThgOM2wZ_FYGADrxo-4ZGb0xbmdjAAAF.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6Im9lcF9oZCJ9&_nc_ht=video-bos5-1.xx.fbcdn.net&_nc_cat=105&strext=1&vs=708083ce63875aab&_nc_vs=HBksFQIYOnBhc3N0aHJvdWdoX2V2ZXJzdG9yZS9HRVhGVGhnT00yd1pfRllHQURyeG8tNFpHYjB4Ym1kakFBQUYVAALIAQAVAhg6cGFzc3Rocm91Z2hfZXZlcnN0b3JlL0dCUWVSeGg2c0dQX3psNEdBS3prTkJGM2ZZaFhidjRHQUFBRhUCAsgBAEsHiBJwcm9ncmVzc2l2ZV9yZWNpcGUBMQ1zdWJzYW1wbGVfZnBzABB2bWFmX2VuYWJsZV9uc3ViACBtZWFzdXJlX29yaWdpbmFsX3Jlc29sdXRpb25fc3NpbQAoY2

This same root cause must be fixed before merging.
REVIEW_EOF
