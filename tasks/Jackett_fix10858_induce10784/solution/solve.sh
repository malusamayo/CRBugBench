#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Indexers/SubsPlease.cs`:

This pull request introduces the defect later reported as "subsplease: object reference not set to an instance of an object". The
problem a user observed, and its root cause:

Related  #10784
@CodeMonkey626 could yo take a look?

Size is always 0. I know the site doesn't provide this info but some tools like Sonarr refuses to download when the size is 0.
Could you add fixed sizes?
480p => 350MB
720p => 700MB
1080p => 1300MB

The error is with these queries
"query": "720p"
"query": "1234abcdf"
```
Jackett.Common.IndexerException: Exception (subsplease): Object reference not set to an instance of an object.
 ---> System.NullReferenceException: Object reference not set to an instance of an object.
   at Jackett.Common.Indexers.SubsPlease.ParseApiResults(String json) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/SubsPlease.cs:line 141
   at Jackett.Common.Indexers.SubsPlease.PerformSearch(TorznabQuery query) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/SubsPlease.cs:line 85
   at Jackett.Common.Indexers.SubsPlease.PerformQuery(TorznabQuery query) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/SubsPlease.cs:line 65
   at Jackett.Common.Indexers.BaseIndexer.ResultsForQuery(TorznabQuery query, Boolean isMetaIndexer) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/BaseIndexer.cs:line 390
   --- End of inner exception stack trace ---
   at Jackett.Common.Indexers.BaseIndexer.ResultsForQuery(TorznabQuery query, Boolean isMetaIndexer) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/BaseIndexer.cs:line 390
   at Jackett.Common.Indexers.BaseWebIndexer.ResultsForQuery(TorznabQuery query, Boolean isMetaIndexer) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/BaseIndexer.cs:line 659
   at Jackett.Server.Controllers.ResultsController.Results(ApiSearch requestt) in /home/vsts/work/1/s/src/Jackett.Server/Controllers/ResultsController.cs:line 223
```

This same root cause must be fixed before merging.
REVIEW_EOF
