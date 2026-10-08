#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/modules/Elsa.Workflows.Runtime/Tasks/RestartInterruptedWorkflowsTask.cs`:

This pull request introduces the defect later reported as "RestartInterruptedWorkflowsTask restarts tenant-scoped workflow instances outside the correct tenant context". The
problem a user observed, and its root cause:

## Description

We came across this while running multiple Elsa hosts in a distributed multitenant environment.

`RestartInterruptedWorkflowsTask` can restart tenant-scoped workflow instances outside their tenant context.

The task enumerates interrupted workflow instances and restarts them through `IWorkflowRestarter`, but if execution is not already inside the workflow instance's tenant scope, the restart dispatch can happen under the wrong ambient tenant context. This is especially relevant in distributed multitenant setups where multiple Elsa hosts process workflow instances across tenants and downstream dispatch and resolution depend on `ITenantAccessor`.

Relevant flow:

```csharp
await foreach (var workflowInstance in workflowInstances)
{
    await workflowRestarter.RestartWorkflowAsync(workflowInstance.Id, cancellationToken: cancellationToken);
}
```

## Steps to Reproduce

1. Enable multitenancy in an Elsa host.
2. Run multiple Elsa hosts in a distributed environment.
3. Run workflow instances across different tenants.
4. Ensure one or more workflow instances remain in an interrupted or still-executing state so they are picked up by `RestartInterruptedWorkflowsTask`.
5. Let the recurring restart task run on one of the hosts.
6. Observe that tenant-specific workflow instances can be restarted without first restoring the workflow instance's tenant scope.

Relevant files:
- `RestartInterruptedWorkflowsTask.cs`
- `DefaultWorkflowRestarter.cs`
- `WorkflowInstanceSummary.cs`

Reproduction rate:
- Observed while running multiple Elsa hosts in a distributed multitenant setup.
- For tenant-specific interrupted workflow instances, the behavior is reproducible when the restart path runs outside the matching tenant scope.

Additional configuration:
- Multitenancy must be enabled.
- Multiple Elsa hosts should be running in the same distributed environment.
- Multiple tenants should have workflow instances in flight.
- At least one tenant-specific workflow instance must be picked up by the interrupted workflow restart task.

## Expected Behavior

When `RestartInterruptedWorkflowsTask` restarts a workflow instance, the restart should run inside the tenant scope of that workflow instance.

For instances with no tenant ID or `Tenant.AgnosticTenantId`, no tenant context should be pushed.

## Actual Behavior

Tenant-specific interrupted workflow instances can be restarted without switching to the correct tenant context first. As a result, restart dispatch can occur under the wrong tenant scope.

## Screenshots

None.

## Environment

- **Elsa Package Version**: latest source as of April 14, 2026
- **Operating System**: Windows
- **Browser and Version**: N/A

## Log Output

There may not be a direct exception or explicit error message. The problem is behavioral: the restart dispatch occurs under the wrong ambient tenant context.

## Troubleshooting Attempts

- Traced the restart flow from `RestartInterruptedWorkflowsTask.cs` into `DefaultWorkflowRestarter.cs`.
- Confirmed that restart dispatch depends on ambient tenant context.
- Verified that tenant metadata needs to be available at the restart task level.
- Added targeted unit coverage for tenant-specific and non-tenant-scoped restart behavior.

## Additional Context

This issue is specific to the interrupted workflow restart path.

The core problem is that the restart task knows which workflow instance to restart, but without restoring the instance's tenant context first, the dispatcher can behave as though the instance belongs to the current ambient tenant instead of its actual tenant.

## Related Issues

- Potentially related to other multitenant background-task flows that rely on ambient tenant context.
- Separate from any pagination or summary enumeration issues.

This same root cause must be fixed before merging.
REVIEW_EOF
