#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/@n8n/nodes-langchain/nodes/mcp/McpClientTool/McpClientTool.node.ts`:

This pull request introduces the defect later reported as "MCP tool calls are failing due to new toolCallId, previous n8n worfklows won't run on update to most recent version!". The
problem a user observed, and its root cause:

<!-- Please follow the template below. Skip the questions that are not relevant to you. -->

## Describe the problem/error/question
MCP tool calls are failing due to new toolCallId, previous n8n worfklows won't run on update to most recent version!

## What is the error message (if any)?
In one workflow I have this error:
[
{
"response": 
[
{
"type": 
"text",
"text": 
"Error calling tool 'my_tool': 1 validation error for call[my_tool]\ntoolCallId\n  Unexpected keyword argument [type=unexpected_keyword_argument, input_value='toolu_015kA1pdA84pTN4dfAkQ1XEg', input_type=str]\n    For further information visit https://errors.pydantic.dev/2.11/v/unexpected_keyword_argument"
}
]
}
]


In another workflow, my agent just shows its running but no LLM or tools are called. 

## Please share your workflow/screenshots/recording

<img width="268" height="344" alt="Image" src="https://github.com/user-attachments/assets/34c40f90-c962-4d98-b9f4-ab3f0fd5b7c3" />

```
(Select the nodes on your canvas and use the keyboard shortcuts CMD+C/CTRL+C and CMD+V/CTRL+V to copy and paste the workflow.)
⚠️ WARNING ⚠️ If you have sensitive data in your workflow (like API keys), please remove it before sharing.
```


## Share the output returned by the last node


## Debug info

### core

- n8nVersion: 1.119.1
- platform: docker (cloud)
- nodeJsVersion: 22.19.0
- database: sqlite
- executionMode: regular
- concurrency: 5
- license: community

### storage

- success: all
- error: all
- progress: false
- manual: true
- binaryMode: filesystem

### pruning

- enabled: true
- maxAge: 168 hours
- maxCount: 2500 executions

### client

- userAgent: mozilla/5.0 (macintosh; intel mac os x 10_15_7) applewebkit/537.36 (khtml, like gecko) chrome/142.0.0.0 safari/537.36
- isTouchDevice: false

Generated at: 2025-11-11T08:28:14.370Z}

This same root cause must be fixed before merging.
REVIEW_EOF
