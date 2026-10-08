#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/modules/Elsa.Workflows.Runtime/Services/DefaultActivityExecutionMapper.cs`:

This pull request introduces the defect later reported as "[BUG] Workflow Instance Data Missing Due to Default Log Persistence Mode Misinterpretation". The
problem a user observed, and its root cause:

When initiating a workflow instance that involves multiple steps, it is observed that the expected data and logs are not present in the journal and activity instances. This issue stems from a misinterpretation regarding the default setting for the Log Persistence Mode.

## Expected Behavior

The expectation is that starting a workflow would automatically include detailed logs and data in the journal and associated activity instances, allowing for easy monitoring and debugging.

## Current Behavior

Due to a misinterpretation, the Default Log Persistence Mode is interpreted as `Exclude` by default, rather than `Include`. This results in missing crucial logs and data that are essential for effective workflow management and analysis.

## Steps to Reproduce

1. Configure the Workflow Management feature with DefaultLogPersistenceMode = Default
1. Start a workflow instance with multiple steps.
2. Check the journal and output logs in the associated activity instances.
3. Notice the absence of expected logs and data.

## Impact

This issue hinders the ability to effectively monitor and troubleshoot workflows, impacting overall system reliability and user experience.

This same root cause must be fixed before merging.
REVIEW_EOF
