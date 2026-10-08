#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `yt_dlp/extractor/tbsjp.py` (around line 151): `if url:` is problematic because `url` is already the input URL, so if the first entry's  `content_type` is unrecognized, the extractor will yield a recursively nested playlist. And `url` will never be falsy if `content_type` is unrecognized, because it will still have its value from the last iteration.

Instead we can append to `entries` immediately and avoid reused/unbound vars

(and in the traversal we can filter for dicts with a truthy `content_id` value)
```suggestion
        entries = []
        for entry in traverse_obj(playlist, ('catalogs', 'value', lambda _, v: v['content_id'])):
            # it's likely possible to get most/all of the metadata from the playlist page json instead
            content_id = entry['content_id']
            content_type = entry.get('content_type')
            if content_type == 'tv_show':
                entries.append(self.url_result(
                    f'https://cu.tbs.co.jp/program/{content_id}', TBSJPProgramIE, content_id))
            elif content_type == 'tv_episode':
                entries.append(self.url_result(
                    f'https://cu.tbs.co.jp/episode/{content_id}', TBSJPEpisodeIE, content_id))
            else:
                self.report_warning(f'Skipping "{content_id}" with unsupported content_type "{content_type}"')
```
REVIEW_EOF
