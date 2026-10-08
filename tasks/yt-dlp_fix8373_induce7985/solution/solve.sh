#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `yt_dlp/YoutubeDL.py`:

This pull request introduces the defect later reported as "2023.10.13 creating empty folders". The
problem a user observed, and its root cause:

### DO NOT REMOVE OR SKIP THE ISSUE TEMPLATE

- [X] I understand that I will be **blocked** if I *intentionally* remove or skip any mandatory\* field

### Checklist

- [X] I'm reporting a bug unrelated to a specific site
- [X] I've verified that I'm running yt-dlp version **2023.10.13** ([update instructions](https://github.com/yt-dlp/yt-dlp#update)) or later (specify commit)
- [X] I've checked that all provided URLs are playable in a browser with the same IP and same login details
- [X] I've checked that all URLs and arguments with special characters are [properly quoted or escaped](https://github.com/yt-dlp/yt-dlp/wiki/FAQ#video-url-contains-an-ampersand--and-im-getting-some-strange-output-1-2839-or-v-is-not-recognized-as-an-internal-or-external-command)
- [X] I've searched [known issues](https://github.com/yt-dlp/yt-dlp/issues/3766) and the [bugtracker](https://github.com/yt-dlp/yt-dlp/issues?q=) for similar issues **including closed ones**. DO NOT post duplicates
- [X] I've read the [guidelines for opening an issue](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#opening-an-issue)

### Provide a description that is worded well enough to be understood

I recently upgraded to the latest version and I've found that it is creating empty folders. The previous release did not do this.

I've truncated the log as I don't think having 137 channels of output is useful, especially when one is Big Clive.

### Provide verbose output that clearly demonstrates the problem

- [X] Run **your** yt-dlp command with **-vU** flag added (`yt-dlp -vU <your command line>`)
- [ ] If using API, add `'verbose': True` to `YoutubeDL` params instead
- [X] Copy the WHOLE output (starting with `[debug] Command-line config`) and insert it below

### Complete Verbose Output

```shell
[debug] Command-line config: ['--download-archive', '/home/kevin/.config/ytget/archive', '--batch-file', '/home/kevin/.config/ytget/config', '--output', '~/podcasts/video/youtube/%(uploader)s/%(upload_date)s %(title)s.%(ext)s', '--cookies-from-browser', 'firefox', '-vU']
[debug] User config "/home/kevin/.config/yt-dlp.conf": ['--output', '%(upload_date)s %(title)s.%(ext)s', '--ignore-errors', '--sub-langs', 'en', '--write-subs', '--merge-output-format', 'mp4', '--format', 'best[height<=720],best']
[debug] Batch file urls: ['https://www.twitch.tv/fasterthanlime/videos', 'https://www.twitch.tv/princessxen/videos', 'https://www.twitch.tv/thekuto/videos', 'https://www.twitch.tv/xssfox/videos', 'https://www.youtube.com/@11foot8plus8/videos', 'https://www.youtube.com/@Airforceproud95/videos', 'https://www.youtube.com/@AlphaBravoV/videos', 'https://www.youtube.com/@BackyardBirdsofAustralia/', 'https://www.youtube.com/@BadObsessionMotorsport/videos', 'https://www.youtube.com/@BeauMiles/videos', 'https://www.youtube.com/@BeckyStern/videos', 'https://www.youtube.com/@Berd/videos', 'https://www.youtube.com/@Bigclivedotcom/videos', 'https://www.youtube.com/@Blondihacks/videos', 'https://www.youtube.com/@BosnianApeSociety/videos', 'https://www.youtube.com/@Cade_Media/videos', 'https://www.youtube.com/@Cadey', 'https://www.youtube.com/@Ciband/videos', 'https://www.youtube.com/@Clickspring/videos', 'https://www.youtube.com/@ClickspringClips/videos', 'https://www.youtube.com/@ConSeanWay/videos', 'https://www.youtube.com/@CraftComputing/videos', 'https://www.youtube.com/@CricketthePigeon/videos', 'https://www.youtube.com/@DavidMcLuckie/videos', 'https://www.youtube.com/@DemilyPyro/videos', 'https://www.youtube.com/@DeviantOllam/videos', 'https://www.youtube.com/@DevineLuLinvega/videos', 'https://www.youtube.com/@DropTableAdventures/', 'https://www.youtube.com/@Electroboom/videos', 'https://www.youtube.com/@ExplosionsandFire/videos', 'https://www.youtube.com/@ExtractionsandIre/videos', 'https://www.youtube.com/@FelixColgrave/videos', 'https://www.youtube.com/@FiberNinja/videos', 'https://www.youtube.com/@GLovesTrains/videos', 'https://www.youtube.com/@GarbageTime420/videos', 'https://www.youtube.com/@GeistPunkWorkShop/videos', 'https://www.youtube.com/@HackaweekTV/videos', 'https://www.youtube.com/@HillPeopleGear/videos', 'https://www.youtube.com/@HundredRabbits/videos', 'https://www.youtube.com/@IHatchetJack/videos', 'https://www.youtube.com/@IronangelForge/videos', 'https://www.youtube.com/@Jer_Schmidt/videos', 'https://www.youtube.com/@JunYoshizuki/videos', 'https://www.youtube.com/@JunsKitchen/videos', 'https://www.youtube.com/@KennethFinnegan/videos', 'https://www.youtube.com/@KinCony', 'https://www.youtube.com/@KymNonStop/videos', 'https://www.youtube.com/@Lefie/videos', 'https://www.youtube.com/@Mehditation/videos', 'https://www.youtube.com/@MichaelReeves/videos', 'https://www.youtube.com/@MrMichaelSpicer', 'https://www.youtube.com/@NODEtv/videos', 'https://www.youtube.com/@Naomi-Wu/videos', 'https://www.youtube.com/@Neytirix/videos', 'https://www.youtube.com/@NileBlue/videos', 'https://www.youtube.com/@NileRed/videos', 'https://www.youtube.com/@NoBoilerplate/videos', 'https://www.youtube.com/@NullByteWHT/videos', 'https://www.youtube.com/@OH8STN/videos', 'https://www.youtube.com/@OM0ET/videos', 'https://www.youtube.com/@Photonvids/videos', 'https://www.youtube.com/@RJTheBikeGuy/videos', 'https://www.youtube.com/@SamuraiMatcha/videos', 'https://www.youtube.com/@SovietWomble/videos', 'https://www.youtube.com/@TastyPC/videos', 'https://www.youtube.com/@TechnologyConnections/videos', 'https://www.youtube.com/@TechnologyConnextras/videos', 'https://www.youtube.com/@Telepurte/videos', 'https://www.youtube.com/@TerminalMontage/videos', 'https://www.youtube.com/@TheCryptoNaturalist/videos', 'https://www.youtube.com/@TomScottGo/videos', 'https://www.youtube.com/@TravelsWithGeordie/videos', 'https://www.youtube.com/@TripleAughtDesign000/videos', 'https://www.youtube.com/@UnderDunnOfficial/videos', 'https://www.youtube.com/@UnusualVideos', 'https://www.youtube.com/@UrbanAgoge7598/videos', 'https://www.youtube.com/@Videodrome2503/videos', 'https://www.youtube.com/@ZackFreedman/videos', 'https://www.youtube.com/@agingwheels/videos', 'https://www.youtube.com/@bleeptrack/videos', 'https://www.youtube.com/@cgpgrey/videos', 'https://www.youtube.com/@dreamsofcode/videos', 'https://www.youtube.com/@electronupdate/videos', 'https://www.youtube.com/@fasterthanlime/videos', 'https://www.youtube.com/@foni7/videos/videos', 'https://www.youtube.com/@glasgowcycles/videos', 'https://www.youtube.com/@greatscottlab/videos', 'https://www.youtube.com/@hak5/videos', 'https://www.youtube.com/@hamesjoffmann/videos', 'https://www.youtube.com/@jafromobile/videos', 'https://www.youtube.com/@jeriellsworth/videos', 'https://www.youtube.com/@kekeflipnote/videos', 'https://www.youtube.com/@ktzsystems/videos', 'https://www.youtube.com/@laurakampf/videos', 'https://www.youtube.com/@linguoermechanic/videos', 'https://www.youtube.com/@lockpickinglawyer/videos', 'https://www.youtube.com/@m0mcx/videos', 'https://www.youtube.com/@mark_loveless/videos', 'https://www.youtube.com/@markjessop8536/videos', 'https://www.youtube.com/@microship/videos', 'https://www.youtube.com/@mikeselectricstuff/videos', 'https://www.youtube.com/@mindy_cycling/videos', 'https://www.youtube.com/@onecyclistinlisbon/videos', 'https://www.youtube.com/@oxidecomputercompany4540/videos', 'https://www.youtube.com/@peacefulcuisine/videos', 'https://www.youtube.com/@r4nger5tube/videos', 'https://www.youtube.com/@ryoyatakashima/videos', 'https://www.youtube.com/@saveitforparts/videos', 'https://www.youtube.com/@scanlime/videos', 'https://www.youtube.com/@scanlimeinprogress/videos', 'https://www.youtube.com/@shiey/videos', 'https://www.youtube.com/@shugemery/videos', 'https://www.youtube.com/@simonegiertz/videos', 'https://www.youtube.com/@socketwench/videos', 'https://www.youtube.com/@synologyinc/videos', 'https://www.youtube.com/@theCodyReeder/videos', 'https://www.youtube.com/@theserialport/videos', 'https://www.youtube.com/@thomasnagy/videos', 'https://www.youtube.com/

This same root cause must be fixed before merging.
REVIEW_EOF
