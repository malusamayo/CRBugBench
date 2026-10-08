#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `modules/openapi-generator/src/main/java/org/openapitools/codegen/languages/GoClientCodegen.java`:

This pull request introduces the defect later reported as "[BUG][Go] Unused "bytes" import in v7.2.0". The
problem a user observed, and its root cause:

#### Bug Report Checklist

- [x] Have you provided a full/minimal spec to reproduce the issue?
- [x] Have you validated the input using an OpenAPI validator ([example](https://apidevtools.org/swagger-parser/online/))?
- [x] Have you [tested with the latest master](https://github.com/OpenAPITools/openapi-generator/wiki/FAQ#how-to-test-with-the-latest-master-of-openapi-generator) to confirm the issue still exists?
- [x] Have you searched for related issues/PRs?
- [x] What's the actual output vs expected output?
- [ ] [Optional] Sponsorship to speed up the bug fix or feature request ([example](https://github.com/OpenAPITools/openapi-generator/issues/6178))

<!--
Please follow the issue template below for bug reports.
Also please indicate in the issue title which language/library is concerned. Eg:  [BUG][JAVA] Bug generating foo with bar 
-->

##### Description
https://github.com/OpenAPITools/openapi-generator/pull/17267 moved import of `bytes` from a specific file [model_simple.mustache](https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/go/model_simple.mustache) to generator code that is applied to all files, including [model_oneof.mustache](https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/go/model_oneof.mustache) that does not use `bytes`. And this leads to the following error:
```
schema/generated/some-config/model_object_model.go:14:2: "bytes" imported and not used
```

##### openapi-generator version
- 7.2.0
- latest


##### OpenAPI declaration file content or url
```yaml
openapi: 3.0.0
info:
  title: Test
  version: 1.0.0
paths: {}
components:
  schemas:
    NestedObject1:
      required:
        - field1
      properties:
        field1:
          description: Specifies an action name to be used with the Android Intent class.
          type: string
    NestedObject2:
      required:
        - field2
      properties:
        field2:
          description: Specifies an action name to be used with the Android Intent class.
          type: string
    Object:
      oneOf:
        - $ref: '#/components/schemas/NestedObject1'
        - $ref: '#/components/schemas/NestedObject2'
```

##### Generation Details
`docker run --rm -u 1001:1001 -v "${PWD}:/local" openapitools/openapi-generator-cli:v7.2.0 generate -i /local/test.yaml -g go -o /local/out/go`

##### Steps to reproduce
Run generator and try to build the generated code.

##### Related issues/PRs
https://github.com/OpenAPITools/openapi-generator/pull/17267

##### Suggest a fix
Partial revert of https://github.com/OpenAPITools/openapi-generator/pull/17267, in particular, code change suggested in https://github.com/OpenAPITools/openapi-generator/pull/17267#discussion_r1411343453

This same root cause must be fixed before merging.
REVIEW_EOF
