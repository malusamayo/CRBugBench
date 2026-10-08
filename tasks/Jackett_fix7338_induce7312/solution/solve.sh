#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Utils/Extensions.cs`:

This pull request introduces the defect later reported as "[LimeTorrents & SkyTorrents] broken by v0.13.211 for Sonarr & Radarr". The
problem a user observed, and its root cause:

Working for v0.13.201 but not v0.13.211.

Tested in both Docker, with proxy, and fresh Windows sandbox install, without proxy.

Results are found in Jackett, but not in Sonarr (2.0.0.5338) or Radarr (0.2.0.1480).

Torznab Error Detected:
```
System.ArgumentNullException: Value cannot be null. (Parameter 'second')
   at System.Linq.ThrowHelper.ThrowArgumentNullException(ExceptionArgument argument)
   at System.Linq.Enumerable.Intersect[TSource](IEnumerable`1 first, IEnumerable`1 second)
   at Jackett.Common.Indexers.BaseIndexer.<>c__DisplayClass65_0.<FilterResults>b__0(ReleaseInfo result) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/BaseIndexer.cs:line 268
   at System.Linq.Enumerable.WhereListIterator`1.MoveNext()
   at System.Linq.Enumerable.EnumerablePartition`1.MoveNext()
   at System.Linq.Enumerable.SelectIPartitionIterator`2.MoveNext()
   at Jackett.Common.Services.CacheService.GetNewItemCount(IIndexer indexer, IEnumerable`1 releases) in /home/vsts/work/1/s/src/Jackett.Common/Services/CacheService.cs:line 60
   at Jackett.Server.Controllers.ResultsController.Torznab(TorznabRequest request) in /home/vsts/work/1/s/src/Jackett.Server/Controllers/ResultsController.cs:line 430 System.ArgumentNullException: Value cannot be null. (Parameter 'second')
   at System.Linq.ThrowHelper.ThrowArgumentNullException(ExceptionArgument argument)
   at System.Linq.Enumerable.Intersect[TSource](IEnumerable`1 first, IEnumerable`1 second)
   at Jackett.Common.Indexers.BaseIndexer.<>c__DisplayClass65_0.<FilterResults>b__0(ReleaseInfo result) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/BaseIndexer.cs:line 268
   at System.Linq.Enumerable.WhereListIterator`1.MoveNext()
   at System.Linq.Enumerable.EnumerablePartition`1.MoveNext()
   at System.Linq.Enumerable.SelectIPartitionIterator`2.MoveNext()
   at Jackett.Common.Services.CacheService.GetNewItemCount(IIndexer indexer, IEnumerable`1 releases) in /home/vsts/work/1/s/src/Jackett.Common/Services/CacheService.cs:line 60
   at Jackett.Server.Controllers.ResultsController.Torznab(TorznabRequest request) in /home/vsts/work/1/s/src/Jackett.Server/Controllers/ResultsController.cs:line 430
```
Logs below show each indexer being run first in Jackett and then Sonarr (both Docker):
[log - LimeTorrents.txt](https://github.com/Jackett/Jackett/files/4254615/log.-.LimeTorrents.txt)
[log - SkyTorrents.txt](https://github.com/Jackett/Jackett/files/4254616/log.-.SkyTorrents.txt)

This same root cause must be fixed before merging.
REVIEW_EOF
