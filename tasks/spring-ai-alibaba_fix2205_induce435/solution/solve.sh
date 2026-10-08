#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `community/vector-stores/spring-ai-alibaba-starter-tair-store/src/main/java/com/alibaba/cloud/ai/vectorstore/tair/TairVectorStore.java`:

This pull request introduces the defect later reported as "[BUG] TairVectorStore 中createObservationContextBuilder方法返回null，到之后使用TairVectorStore 增删查的时候空指针". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Current Behavior

<img width="1734" height="220" alt="Image" src="https://github.com/user-attachments/assets/c5d79b16-98a0-4075-92cc-1a89bc91c115" />

<img width="1572" height="916" alt="Image" src="https://github.com/user-attachments/assets/2e4aa092-d319-436a-91d6-128a430b2dbe" />

### Expected Behavior

_No response_

### Steps To Reproduce

_No response_

### Environment

```markdown
Spring AI Alibaba version(s):
1.0.0.3-SNAPSHOT
```

### Debug logs

_No response_

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
