#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `code-execution-engines/langchain4j-code-execution-engine-azure-acads/src/main/java/dev/langchain4j/code/azure/acads/SessionsREPLTool.java`:

This pull request introduces the defect later reported as "[BUG] Azure dynamic sessions downloadFile corrupts binary files via String round-trip". The
problem a user observed, and its root cause:

**Title:** [BUG] Azure dynamic sessions downloadFile corrupts binary files via String round-trip

**Describe the bug**

In `langchain4j-code-execution-engine-azure-acads`, `SessionsREPLTool.DefaultFileDownloader.downloadFile()` Base64-encodes the wrong bytes:

```java
byte[] fileBytes = response.body().getBytes(StandardCharsets.UTF_8);
return Base64.getEncoder().encodeToString(fileBytes);
```

`SuccessfulHttpResponse.body()` returns `new String(body, charset())` — a decoded String view of the canonical `byte[]`. Re-encoding that String to UTF-8 is a lossy round-trip: any byte not valid in the response charset (UTF-8 by default) becomes U+FFFD. Downloading a sandbox's binary output (PNG, xlsx, etc. — the normal use of a file downloader) therefore yields silently corrupted Base64 that no longer decodes to the original file.

**To Reproduce**

Download a file whose bytes are not valid UTF-8. The returned Base64 decodes to a different byte sequence than the file on the server.

**Expected behavior**

The Base64 reflects the exact bytes the server returned.

**Fix**

Use the raw canonical bytes via `response.bodyBytes()`.

**Please complete the following information:**
- LangChain4j version: current main
- LLM(s) used: n/a
- Java version: 17

---

This same root cause must be fixed before merging.
REVIEW_EOF
