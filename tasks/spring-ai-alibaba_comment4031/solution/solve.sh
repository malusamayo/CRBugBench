#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `spring-ai-alibaba-agent-framework/src/main/java/com/alibaba/cloud/ai/graph/agent/Agent.java` (around line 435): I think simply checking `message != null` is not enough. We need to first find the right StreamingOutput by OutputType and then check the message.

| OutputType | 说明 | 是否保留 |
|------------|------|------|
| `AGENT_MODEL_STREAMING` | 模型推理的流式增量内容 | Y |
| `AGENT_MODEL_FINISHED` | 模型推理完成，可获取全量内容 | N |
| `AGENT_TOOL_STREAMING` | 工具调用的流式增量内容 | N |
| `AGENT_TOOL_FINISHED` | 工具调用完成 | Y |
| `AGENT_HOOK_STREAMING` | Hook 节点的流式增量内容 | N |
| `AGENT_HOOK_FINISHED` | Hook 节点完成 | N |

OutputType sample can be found [here](https://github.com/alibaba/spring-ai-alibaba/blob/main/spring-ai-alibaba-agent-framework/src/test/java/com/alibaba/cloud/ai/graph/agent/ReactAgentTest.java#L671) in the unit test.
REVIEW_EOF
