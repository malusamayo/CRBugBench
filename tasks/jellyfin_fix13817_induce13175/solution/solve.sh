#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `MediaBrowser.Providers/Plugins/Tmdb/TmdbExternalUrlProvider.cs`:

This pull request introduces the defect later reported as "Series without a season causes exception". The
problem a user observed, and its root cause:

### Description of the bug

A series without season data parsed from either the filename or folder causes a NullReferenceException.  Seems to be a regression from #13175

Folder structure:
Series library\
--Series name (2000)\
----Episode 1.mkv
----Episode 2.mkv

### Reproduction steps

1. On Master scan in series without season info in either the folder or filename.
2. After scanning, browse the series in your library. 
3. If the series loads, attempt to play an episode.

### What is the current _bug_ behavior?

The series will not load.

### What is the expected _correct_ behavior?

The series is displayed/played.

### Jellyfin Server version.

Master

### Specify commit id

216b0a394a23ac3027a2b2c57ee5f8aee3d7ac4e

### Specify unstable release number

_No response_

### Specify version number

_No response_

### Specify the build version

Dev Server

### Environment

```markdown
- OS: Windows 11
- Plugins: None
```

### Jellyfin logs

```shell
[2025-03-30 22:34:18.717 -04:00] [ERR] [28] Jellyfin.Api.Middleware.ExceptionMiddleware: Error processing request. URL "GET" "/Users/04d000ced85b41dab2528d41fe65d31a/Items/929f28c5466a537de85938ba849ba7d5".
System.NullReferenceException: Object reference not set to an instance of an object.
   at MediaBrowser.Providers.Plugins.Tmdb.TmdbExternalUrlProvider.GetExternalUrls(BaseItem item)+MoveNext() in C:\git\jellyfin\MediaBrowser.Providers\Plugins\Tmdb\TmdbExternalUrlProvider.cs:line 59
   at System.Linq.Enumerable.IEnumerableSelectIterator`2.MoveNext()
   at System.Collections.Generic.SegmentedArrayBuilder`1.AddRange(IEnumerable`1 source)
   at System.Linq.Enumerable.SelectManySingleSelectorIterator`2.ToArray()
   at System.Linq.Enumerable.ToArray[TSource](IEnumerable`1 source)
   at Emby.Server.Implementations.Dto.DtoService.AttachBasicFields(BaseItemDto dto, BaseItem item, BaseItem owner, DtoOptions options) in C:\git\jellyfin\Emby.Server.Implementations\Dto\DtoService.cs:line 746
   at Emby.Server.Implementations.Dto.DtoService.GetBaseItemDtoInternal(BaseItem item, DtoOptions options, User user, BaseItem owner) in C:\git\jellyfin\Emby.Server.Implementations\Dto\DtoService.cs:line 235
   at Emby.Server.Implementations.Dto.DtoService.GetBaseItemDto(BaseItem item, DtoOptions options, User user, BaseItem owner) in C:\git\jellyfin\Emby.Server.Implementations\Dto\DtoService.cs:line 144
   at Jellyfin.Api.Controllers.UserLibraryController.GetItem(Nullable`1 userId, Guid itemId) in C:\git\jellyfin\Jellyfin.Api\Controllers\UserLibraryController.cs:line 99
   at lambda_method5000(Closure, Object)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableObjectResultExecutor.Execute(ActionContext actionContext, IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeActionMethodAsync>g__Awaited|12_0(ControllerActionInvoker invoker, ValueTask`1 actionResultValueTask)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.<InvokeNextActionFilterAsync>g__Awaited|10_0(ControllerActionInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync()
--- End of stack trace from previous location ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeNextResourceFilter>g__Awaited|25_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.Rethrow(ResourceExecutedContextSealed context)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.InvokeFilterPipelineAsync()
--- End of stack trace from previous location ---
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope)
   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.<InvokeAsync>g__Awaited|17_0(ResourceInvoker invoker, Task task, IDisposable scope)
   at Jellyfin.Api.Middleware.ServerStartupMessageMiddleware.Invoke(HttpContext httpContext, IServerApplicationHost serverApplicationHost, ILocalizationManager localizationManager) in C:\git\jellyfin\Jellyfin.Api\Middleware\ServerStartupMessageMiddleware.cs:line 41
   at Jellyfin.Api.Middleware.WebSocketHandlerMiddleware.Invoke(HttpContext httpContext, IWebSocketManager webSocketManager) in C:\git\jellyfin\Jellyfin.Api\Middleware\WebSocketHandlerMiddleware.cs:line 33
   at Jellyfin.Api.Middleware.IPBasedAccessValidationMiddleware.Invoke(HttpContext httpContext, INetworkManager networkManager) in C:\git\jellyfin\Jellyfin.Api\Middleware\IpBasedAccessValidationMiddleware.cs:line 36
   at Jellyfin.Api.Middleware.LanFilteringMiddleware.Invoke(HttpContext httpContext, INetworkManager networkManager, IServerConfigurationManager serverConfigurationManager) in C:\git\jellyfin\Jellyfin.Api\Middleware\LanFilteringMiddleware.cs:line 37
   at Microsoft.AspNetCore.Authorization.AuthorizationMiddleware.Invoke(HttpContext context)
   at Jellyfin.Api.Middleware.QueryStringDecodingMiddleware.Invoke(HttpContext httpContext) in C:\git\jellyfin\Jellyfin.Api\Middleware\QueryStringDecodingMiddleware.cs:line 36
   at Swashbuckle.AspNetCore.ReDoc.ReDocMiddleware.Invoke(HttpContext httpContext)
   at Swashbuckle.AspNetCore.SwaggerUI.SwaggerUIMiddleware.Invoke(HttpContext httpContext)
   at Swashbuckle.AspNetCore.Swagger.SwaggerMiddleware.Invoke(HttpContext httpContext, ISwaggerProvider swaggerProvider)
   at Microsoft.AspNetCore.Authentication.AuthenticationMiddleware.Invoke(HttpContext context)
   at Jellyfin.Api.Middleware.RobotsRedirectionMiddleware.Invoke(HttpContext httpContext) in C:\git\jellyfin\Jellyfin.Api\Middleware\RobotsRedirectionMiddleware.cs:line 43
   at Jellyfin.Api.Middleware.LegacyEmbyRouteRewriteMiddleware.Invoke(HttpContext httpContext) in C:\git\jellyfin\Jellyfin.Api\Middleware\LegacyEmbyRouteRewriteMiddleware.cs:line 51
   at Microsoft.AspNetCore.ResponseCompression.ResponseCompressionMiddleware.InvokeCore(HttpContext context)
   at Jellyfin.Api.Middleware.ResponseTimeMiddleware.Invoke(HttpContext context, IServerConfigurationManager serverConfigurationManager) in C:\git\jellyfin\Jellyfin.Api\Middleware\ResponseTimeMiddleware.cs:line 66
   at Jellyfin.Api.Middleware.ExceptionMiddleware.Invoke(HttpContext context) in C:\git\jellyfin\Jellyfin.Api\Middleware\ExceptionMiddleware.cs:line 55
```

### FFmpeg logs

```shell

```

### Client / Browser logs

_No response_

### Relevant screenshots or videos

_No response_

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
