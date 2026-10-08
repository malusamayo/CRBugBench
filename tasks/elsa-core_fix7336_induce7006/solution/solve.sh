#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/modules/Elsa.Workflows.Core/Activities/Flowchart/Activities/Flowchart.cs`:

This pull request introduces the defect later reported as ""Lost an owner context" error while trying to complete a Join activity using WaitAny, on a workflow using a before/after/always commit strategy.". The
problem a user observed, and its root cause:

## Description
This happens because of how Elsa Workflows handles flowchart completion together with the commit behavior.
When a workflow contains a Join Activity with WaitAny, that joins together several branches, out of which at least one contain a loop (with it's own flowchart):
The flowchart is marked as completed before the Join activity is scheduled.
When the Commit option is set to “Always Commit” or "Commit Before/After Activity Execution", the workflow state is saved to the database at every step, including exactly when the Join executes.
At that moment, the commit logic runs and attempts to process the Join’s completion callback.
However, since the flowchart has already been marked as completed (and completed flowcharts are filtered out), it can no longer find the flowchart context.

## Steps to Reproduce
I've attached the workflow definition used for reproducing this:

<img width="1433" height="815" alt="Image" src="https://github.com/user-attachments/assets/97d138d8-bbeb-4383-af02-5543a45dce18" />
and this is the result:

<img width="1734" height="903" alt="Image" src="https://github.com/user-attachments/assets/3c2fea59-688c-4e1f-a371-53370a4f142b" />


1. **Detailed Steps**: 
You can also try this by creating a workflow that has two branches, one with a simple 5 seconds delay, the other one with a simple 1-iteration for loop that also contains a 10 seconds delay. both branches then meet into a Join activity with a "WaitAny" strategy.
Make sure you set the workflow strategy to Before/After activity execution or Always Commit.
When running the issue "Lost an owner context" will immediately become apparent.

3. **Attachments**:

[parallel.delay-lost.owner.context.json](https://github.com/user-attachments/files/25683367/parallel.delay-lost.owner.context.json)

4. **Reproduction Rate**: Every time.

## Expected Behavior
Flow should not Fault, Join activity should be completed without incidents. Join activity should not try canceling activities within upstream flowchart before scheduling them.

## Actual Behavior
Flow goes into faulted state with incidents. Join activity does not complete; output states "Lost an owner context exception".


## Environment
- **Elsa Package Version**: 3.5.*
- **Operating System**: Windows 11 / any.
- **Browser and Version**: Chrome /any

## Log Output
   at Elsa.Workflows.WorkflowStateExtractor.ExtractCompletionCallbacks(WorkflowState state, WorkflowExecutionContext workflowExecutionContext) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Core\Services\WorkflowStateExtractor.cs:line 217
   at Elsa.Workflows.WorkflowStateExtractor.Extract(WorkflowExecutionContext workflowExecutionContext) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Core\Services\WorkflowStateExtractor.cs:line 40
   at Elsa.Workflows.Management.Services.WorkflowInstanceManager.ExtractWorkflowState(WorkflowExecutionContext workflowExecutionContext) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Management\Services\WorkflowInstanceManager.cs:line 133
   at Elsa.Workflows.Runtime.DefaultCommitStateHandler.CommitAsync(WorkflowExecutionContext workflowExecutionContext, CancellationToken cancellationToken) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Runtime\Services\DefaultCommitStateHandler.cs:line 21
   at Elsa.Workflows.Middleware.Activities.DefaultActivityInvokerMiddleware.InvokeAsync(ActivityExecutionContext context) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Core\Middleware\Activities\DefaultActivityInvokerMiddleware.cs:line 99
   at Elsa.Workflows.Runtime.Middleware.EvaluateLogPersistenceModesMiddleware.InvokeAsync(ActivityExecutionContext context) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Runtime\LogPersistence\Middleware\EvaluateLogPersistenceModesMiddleware.cs:line 14
   at Elsa.Connections.Middleware.ConnectionMiddleware.InvokeAsync(ActivityExecutionContext context) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Connections.Core\Middleware\ConnectionMiddleware.cs:line 68
   at Elsa.Workflows.Middleware.Activities.NotificationPublishingMiddleware.InvokeAsync(ActivityExecutionContext context) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Core\Middleware\Activities\NotificationPublishingMiddleware.cs:line 28
   at Elsa.Workflows.Middleware.Activities.ExecutionLogMiddleware.InvokeAsync(ActivityExecutionContext context) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Core\Middleware\Activities\ExecutionLogMiddleware.cs:line 31
   at Elsa.Workflows.Middleware.Activities.ExceptionHandlingMiddleware.InvokeAsync(ActivityExecutionContext context) in D:\work\projects\elsa\elsa-core\src\modules\Elsa.Workflows.Core\Middleware\Activities\ExceptionHandlingMiddleware.cs:line 30

## Troubleshooting Attempts
The only viable workaround is to no longer rely on any commit strategies, and instead use the Default.

## Related Issues
Possibly https://github.com/elsa-workflows/elsa-core/issues/5843 as they report a similar error message, while the commenters point to a simiar behavior.

This same root cause must be fixed before merging.
REVIEW_EOF
