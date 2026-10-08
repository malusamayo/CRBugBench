#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `langchain4j-open-ai-official/src/main/java/dev/langchain4j/model/openaiofficial/OpenAiOfficialImageModel.java`:

This pull request introduces the defect later reported as "[BUG] OpenAiOfficialImageModel.generate() crashes with NoSuchElementException when data is absent". The
problem a user observed, and its root cause:

**Describe the bug**

In `OpenAiOfficialImageModel.generate(String)`, the empty-data guard at line 72 uses `&&` instead of `||`:

```java
if (response.data().isEmpty() && response.data().get().isEmpty()) {
```

`response.data()` returns `Optional<List<Image>>`. When the Optional is empty:
- `isEmpty()` returns `true`
- `&&` still evaluates the right side
- `.get()` throws `NoSuchElementException`

The guard was intended to catch both "no data field" and "empty data list", but the `&&` operator defeats it — it crashes on the very condition it was supposed to protect against.

**Log and Stack trace**

```
java.util.NoSuchElementException: No value present
    at java.base/java.util.Optional.get(Optional.java:143)
    at dev.langchain4j.model.openaiofficial.OpenAiOfficialImageModel.generate(OpenAiOfficialImageModel.java:72)
```

**To Reproduce**

Call `generate(prompt)` when the OpenAI API returns a response with no `data` field (i.e., `response.data()` is `Optional.empty()`).

**Expected behavior**

The method should throw `IllegalArgumentException("Image generation failed: no image returned")` when data is absent.

The fix is a one-character change: `&&` → `||`.

**Please complete the following information:**
- LangChain4j version: 1.13.0-beta23-SNAPSHOT (main branch)
- LLM(s) used: OpenAI (official SDK) image models (dall-e-3, etc.)
- Java version: 17+
- Spring Boot version (if applicable): N/A

**Additional context**

The `generate(String, int)` method at line 85 correctly uses `if (response.data().isEmpty())` — only the single-image `generate(String)` overload has this bug.

This same root cause must be fixed before merging.
REVIEW_EOF
