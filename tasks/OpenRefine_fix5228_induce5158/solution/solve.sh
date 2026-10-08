#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `extensions/wikidata/src/org/openrefine/wikidata/updates/MediaInfoEdit.java`:

This pull request introduces the defect later reported as "File upload to Commons fails with error message 'MediaWiki error while fetching documents to edit [no-such-entity]: Could not find an entity with the ID "Q-...'". The
problem a user observed, and its root cause:

I was doing a fresh small Wikimedia Commons test upload (5 files), and the upload fully fails (after schema building and logging in, the yellow progress box remains stuck at 0%).

Log says the following:
```
16:07:27.482 [           ProjectManager] Saving some modified projects ... (102569ms)
16:07:27.716 [        project_utilities] Saved project '2151753902839' (234ms)
16:09:35.638 [                   refine] GET /command/wikidata/login (127922ms)
16:09:35.655 [                   refine] GET /command/core/get-csrf-token (17ms)
16:09:35.671 [                   refine] POST /command/wikidata/preview-wikibase-schema (16ms)
16:09:40.911 [                   refine] GET /command/core/get-csrf-token (5240ms)
16:09:40.921 [                   refine] POST /command/wikidata/perform-wikibase-edits (10ms)
16:09:40.939 [..mWikibaseEditsOperation] Performing edits (18ms)
16:09:40.939 [..ting.EditBatchProcessor] Requesting documents (0ms)
16:09:41.328 [..ting.EditBatchProcessor] MediaWiki error while fetching documents to edit [no-such-entity]: Could not find an entity with the ID "Q-452493955621971882". (389ms)
16:09:41.329 [..ting.EditBatchProcessor] Retrying in 10000 ms (1ms)
16:09:51.517 [..ting.EditBatchProcessor] MediaWiki error while fetching documents to edit [no-such-entity]: Could not find an entity with the ID "Q-452493955621971882". (10188ms)
16:09:51.517 [..ting.EditBatchProcessor] Retrying in 20000 ms (0ms)
16:10:11.696 [..ting.EditBatchProcessor] MediaWiki error while fetching documents to edit [no-such-entity]: Could not find an entity with the ID "Q-452493955621971882". (20179ms)
16:10:11.696 [..ting.EditBatchProcessor] Retrying in 40000 ms (0ms)
16:10:51.877 [..ting.EditBatchProcessor] MediaWiki error while fetching documents to edit [no-such-entity]: Could not find an entity with the ID "Q-452493955621971882". (40181ms)
16:10:51.878 [..ting.EditBatchProcessor] Retrying in 80000 ms (1ms)
```

### Dataset
It's this project: 
[mini-test-upload-Commons-aug-2022.openrefine.tar.gz](https://github.com/OpenRefine/OpenRefine/files/9433885/mini-test-upload-Commons-aug-2022.openrefine.tar.gz)
and you can [download the files themselves here](https://drive.google.com/drive/folders/1eFMHxBoqh1gEymKktfjvkXNO0sRH-Ytr?usp=sharing) (note that I'm the creator and the photos haven't been published anywhere else yet, so no evidence that you have the right to upload them with a free license; so after a test upload it's best to ask for deletion)

### Current Results
Upload stays at 0%

### Expected Behavior
Upload goes to 100%

### Versions<!--  (please complete the following information)-->
 - Operating System: MacOS 12.5.1
 - Browser Version: Version 104.0.5112.101 (Official Build) (arm64)
 - JRE or JDK Version: n/a?
 - OpenRefine: Version 3.7-SNAPSHOT [4c7e668] and Version 3.7-SNAPSHOT [42eb681]

### Additional context
I was doing this test because two individual Wikimedians reported to me that their upload got stuck after 1 file (i.e. they can only upload one file at the time).

This same root cause must be fixed before merging.
REVIEW_EOF
