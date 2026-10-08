#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `modules/openapi-generator/src/main/java/org/openapitools/codegen/DefaultCodegen.java`:

This pull request introduces the defect later reported as "[BUG] Model name prefix brakes model inheritance". The
problem a user observed, and its root cause:

#### Bug Report Checklist

- [x] Have you provided a full/minimal spec to reproduce the issue?
- [x] Have you validated the input using an OpenAPI validator ([example](https://apidevtools.org/swagger-parser/online/))?
- [x] What's the version of OpenAPI Generator used?
- [x] Have you search for related issues/PRs?
- [x] What's the actual output vs expected output?

<!--
Please follow the issue template below for bug reports.
Also please indicate in the issue title which language/library is concerned. Eg:  [BUG][JAVA] Bug generating foo with bar 
-->

##### Description

When generating for a YAML containing model composition / inheritance (for example the petstore-with-fake-endpoints-models-for-testing.yaml, see link below) **and** using the `--model-name-prefix` CLI parameter for setting a custom prefix for the generated models, the inheritance is not paid respect to correctly.

To stay with the example: Instead of only generating the fields and methods for className and color only in the MyPrefixAnimal class, it is generating both in the MyPrefixAnimal class and in its subclasses MyPrefixDog and MyPrefixCat. If one ommits the prefix CLI parameter, everything works fine and the fields and methods will be generated only where they are meaningful.

##### openapi-generator version

I tested it with 4.0.0, 4.1.0-SNAPSHOT and 5.0.0-SNAPSHOT and various generators (jaxrs-jersey, jaxrs-cxf, python) and was able to observe the problem in all cases.

##### OpenAPI declaration file content or url

https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/test/resources/3_0/petstore-with-fake-endpoints-models-for-testing.yaml

##### Command line used for generation

`java -jar openapi-generator-cli-4.0.0.jar generate -i petstore-with-fake-endpoints-models-for-testing.yaml -g jaxrs-jersey -o wrongInheritance --model-name-prefix MyPrefix`

##### Steps to reproduce

Use the command line above with the example from the repo and the generated MyPrefixCat model will be wrong.

This same root cause must be fixed before merging.
REVIEW_EOF
