#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `BTCPayServer/Security/CookieAuthorizationHandler.cs` (around line 154): Just checked the filter execution code and this will not work:
```
foreach (IPluginHookFilter pluginHookFilter in filters)
            {
                try
                {
                    args = await pluginHookFilter.Execute(args);
                }
                catch (Exception e)
                {
                    _logger.LogError(e, $"Filter on hook {hook} failed");
                }
            }
```
the filter will need to return the same type or else if another plugin tries to use it  it will fail
REVIEW_EOF
