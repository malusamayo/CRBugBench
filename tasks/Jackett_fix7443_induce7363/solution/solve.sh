#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Indexers/IPTorrents.cs`:

This pull request introduces the defect later reported as "Sonarr - Object reference not set to an instance of an object". The
problem a user observed, and its root cause:

### Environment

**OS**: Windows Server 2019 - 1809

**.Net Version**: .NET Framework 4.7

**Jackett Version**: 0.13.378.0


### Description

Sonarr is getting a `Object reference not set to an instance of an object.` error when searching for content from IPTorrents.
Radarr is working when searching from the same Indexer. The current setup has been working for months until just recently. No changes were made.

### Logged Error Messages

```
[v3.0.3.703] NzbDrone.Core.Indexers.Torznab.TorznabException: Torznab error detected: Jackett.Common.IndexerException: Exception (iptorrents): Object reference not set to an instance of an object.
 ---> System.Exception: Parse error
 ---> System.NullReferenceException: Object reference not set to an instance of an object.
   at Jackett.Common.Indexers.IPTorrents.PerformQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\IPTorrents.cs:line 202
   --- End of inner exception stack trace ---
   at Jackett.Common.Indexers.BaseWebIndexer.OnParseError(String results, Exception ex) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 830
   at Jackett.Common.Indexers.IPTorrents.PerformQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\IPTorrents.cs:line 245
   at Jackett.Common.Indexers.BaseIndexer.ResultsForQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 345
   --- End of inner exception stack trace ---
   at Jackett.Common.Indexers.BaseIndexer.ResultsForQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 345
   at Jackett.Common.Indexers.BaseWebIndexer.ResultsForQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 807
   at Jackett.Server.Controllers.ResultsController.Torznab(TorznabRequest request) in d:\a\1\s\src\Jackett.Server\Controllers\ResultsController.cs:line 430
   at NzbDrone.Core.Indexers.Torznab.TorznabRssParser.PreProcess(IndexerResponse indexerResponse) in M:\BuildAgent\work\63739567f01dbcc2\src\NzbDrone.Core\Indexers\Torznab\TorznabRssParser.cs:line 42
   at NzbDrone.Core.Indexers.RssParser.ParseResponse(IndexerResponse indexerResponse) in M:\BuildAgent\work\63739567f01dbcc2\src\NzbDrone.Core\Indexers\RssParser.cs:line 55
   at NzbDrone.Core.Indexers.HttpIndexerBase`1.FetchPage(IndexerRequest request, IParseIndexerResponse parser) in M:\BuildAgent\work\63739567f01dbcc2\src\NzbDrone.Core\Indexers\HttpIndexerBase.cs:line 308
   at NzbDrone.Core.Indexers.HttpIndexerBase`1.FetchReleases(Func`2 pageableRequestChainSelector, Boolean isRecent) in M:\BuildAgent\work\63739567f01dbcc2\src\NzbDrone.Core\Indexers\HttpIndexerBase.cs:line 143


```

This same root cause must be fixed before merging.
REVIEW_EOF
