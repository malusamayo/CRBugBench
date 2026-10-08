#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ingestion/src/metadata/ingestion/lineage/masker.py`:

This pull request introduces the defect later reported as "[Vertica Connector] NEXTVAL() sequence arguments  parameterised as ? in lineage parser". The
problem a user observed, and its root cause:

**Affected module**
Does it impact the UI, backend or Ingestion Framework?
Ingestion Framework and UI
**Describe the bug**
A clear and concise description of what the bug is.
During Vertica lineage ingestion, OpenMetadata’s lineage parser (sql_lineage.py) receives SQL queries where NEXTVAL() function arguments have been replaced with ? placeholders. This prevents sequence schema and name from being resolved as catalog objects in the lineage graph.
**To Reproduce**

Screenshots or steps to reproduce

Screenshot + debug logs (masked) attached

<img width="446" height="523" alt="Image" src="https://github.com/user-attachments/assets/1f775259-8bf7-47de-b890-d538efe63205" />

<img width="446" height="523" alt="Image" src="https://github.com/user-attachments/assets/bd715695-55ea-4c26-b013-1691634ec580" />

**Expected behavior**
A clear and concise description of what you expected to happen.
The lineage parser should receive the full original SQL as preserved in the query registry:
NEXTVAL( 'reporting', 'REDACTED_SEQUENCE' )
Expected outcome:
- NEXTVAL schema and sequence name resolved as catalog objects
- Sequence visible as a node in lineage graph
**Version:**
 - OS: [e.g. iOS]
 - Python version:
 - OpenMetadata version: 1.10.5
 

**Additional context**
Add any other context about the problem here.

This same root cause must be fixed before merging.
REVIEW_EOF
