#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `components/script/dom/bindings/typedarrays.rs`:

This pull request introduces the defect later reported as "Fix rooting of external array buffer pointer". The
problem a user observed, and its root cause:

I think there is one thing that we, and the previous code, missed, which is immediate rooting of [the pointer returned by `NewExternalArrayBuffer` ](https://github.com/servo/servo/pull/31202/files#diff-8f10f5d3caee3cce7befe080a3333a5f9402a651884287734f41e786e4323181R186). 

GC can happen, even though it appears like it couldn't, for example if it occurs in response to a timer in another SpiderMonkey GC thread, see second part of https://github.com/mozilla-spidermonkey/spidermonkey-embedding-examples/blob/esr78/docs/GC%20Rooting%20Guide.md#performance-tweaking

See gecko: https://searchfox.org/mozilla-central/rev/9bb5d5f55da6cc7163dd93825c25609b769822f9/dom/webgpu/Buffer.cpp#291

We should fix this like: `rooted!(in(cx) let object = NewExternalArrayBuffer(..))`.

This same root cause must be fixed before merging.
REVIEW_EOF
