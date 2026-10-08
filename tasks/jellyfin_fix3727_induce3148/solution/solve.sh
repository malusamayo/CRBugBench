#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Jellyfin.Server.Implementations/Users/UserManager.cs`:

This pull request introduces the defect later reported as "Loading wheel spinning not moving past login/password creation". The
problem a user observed, and its root cause:

**Describe the bug**
Loading wheel spinning not moving past user creation (when installed as a service).

**System (please complete the following information):**
 - OS: Windows 
 - Clients: Browser
 - Browser: Firefox 79
 - Jellyfin Version: 10.6.0


**To Reproduce**
<!-- Steps to reproduce the behavior: -->
1. Clean install Jellyfin 10.6.0 as a service on Windows (after deleting previous data directories)
2. Open the browser and try to create first user.

**Expected behavior**
Create a user and proceed with setting up the libraries

**Logs**
```
[2020-07-20 22:43:04.594 +05:00] [INF] [26] Jellyfin.Api.Auth.CustomAuthenticationHandler: "CustomAuthentication" was not authenticated. Failure message: "Invalid user"
[2020-07-20 22:43:10.607 +05:00] [INF] [20] Jellyfin.Api.Auth.CustomAuthenticationHandler: "CustomAuthentication" was not authenticated. Failure message: "Invalid user"
[2020-07-20 22:43:10.632 +05:00] [INF] [26] Jellyfin.Api.Auth.CustomAuthenticationHandler: "CustomAuthentication" was not authenticated. Failure message: "Invalid user"
[2020-07-20 22:43:10.662 +05:00] [INF] [26] Emby.Server.Implementations.AppBase.BaseConfigurationManager: Saving system configuration
[2020-07-20 22:43:10.667 +05:00] [INF] [26] Emby.Server.Implementations.AppBase.BaseConfigurationManager: Setting cache path: "D:\Portable\Jellyfin-Data\cache"
[2020-07-20 22:43:10.671 +05:00] [INF] [20] Emby.Server.Implementations.EntryPoints.ExternalPortForwarding: Stopping NAT discovery
[2020-07-20 22:43:10.843 +05:00] [INF] [20] Jellyfin.Api.Auth.CustomAuthenticationHandler: "CustomAuthentication" was not authenticated. Failure message: "Invalid user"
[2020-07-20 22:43:10.894 +05:00] [WRN] [20] Jellyfin.Server.Implementations.Users.UserManager: No users, creating one with username "PC-4TR6C2CF$"
[2020-07-20 22:43:10.899 +05:00] [ERR] [20] Microsoft.AspNetCore.Server.Kestrel: Connection id ""0HM1CQGVB48FR"", Request id ""0HM1CQGVB48FR:0000002C"": An unhandled exception was thrown by the application.
System.ArgumentException: Provided username is not valid! (Parameter 'PC-4TR6C2CF$')
   at Jellyfin.Server.Implementations.Users.UserManager.Initialize()
   at Jellyfin.Api.Controllers.StartupController.GetFirstUser()
   at lambda_method(Closure , Object , Object[] )
   at Microsoft.Extensions.Internal.ObjectMethodExecutor.Execute(Object target, Object[] parameters)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.SyncObjectResultExecutor.Execute(IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeActionMethodAsync()
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeNextActionFilterAsync()
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync()
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextResourceFilter>g__Awaited|24_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.Rethrow(ResourceExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.InvokeFilterPipelineAsync()
--- End of stack trace from previous location where exception was thrown ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope)
   at Microsoft.AspNetCore.Routing.EndpointMiddleware.<Invoke>g__AwaitRequestTask|6_0(Endpoint endpoint, Task requestTask, ILogger logger)
   at Microsoft.AspNetCore.Authorization.AuthorizationMiddleware.Invoke(HttpContext context)
   at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)
   at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider)
   at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.Invoke(HttpContext context)
   at Microsoft.AspNetCore.Server.Kestrel.Core.Internal.Http.HttpProtocol.ProcessRequests[TContext](IHttpApplication`1 application)

```

**Additional context**
Installed after emptying the data folder. Tried reinstalling with default directories. Also with local user instead of network service. Couldn't get get it to work as a service. Basic install works as expected.

This same root cause must be fixed before merging.
REVIEW_EOF
