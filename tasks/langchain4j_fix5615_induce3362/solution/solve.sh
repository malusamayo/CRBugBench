#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `langchain4j-vertex-ai-anthropic/src/main/java/dev/langchain4j/model/vertexai/anthropic/internal/mapper/AnthropicRequestMapper.java`:

This pull request introduces the defect later reported as "[BUG] Vertex AI Anthropic tool input schema omits $defs for tools using schema references". The
problem a user observed, and its root cause:

**Describe the bug**
In `langchain4j-vertex-ai-anthropic`, `AnthropicRequestMapper.toAnthropicTool()` builds a tool `input_schema` from `properties` and `required` only. It never reads `parameters.definitions()`, so the schema's top-level `$defs` block is omitted.

When a tool parameter uses nested, recursive, or shared object types, core `JsonSchemaElementUtils.toMap` serializes a `JsonReferenceSchema` as `{"$ref":"#/$defs/Name"}`. With the matching `$defs` missing, a dangling `$ref` schema is sent to the Vertex AI Anthropic API, which can reject the tool or mishandle its input.

The sibling `langchain4j-anthropic` already serializes `$defs` in its `toAnthropicTool` (PR #5499); the Vertex module never got that fix.

**Log and Stack trace**
N/A

**To Reproduce**
Register a tool whose `JsonObjectSchema` parameters reference a definition:
```java
JsonObjectSchema params = JsonObjectSchema.builder()
        .addProperty("address", JsonReferenceSchema.builder().reference("Address").build())
        .definitions(Map.of("Address", addressSchema))
        .build();
```
The resulting `input_schema` contains a `$ref` to `#/$defs/Address` but no `$defs`.

**Expected behavior**
The tool `input_schema` includes a `$defs` entry holding the referenced definitions, so every `$ref` resolves.

**Please complete the following information:**
- LangChain4j version: 1.18.0-beta28-SNAPSHOT
- LLM(s) used: Claude via Vertex AI Anthropic
- Java version: 17
- Spring Boot version (if applicable): N/A

**Additional context**
The fix is conditional: `$defs` is added only when `definitions()` is non-empty, so tools without definitions are unchanged.

This same root cause must be fixed before merging.
REVIEW_EOF
