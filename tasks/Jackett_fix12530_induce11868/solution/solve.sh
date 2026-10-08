#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Indexers/Abstract/GazelleTracker.cs`:

This pull request introduces the defect later reported as "Orpheus download problem". The
problem a user observed, and its root cause:

### Have you checked our Troubleshooting page for your issue?

- [X] I have checked the Troubleshooting page

### Is there already an issue for your problem?

- [X] I have checked older issues, open and closed

### Have you read our Contributing Guidelines?

- [X] I have read the Contributing Guidelines

### Environment

```markdown
Using HTTP Client: HttpWebClient2
Using FlareSolverr: No
Using proxy: Disabled
App config/log directory: /config/Jackett
ThreadPool MaxThreads: 32767 workerThreads, 1000 completionPortThreads
Running in Docker: Yes (image build: v0.19.100-ls48)
File /etc/issue: Ubuntu 18.04.6 LTS \n \l
Jackett variant: CoreLinuxAmdx64
OS version: Unix 4.19.0.17 (64bit OS) (64bit process)
Environment version: 5.0.11 (/app/Jackett/)
Starting Jackett v0.19.100
```


### Description

Orpheus Indexer (token use is off) : Connecting to indexer is working, searching for orpehus torrent files working, downloading file within UI or by a torrent client or lidarr NOT working, downloading the same file on orpheus website is working, on other tracker all works fine @ jackett. 

Error when try to download torrent file in jackett UI: Website not found, HTTP ERROR 404 (the used API code is of course correct)

It has happened since around two days. I have nothing changed (but its a seedbox, maybe the provider ultra cc).

Thanks for checking.

### Logged Error Messages

<html>
<body>
<!--StartFragment-->

2021-11-08 14:18:39 | Error | Error downloading. indexer: orpheus path: https://orpheus.network/ajax.php?action=download&usetoken=0&id=1712756 System.Exception: BencodeParser failed  ---> BencodeNET.Exceptions.InvalidBencodeException`1[BencodeNET.Objects.IBObject]: Failed to parse IBObject. Invalid beginning character of object. Found '{' at position 0. Valid characters are: 0-9, 'i', 'l' and 'd'    at BencodeNET.Parsing.BencodeParser.Parse(BencodeReader reader)    at BencodeNET.Parsing.BencodeParserExtensions.Parse(IBencodeParser parser, Stream stream)    at BencodeNET.Parsing.BencodeParserExtensions.Parse(IBencodeParser parser, Byte[] bytes)    at Jackett.Server.Controllers.DownloadController.Download(String indexerID, String path, String jackett_apikey, String file) in /home/vsts/work/1/s/src/Jackett.Server/Controllers/DownloadController.cs:line 78    --- End of inner exception stack trace ---    at Jackett.Server.Controllers.DownloadController.Download(String indexerID, String path, String jackett_apikey, String file) in /home/vsts/work/1/s/src/Jackett.Server/Controllers/DownloadController.cs:line 85
-- | -- | --
2021-11-08 14:18:39 | Error | {"status":"failure","error":"You cannot use tokens here (leeching disabled or already freeleech).","response":[],"info":{"source":"Orpheus","version":1}}

<!--EndFragment-->
</body>
</html>

### Screenshots

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
