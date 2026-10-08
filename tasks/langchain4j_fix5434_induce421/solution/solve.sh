#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `document-loaders/langchain4j-document-loader-tencent-cos/src/main/java/dev/langchain4j/data/document/loader/tencent/cos/TencentCosDocumentLoader.java`:

This pull request introduces the defect later reported as "[BUG] TencentCosDocumentLoader.loadDocument() does not validate bucket and key arguments". The
problem a user observed, and its root cause:

**Describe the bug**
`TencentCosDocumentLoader.loadDocument(String bucket, String key, DocumentParser parser)` passes `bucket` and `key` directly to `new GetObjectRequest(bucket, key)` without validation, producing a cryptic error instead of a descriptive `IllegalArgumentException` on null/blank input.

**Log and Stack trace**
N/A — no descriptive exception, unlike sibling loaders.

**To Reproduce**
```java
loader.loadDocument(null, "key", parser);   // no validation, cryptic failure
loader.loadDocument("bucket", "", parser);  // same
```

**Expected behavior**
`loadDocument()` should throw `IllegalArgumentException` with a descriptive message when `bucket` or `key` is null or blank, matching the pattern of `AmazonS3DocumentLoader.loadDocument()` and the class's own `loadDocuments()`.

**Please complete the following information:**
- LangChain4j version: main (current)
- LLM(s) / Java / Spring Boot: N/A (code defect)

**Additional context**
Fix location: `TencentCosDocumentLoader.loadDocument()`, line ~41. `ensureNotBlank` is already statically imported. Change:

```java
GetObjectRequest getObjectRequest = new GetObjectRequest(ensureNotBlank(bucket, "bucket"), ensureNotBlank(key, "key"));
```

Mirrors `AmazonS3DocumentLoader.loadDocument()` and makes the class consistent with its own `loadDocuments()` (line ~73), which already validates `bucket` via `ListObjectsRequest.withBucketName(...)`.

---

This same root cause must be fixed before merging.
REVIEW_EOF
