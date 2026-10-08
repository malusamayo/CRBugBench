#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Servers/HttpSys/src/NativeInterop/RequestQueue.cs`:

This pull request introduces the defect later reported as "HttpSysRequestDelegationFeature - DelegationRule throws NullReferenceException on Dispose". The
problem a user observed, and its root cause:

<!--

More information on our issue management policies can be found here: https://aka.ms/aspnet/issue-policies

Please keep in mind that the GitHub issue tracker is not intended as a general support forum, but for reporting **non-security** bugs and feature requests.

If you believe you have an issue that affects the SECURITY of the platform, please do NOT create an issue and instead email your issue details to secure@microsoft.com. Your report may be eligible for our [bug bounty](https://www.microsoft.com/en-us/msrc/bounty-dot-net-core) but ONLY if it is reported through email.
For other types of questions, consider using [StackOverflow](https://stackoverflow.com).

-->

### Describe the bug
When disposing a DelegationRule, if the call to HttpCloseUrlGroup within UrlGroup.Dispose() fails then a NullReferenceException happens because _logger is not initialized in the constructor used by the HttpSysRequestDelegationFeature.

### To Reproduce

```c#
namespace Sample
{
    public class Startup
    {
        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostApplicationLifetime lifetime, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            
            var delegator = app.ServerFeatures.Get<IServerDelegationFeature>();
            var rule = delegator.CreateDelegationRule("DefaultAppPool", "http://*:80/");
            rule.Dispose();
        }
    }
}
```

### Exceptions (if any)

```
System.AggregateException: One or more errors occurred. (Value cannot be null. (Parameter 'logger'))
---> System.ArgumentNullException: Value cannot be null. (Parameter 'logger')
at Microsoft.Extensions.Logging.LoggerExtensions.Log(ILogger logger, LogLevel logLevel, EventId eventId, Exception exception, String message, Object[] args)
at Microsoft.Extensions.Logging.LoggerExtensions.LogError(ILogger logger, EventId eventId, String message, Object[] args)
at Microsoft.AspNetCore.Server.HttpSys.UrlGroup.Dispose()
at Microsoft.AspNetCore.Server.HttpSys.DelegationRule.Dispose()
```

This same root cause must be fixed before merging.
REVIEW_EOF
