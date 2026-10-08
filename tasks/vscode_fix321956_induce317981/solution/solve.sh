#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/vs/platform/agentHost/common/state/agentSubscription.ts`:

This pull request introduces the defect later reported as "[Error] unhandlederror-Authentication is required to use Copilot". The
problem a user observed, and its root cause:

## Error Message
````
unhandlederror-Authentication is required to use Copilot
````

## Stack Trace
&nbsp;&nbsp;&nbsp;&nbsp;at he._ensureClient ([./src/vs/platform/agentHost/node/copilot/copilotAgent.ts:570:0](https://github.com/microsoft/vscode/blob/226cd5d573076e1d3b260d21409538fbc67cb059/src/vs/platform/agentHost/node/copilot/copilotAgent.ts#L570))  
&nbsp;&nbsp;&nbsp;&nbsp;at he.createSession ([./src/vs/platform/agentHost/node/copilot/copilotAgent.ts:955:0](https://github.com/microsoft/vscode/blob/226cd5d573076e1d3b260d21409538fbc67cb059/src/vs/platform/agentHost/node/copilot/copilotAgent.ts#L955))  
&nbsp;&nbsp;&nbsp;&nbsp;at async Dp.createSession ([./src/vs/platform/agentHost/node/agentService.ts:543:0](https://github.com/microsoft/vscode/blob/226cd5d573076e1d3b260d21409538fbc67cb059/src/vs/platform/agentHost/node/agentService.ts#L543))

<details>
<summary>Raw Stack Trace (minified)</summary>

````
Error: Authentication is required to use Copilot     at he._ensureClient (out/vs/platform/agentHost/node/agentHostMain.js:612:5858)     at he.createSession (out/vs/platform/agentHost/node/agentHostMain.js:612:12538)     at async Promise.all (index 1)     at async Dp.createSession (out/vs/platform/agentHost/node/agentHostMain.js:501:10709)
````

</details>

## Details
| Property | Value |
| --- | --- |
| Bucket ID | [`d15901c0-1e96-f924-1c06-9c31a53e0700`](https://errors.code.visualstudio.com/bucket/d15901c0-1e96-f924-1c06-9c31a53e0700?product=VSCode&extension=core&commit=226cd5d573076e1d3b260d21409538fbc67cb059) |
| Version | 1.126.0-insider |
| Commit | [`226cd5d5`](https://insiders.vscode.dev/github/microsoft/vscode/tree/226cd5d573076e1d3b260d21409538fbc67cb059) |
| Last Seen | Wed Jun 17 2026 22:21:45 GMT+0000 (Coordinated Universal Time) |
| Platforms | Windows, Mac |
| Product | VSCode |

---
*This issue was automatically created from the VS Code Errors Dashboard*

This same root cause must be fixed before merging.
REVIEW_EOF
