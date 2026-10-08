#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `core/src/main/java/jenkins/agents/CloudSet.java`:

This pull request introduces the defect later reported as "Copying a cloud use string.replace which can replace more than intended". The
problem a user observed, and its root cause:

### Jenkins and plugins versions report

<details>
  <summary>Environment</summary>

  <!-- Paste your environment details below -->
  ```text
Jenkins 2.549
kubernetes plugin
  ```

</details>


### What Operating System are you using (both controller, and any agents involved in the problem)?

not relevant

### Reproduction steps

1. install jclouds plugin
2. create a kubernetes cloud with name `kube`
3. create a template in that cloud that has the same name as the cloud itself, i.e. `kube`
4. on create new cloud with name `kube2` by selecting to copy from an existing cloud and choose the `kube`

### Expected Results

the new copied cloud should have a template with name `kube`

### Actual Results

the new cloud has a template with name `kube2`

### Anything else?

_No response_

### Are you interested in contributing a fix?

caused by #7658 that uses string replace

This same root cause must be fixed before merging.
REVIEW_EOF
