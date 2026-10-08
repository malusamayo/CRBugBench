#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/scss/pages/_job.scss`:

This pull request introduces the defect later reported as "Chevron box misalignment on Build History view". The
problem a user observed, and its root cause:

### Jenkins and plugins versions report

<details>
  <summary>Environment</summary>

  <!-- Paste your environment details below -->
  ```text
Jenkins: 2.541.2
OS: Windows Server 2022 - 10.0
Java: 21.0.10 - Azul Systems, Inc. (OpenJDK 64-Bit Server VM)
---
PrioritySorter:936.v2c01c6b_84449
TestComplete:2.10
ansicolor:536.v13fa_b_860c267
antisamy-markup-formatter:173.v680e3a_b_69ff3
apache-httpcomponents-client-4-api:4.5.14-269.vfa_2321039a_83
apache-httpcomponents-client-5-api:5.6-183.ve5a_8a_b_e71e59
asm-api:9.9.1-189.vb_5ef2964da_91
azure-credentials:418.v6628eec6a_2c5
azure-keyvault:346.v75201ddefa_e0
azure-sdk:259.vf079c96088a_f
badge:2.562.vc3c0b_6925377
bootstrap5-api:5.3.8-895.v4d0d8e47fea_d
bouncycastle-api:2.30.1.83-289.v8426fcd19371
branch-api:2.1280.v0d4e5b_b_460ef
build-failure-analyzer:2.6.1
build-name-setter:2.5.1
build-timeout:1.39
build-timestamp:1.1.1
build-user-vars-plugin:214.va_eed2ed849ca_
buildtriggerbadge:343.vb_693d3ceda_44
caffeine-api:3.2.3-194.v31a_b_f7a_b_5a_81
checks-api:402.vca_263b_f200e3
claim:617.v149399f86b_de
cloudbees-folder:6.1079.vc0975c2de294
collapsing-console-sections:1.12.0
commons-compress-api:1.28.0-3
commons-lang3-api:3.20.0-109.ve43756e2d2b_4
commons-text-api:1.15.0-218.va_61573470393
configuration-as-code:2037.v8e5349845172
copyartifact:795.ve8e151429b_27
credentials:1491.v6d6145e96e1c
credentials-binding:717.v951d49b_5f3a_a_
custom-markup-formatter:39.v291c115db_c4d
customizable-header:285.v70da_c6f8a_420
dark-theme:574.va_19f05d54df5
dashboard-view:2.558.v96b_901978e47
data-tables-api:2.3.5-1497.v38449eb_7d5a_1
display-url-api:2.217.va_6b_de84cc74b_
durable-task:651.v1f5e074fc83f
echarts-api:6.0.0-1165.vd1283a_3e37d4
eddsa-api:0.3.0.1-29.v67e9a_1c969b_b_
editable-choice:71.v02a291ebbe45
emoji-symbols-api:17.0-57.v8d44b_9a_b_d5ea_
envinject:2.934.vc674e76cf954
envinject-api:1.237.v82803a_511906
extra-columns:1.28
flatpickr-api:4.6.13-32.v60a_51029c136
font-awesome-api:7.1.0-882.v1dfb_771e3278
generic-webhook-trigger:2.4.1
git:5.10.0
git-client:6.5.0
git-parameter:462.vdcf3df2ed2ca_
github-api:1.330-492.v3941a_032db_2a_
groovy:497.v7b_061a_a_de65d
groovy-postbuild:300.va_253b_2988cb_1
gson-api:2.13.2-173.va_a_092315913c
htmlpublisher:427
http_request:1.24
instance-identity:203.v15e81a_1b_7a_38
ionicons-api:94.vcc3065403257
jackson2-api:2.20.1-423.v13951f6b_6532
jakarta-activation-api:2.1.4-1
jakarta-mail-api:2.1.5-1
jakarta-xml-bind-api:4.0.6-12.vb_1833c1231d3
javax-activation-api:1.2.0-8
javax-mail-api:1.6.2-11
jaxb:2.3.9-143.v5979df3304e6
jdk-tool:83.v417146707a_3d
jfrog:1.6.1
job-dsl:3654.vdf58f53e2d15
jobConfigHistory:1356.ve360da_6c523a_
joda-time-api:2.14.0-177.vd7e9347b_e7d5
jquery3-api:3.7.1-619.vdb_10e002501a_
json-api:20251224-185.v0cc18490c62c
json-path-api:3.0.0-218.vcd4dd1355de2
junit:1396.v095840ed8491
leastload:66.v8720e4713836
locale:614.va_6a_5a_1a_f2b_38
lockable-resources:1438.v3c0f8c9e2060
mailer:525.v2458b_d8a_1a_71
matrix-project:870.v9db_fcfc2f45b_
metrics:4.2.37-494.v06f9a_939d33a_
mina-sshd-api-common:2.16.0-167.va_269f38cc024
mina-sshd-api-core:2.16.0-167.va_269f38cc024
monitoring:2.6.0
multibranch-scan-webhook-trigger:1.0.11
netty-api:4.1.130.Final-21.v5a_db_3eb_ea_034
nodelabelparameter:851.vd94e5048d321
okhttp-api:4.12.0-195.vc02552c04ffd
oss-symbols-api:442.v99039087229b_
pipeline-agent-build-history:142.v3046581ceb_71
pipeline-build-step:584.vdb_a_2cc3a_d07a_
pipeline-graph-analysis:254.v0f63a_a_447dca_
pipeline-graph-view:777.vdeb_113b_b_94da_
pipeline-groovy-lib:787.ve2fef0efdca_6
pipeline-input-step:540.v14b_100d754dd
pipeline-milestone-step:138.v78ca_76831a_43
pipeline-model-api:2.2277.v00573e73ddf1
pipeline-model-definition:2.2277.v00573e73ddf1
pipeline-model-extensions:2.2277.v00573e73ddf1
pipeline-rest-api:2.39
pipeline-stage-step:322.vecffa_99f371c
pipeline-stage-tags-metadata:2.2277.v00573e73ddf1
pipeline-utility-steps:2.20.0
plain-credentials:199.v9f8e1f741799
plugin-util-api:6.1192.v30fe6e2837ff
postbuild-task:78.v24529f1f5cdb_
powershell:178.v4b_3a_9f214ea_2
prism-api:1.30.0-703.v116fb_3b_5b_b_a_a_
prometheus:852.v317db_5d17a_b_0
purge-build-queue-plugin:125.v09ee2147746f
rebuild:338.va_0a_b_50e29397
resource-disposer:0.25
role-strategy:848.va_a_ea_673cf0b_c
saml:4.595.vec7523b_5d543
schedule-build:696.v0a_b_ec7334c89
scm-api:728.vc30dcf7a_0df5
script-security:1399.ve6a_66547f6e1
sidebar-link:2.5.0
simple-theme-plugin:230.v8b_fd91b_b_800c
snakeyaml-api:2.5-149.v72471e9c6371
ssh-credentials:361.vb_f6760818e8c
sshd:3.384.vc89b_5e138cf9
structs:362.va_b_695ef4fdf9
text-finder:1.33
theme-manager:327.v780d7096ec29
timestamper:1.30
token-macro:477.vd4f0dc3cb_cf1
uno-choice:2.8.4-SNAPSHOT (private-a592dd8d-grno)
variant:70.va_d9f17f859e0
view-job-filters:406.va_0ec67147ee2
workflow-aggregator:608.v67378e9d3db_1
workflow-api:1398.v67030756d3fb_
workflow-basic-steps:1098.v808b_fd7f8cf4
workflow-cps:4257.vb_2e202808577
workflow-durable-task-step:1464.v2d3f5c68f84c
workflow-job:1571.vb_423c255d6d9
workflow-multibranch:821.vc3b_4ea_780798
workflow-scm-step:466.va_d69e602552b_
workflow-step-api:710.v3e456cc85233
workflow-support:1015.v785e5a_b_b_8b_22
ws-cleanup:0.49

  ```

</details>


### What Operating System are you using (both controller, and any agents involved in the problem)?

Windows

### Reproduction steps

1. Run job/pipeline
2. Hover on the chevron in the Build History view

Issue appears on both classic and experimental views

### Expected Results

Chevron box is centered

### Actual Results

Chevron box is not centered and is not intuitive to click on

<img width="306" height="71" alt="Image" src="https://github.com/user-attachments/assets/b6745e63-6bc1-4f0a-8305-9bce8ea22a5c" />

### Anything else?

I'm not sure about it, but we also have 

### Are you interested in contributing a fix?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
