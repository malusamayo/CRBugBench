#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Indexers/Partis.cs`:

This pull request introduces the defect later reported as "Partis". The
problem a user observed, and its root cause:

### Have you checked our Troubleshooting page for your issue?

- [X] I have checked the Troubleshooting page

### Is there already an issue for your problem?

- [X] I have checked older issues, open and closed

### Have you read our Contributing Guidelines?

- [X] I have read the Contributing Guidelines

### Environment

```markdown
System.NullReferenceException: Object reference not set to an instance of an object.
   at Jackett.Common.Indexers.Partis.<>c__DisplayClass8_0.<ApplyConfiguration>b__0() in /home/vsts/work/1/s/src/Jackett.Common/Indexers/Partis.cs:line 138
   at Jackett.Common.Indexers.BaseIndexer.ConfigureIfOK(String cookies, Boolean isLoggedin, Func`1 onError) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/BaseIndexer.cs:line 259
   at Jackett.Common.Indexers.Partis.ApplyConfiguration(JToken configJson) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/Partis.cs:line 135
   at Jackett.Server.Controllers.IndexerApiController.UpdateConfig(ConfigItem[] config) in /home/vsts/work/1/s/src/Jackett.Server/Controllers/IndexerApiController.cs:line 97
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|19_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope)
   at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger)
   at Microsoft.AspNetCore.Authentication.AuthenticationMiddleware.Invoke(HttpContext context)
   at Jackett.Server.Middleware.CustomExceptionHandler.Invoke(HttpContext httpContext) in /home/vsts/work/1/s/src/Jackett.Server/Middleware/CustomExceptionHandler.cs:line 26
Jackett startup finished in 2.512 s
Adding filter indexer ('type:semi-public' indexer) ...
Adding filter indexer ('type:private' indexer) ...
Adding filter indexer ('type:public' indexer) ...
Adding aggregate indexer ('all' indexer) ...
Loaded 584 indexers in total
Loaded 496 Cardigann indexers: ...
Loading Cardigann indexers from: /config/cardigann/definitions/, /etc/xdg/cardigan/definitions/, /app/Jackett/Definitions
Loaded 88 Native indexers: ..., partis, ...
Loading Native indexers ...
Using HTTP Client: HttpWebClient2
Using FlareSolverr: No
Using proxy: Disabled
App config/log directory: /config/Jackett
Running in Docker: No
File /etc/issue: Ubuntu 18.04.6 LTS \n \l
Jackett variant: CoreLinuxAmdx64
OS version: Unix 5.10.0.9 (64bit OS) (64bit process)
Environment version: 5.0.12 (/app/Jackett/)
Starting Jackett v0.19.275

PS: While Jackett is reporting that is not run in Docker, this install is. It's a LSIO Docker image v0.19.275.
```


### Description

When adding Partis as an indexer (re-added in #12554), the error message "An error occurred while updating this indexer
Object reference not set to an instance of an object." appears.

### Logged Error Messages

```
System.NullReferenceException: Object reference not set to an instance of an object.
   at Jackett.Common.Indexers.Partis.<>c__DisplayClass8_0.<ApplyConfiguration>b__0() in /home/vsts/work/1/s/src/Jackett.Common/Indexers/Partis.cs:line 138
   at Jackett.Common.Indexers.BaseIndexer.ConfigureIfOK(String cookies, Boolean isLoggedin, Func`1 onError) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/BaseIndexer.cs:line 259
   at Jackett.Common.Indexers.Partis.ApplyConfiguration(JToken configJson) in /home/vsts/work/1/s/src/Jackett.Common/Indexers/Partis.cs:line 135
   at Jackett.Server.Controllers.IndexerApiController.UpdateConfig(ConfigItem[] config) in /home/vsts/work/1/s/src/Jackett.Server/Controllers/IndexerApiController.cs:line 97
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeInnerFilterAsync>g__Awaited|13_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeFilterPipelineAsync>g__Awaited|19_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope)
   at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger)
   at Microsoft.AspNetCore.Authentication.AuthenticationMiddleware.Invoke(HttpContext context)
   at Jackett.Server.Middleware.CustomExceptionHandler.Invoke(HttpContext httpContext) in /home/vsts/work/1/s/src/Jackett.Server/Middleware/CustomExceptionHandler.cs:line 26
```

### Screenshots

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
