#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `modules/openapi-generator/src/main/resources/ocaml/model.mustache`:

This pull request introduces the defect later reported as "[BUG] spaces missing from type hints in generated ocaml code". The
problem a user observed, and its root cause:

##### Description

Running the ocaml code generator generates code that fails to build because spaces have been removed from type declarations that should have space. Eg: `string option` becomes `stringoption`

<!-- describe what is the question, suggestion or issue and why this is a problem for you. -->

##### openapi-generator version

Both git master and 4.3.1 release

##### OpenAPI declaration file content or url

https://github.com/stripe/openapi/blob/master/openapi/spec3.yaml, though I'm sure a simpler spec would also fail

This same root cause must be fixed before merging.
REVIEW_EOF
