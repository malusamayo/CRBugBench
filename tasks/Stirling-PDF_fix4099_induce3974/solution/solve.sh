#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/core/src/main/java/stirling/software/SPDF/controller/api/misc/StampController.java`:

This pull request introduces the defect later reported as "[Bug]:  Stamp PDF - select text type raise a NullPointerException because "stampImage" is null". The
problem a user observed, and its root cause:

### Installation Method

Docker

### The Problem

Select the Stamp PDF tool
Enter the following informations :
* add a pdf file
* set `Stamp Type` to text (selected by default, you can reselect it again)
* enter a string in `Stamp Text`
* leave the other parameters as-is
Then validate

The following error will occur :
```
Error

Internal Server Error:jakarta.servlet.ServletException: Request processing failed: java.lang.NullPointerException: Cannot invoke "org.springframework.web.multipart.MultipartFile.getOriginalFilename()" because "stampImage" is null
```
The full stack trace is available lower.

Interestingly, if you switch the stamp type to `image`, select an image file, and switch back the type to `text`, it will work correctly without error, the text will be added as a stamp, while ignoring the image.

It seems the internal code always expect an image to be present, ignoring the selected type.

### Version of Stirling-PDF

App Version: 1.1.1

### Last Working Version of Stirling-PDF

_No response_

### Page Where the Problem Occurred

https://spdf.domain.tld/stamp

### Docker Configuration

```txt

```

### Relevant Log Output

```txt
Full stack trace of the error

java.lang.NullPointerException: Cannot invoke "org.springframework.web.multipart.MultipartFile.getOriginalFilename()" because "stampImage" is null
	at stirling.software.SPDF.controller.api.misc.StampController.addStamp(StampController.java:73)
	at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:258)
	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:191)
	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:118)
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:986)
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:891)
	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1089)
	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:979)
	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1014)
	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:914)
	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:547)
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:885)
	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:614)
	at org.eclipse.jetty.ee10.servlet.ServletHolder.handle(ServletHolder.java:736)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$ChainEnd.doFilter(ServletHandler.java:1622)
	at org.eclipse.jetty.ee10.websocket.servlet.WebSocketUpgradeFilter.doFilter(WebSocketUpgradeFilter.java:195)
	at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1594)
	at stirling.software.SPDF.config.MetricsFilter.doFilterInternal(MetricsFilter.java:46)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
	at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1594)
	at org.springframework.web.servlet.resource.ResourceUrlEncodingFilter.doFilter(ResourceUrlEncodingFilter.java:66)
	at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1594)
	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
	at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1594)
	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
	at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1594)
	at org.springframework.web.filter.ServerHttpObservationFilter.doFilterInternal(ServerHttpObservationFilter.java:114)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
	at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1594)
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
	at org.eclipse.jetty.ee10.servlet.FilterHolder.doFilter(FilterHolder.java:205)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$Chain.doFilter(ServletHandler.java:1594)
	at org.eclipse.jetty.ee10.servlet.ServletHandler$MappedServlet.handle(ServletHandler.java:1555)
	at org.eclipse.jetty.ee10.servlet.ServletChannel.dispatch(ServletChannel.java:823)
	at org.eclipse.jetty.ee10.servlet.ServletChannel.handle(ServletChannel.java:440)
	at org.eclipse.jetty.ee10.servlet.ServletHandler.handle(ServletHandler.java:470)
	at org.eclipse.jetty.security.SecurityHandler.handle(SecurityHandler.java:575)
	at org.eclipse.jetty.ee10.servlet.SessionHandler.handle(SessionHandler.java:717)
	at org.eclipse.jetty.server.handler.ContextHandler.handle(ContextHandler.java:1071)
	at org.eclipse.jetty.server.Handler$Wrapper.handle(Handler.java:740)
	at org.eclipse.jetty.server.handler.EventsHandler.handle(EventsHandler.java:81)
	at org.eclipse.jetty.server.Server.handle(Server.java:182)
	at org.eclipse.jetty.server.internal.HttpChannelState$HandlerInvoker.run(HttpChannelState.java:678)
	at org.eclipse.jetty.server.internal.HttpConnection.onFillable(HttpConnection.java:416)
	at org.eclipse.jetty.io.AbstractConnection$ReadCallback.succeeded(AbstractConnection.java:322)
	at org.eclipse.jetty.io.FillInterest.fillable(FillInterest.java:99)
	at org.eclipse.jetty.io.SelectableChannelEndPoint$1.run(SelectableChannelEndPoint.java:53)
	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.runTask(AdaptiveExecutionStrategy.java:480)
	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.consumeTask(AdaptiveExecutionStrategy.java:443)
	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.tryProduce(AdaptiveExecutionStrategy.java:293)
	at org.eclipse.jetty.util.thread.strategy.AdaptiveExecutionStrategy.run(AdaptiveExecutionStrategy.java:201)
	at org.eclipse.jetty.util.thread.ReservedThreadExecutor$ReservedThread.run(ReservedThreadExecutor.java:311)
	at org.eclipse.jetty.util.thread.QueuedThreadPool.runJob(QueuedThreadPool.java:981)
	at org.eclipse.jetty.util.thread.QueuedThreadPool$Runner.doRunJob(QueuedThreadPool.java:1211)
	at org.eclipse.jetty.util.thread.QueuedThreadPool$Runner.run(QueuedThreadPool.java:1166)
	at java.base/java.lang.Thread.run(Thread.java:1583)
```

### Additional Information

_No response_

### Browsers Affected

_No response_

### No Duplicate of the Issue

- [x] I have verified that there are no existing issues raised related to my problem.

This same root cause must be fixed before merging.
REVIEW_EOF
