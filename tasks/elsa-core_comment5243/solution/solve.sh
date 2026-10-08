#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/modules/Elsa.MassTransit/Services/MassTransitWorkflowDispatcher.cs` (around line 166): ```suggestion
           var workflow = await workflowDefinitionService.FindWorkflowAsync(trigger.WorkflowDefinitionVersionId, cancellationToken);

            if (workflow == null)
            {
                logger.LogWarning("Workflow definition with ID '{WorkflowDefinitionId}' not found", trigger.WorkflowDefinitionVersionId);
                continue;
            }

            var createWorkflowInstanceRequest = new CreateWorkflowInstanceRequest
            {
                Workflow = workflow,
                WorkflowInstanceId = request.WorkflowInstanceId,
                Input = request.Input,
                Properties = request.Properties,
                CorrelationId = request.CorrelationId
            };

            // The workflow instance is created and persisted in the database.
            var workflowInstance = await workflowInstanceManager.CreateWorkflowInstanceAsync(createWorkflowInstanceRequest, cancellationToken);

            // The workflow instance is then dispatched for execution.
            var sendEndpoint = await GetSendEndpointAsync(options);
            var message = DispatchWorkflowDefinition.DispatchExistingWorkflowInstance(workflowInstance.Id, trigger.ActivityId);
```
REVIEW_EOF
