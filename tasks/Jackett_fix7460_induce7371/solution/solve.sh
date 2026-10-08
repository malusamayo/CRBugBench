#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Indexers/GimmePeers.cs`:

This pull request introduces the defect later reported as "[gimmepeers] Exception (gimmepeers): The string did not match the expected pattern.: Parse error (Config)". The
problem a user observed, and its root cause:

### Environment

**OS**: Windows 10

**.Net Runtime**: [.Net-Core/.Net-Framework/Mono]

**.Net Version**:

**Jackett Version**: 0.13.405.0

**Last Working Jackett Version**:

**Are you using a proxy or VPN?** yes

### Description

I get parse error when I try to configure gimmepeers.

### Logged Error Messages
```
Jackett.Common.IndexerException: Exception (gimmepeers): The string did not match the expected pattern.
 ---> System.Exception: Parse error
 ---> AngleSharp.Dom.DomException: The string did not match the expected pattern.
   at AngleSharp.Dom.QueryExtensions.CreateSelector(INodeList nodes, INode scope, String selectorText)
   at AngleSharp.Dom.QueryExtensions.QuerySelectorAll(INodeList nodes, String selectorText, INode scopeNode)
   at AngleSharp.Dom.Document.QuerySelectorAll(String selectors)
   at Jackett.Common.Indexers.GimmePeers.ProcessPage(List`1 releases, String searchUrl) in d:\a\1\s\src\Jackett.Common\Indexers\GimmePeers.cs:line 147
   --- End of inner exception stack trace ---
   at Jackett.Common.Indexers.BaseWebIndexer.OnParseError(String results, Exception ex) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 830
   at Jackett.Common.Indexers.GimmePeers.ProcessPage(List`1 releases, String searchUrl) in d:\a\1\s\src\Jackett.Common\Indexers\GimmePeers.cs:line 192
   at Jackett.Common.Indexers.GimmePeers.PerformQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\GimmePeers.cs:line 129
   at Jackett.Common.Indexers.BaseIndexer.ResultsForQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 323
   --- End of inner exception stack trace ---
   at Jackett.Common.Indexers.BaseIndexer.ResultsForQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 343
   at Jackett.Common.Indexers.BaseWebIndexer.ResultsForQuery(TorznabQuery query) in d:\a\1\s\src\Jackett.Common\Indexers\BaseIndexer.cs:line 803
   at Jackett.Common.Services.IndexerManagerService.TestIndexer(String name) in d:\a\1\s\src\Jackett.Common\Services\IndexerManagerService.cs:line 220
   at Jackett.Server.Controllers.IndexerApiController.UpdateConfig(ConfigItem[] config) in d:\a\1\s\src\Jackett.Server\Controllers\IndexerApiController.cs:line 110
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
   at Jackett.Server.Middleware.CustomExceptionHandler.Invoke(HttpContext httpContext) in d:\a\1\s\src\Jackett.Server\Middleware\CustomExceptionHandler.cs:line 70
```

This same root cause must be fixed before merging.
REVIEW_EOF
