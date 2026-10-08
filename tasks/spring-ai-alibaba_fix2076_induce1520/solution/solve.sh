#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `spring-ai-alibaba-jmanus/src/main/java/com/alibaba/cloud/ai/example/manus/llm/LlmService.java`:

This pull request introduces the defect later reported as "[BUG] jmanus动态配置的header好像没生效，被获取client的时候prompt的重置了". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Current Behavior

ChatOptions chatOptions = OpenAiChatOptions.builder()
				.internalToolExecutionEnabled(false)
				.parallelToolCalls(manusProperties.getParallelToolCalls())
				.build();

### Expected Behavior

_No response_

### Steps To Reproduce

_No response_

### Environment

```markdown
Spring AI Alibaba version(s):
```

### Debug logs

_No response_

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
