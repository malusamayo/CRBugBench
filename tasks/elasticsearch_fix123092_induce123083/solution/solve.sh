#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `modules/repository-gcs/src/test/java/org/elasticsearch/repositories/gcs/GoogleCloudStorageServiceTests.java`:

This pull request introduces the defect later reported as "[CI] GoogleCloudStorageServiceTests testClientsAreNotSharedAcrossRepositories failing". The
problem a user observed, and its root cause:

**Build Scans:**
- [elasticsearch-intake #18586 / part1](https://gradle-enterprise.elastic.co/s/eu5gleizvk6cy)
- [elasticsearch-intake #18585 / part1](https://gradle-enterprise.elastic.co/s/hpxir43vcg5ou)

**Reproduction Line:**
```
./gradlew ":modules:repository-gcs:test" --tests "org.elasticsearch.repositories.gcs.GoogleCloudStorageServiceTests.testClientsAreNotSharedAcrossRepositories" -Dtests.seed=B1CE7C8E2C3D63A -Dtests.locale=es-UY -Dtests.timezone=Indian/Comoro -Druntime.java=23
```

**Applicable branches:**
main

**Reproduces locally?:**
N/A

**Failure History:**
[See dashboard](https://es-delivery-stats.elastic.dev/app/dashboards#/view/dcec9e60-72ac-11ee-8f39-55975ded9e63?_g=(refreshInterval:(pause:!t,value:60000),time:(from:now-7d%2Fd,to:now))&_a=(controlGroupState:(initialChildControlState:('0c0c9cb8-ccd2-45c6-9b13-96bac4abc542':(dataViewId:fbbdc689-be23-4b3d-8057-aa402e9ed0c5,fieldName:task.keyword,order:0,selectedOptions:!(),title:'GradleTask',type:optionsListControl),'4e6ad9d6-6fdc-4fcc-bf1a-aa6ca79e0850':(dataViewId:fbbdc689-be23-4b3d-8057-aa402e9ed0c5,fieldName:className.keyword,order:1,selectedOptions:!(org.elasticsearch.repositories.gcs.GoogleCloudStorageServiceTests),title:'Suite',type:optionsListControl),'144933da-5c1b-4257-a969-7f43455a7901':(dataViewId:fbbdc689-be23-4b3d-8057-aa402e9ed0c5,fieldName:name.keyword,order:2,selectedOptions:!(testClientsAreNotSharedAcrossRepositories),title:'Test',type:optionsListControl)))))

**Failure Message:**
```
java.lang.AssertionError: expected same:<com.google.cloud.storage.StorageImpl@20da4a41> was not:<com.google.cloud.storage.StorageImpl@2ea13d98>
```

**Issue Reasons:**
- [main] 2 consecutive failures in step part1
- [main] 2 consecutive failures in pipeline elasticsearch-intake
- [main] 2 failures in test testClientsAreNotSharedAcrossRepositories (0.9% fail rate in 225 executions)
- [main] 2 failures in step part1 (6.1% fail rate in 33 executions)
- [main] 2 failures in pipeline elasticsearch-intake (6.1% fail rate in 33 executions)

**Note:**
This issue was created using new test triage automation. Please report issues or feedback to es-delivery.

This same root cause must be fixed before merging.
REVIEW_EOF
